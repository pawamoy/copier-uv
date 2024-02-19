#!/usr/bin/env bash
set -eu

. tests/helpers.sh
output=tests/tmp
make() {
    ./scripts/make "$@"
}

echo
echo "///////////////////////////////////////////"
echo "             GENERATING PROJECT"
echo "///////////////////////////////////////////"
echo
generate "${PWD}" "${output}"
cd "${output}"
cat .copier-answers.yml
git init .
git remote add origin git@github.com:pawamoy/pawamoy-testing

echo
echo "///////////////////////////////////////////"
echo "             TESTING PROJECT"
echo "///////////////////////////////////////////"
echo
echo ">>> Creating initial commit (feat)"
python <<EOF
import re
with open(".copier-answers.yml") as file:
    answers = file.read()
with open(".copier-answers.yml", "w") as file:
    file.write(re.sub(r"(_commit: [^-]+)-.*", r"\1", answers))
EOF
cat .copier-answers.yml
git add -A .
git commit -am "feat: Initial commit"
git tag v0.1.0
echo
if [ -z "${SKIP_SETUP:-}" ]; then
    echo ">>> Setting up Python environments"
    make setup
    echo
fi
echo ">>> Running initial quality checks"
make check
echo
echo ">>> Formatting, and re-running quality checks"
make format check-quality
echo
echo ">>> Running tests"
make test
echo
echo ">>> Creating second commit (fix)"
touch empty
git add empty
git commit -m "fix: Fix all bugs"
echo
echo ">>> Updating changelog and releasing version"
make changelog release version=0.1.1
echo
echo ">>> Checking changelog's contents"
make run failprint -- grep 'v0\.1\.0' CHANGELOG.md
make run failprint -- grep 'v0\.1\.1' CHANGELOG.md
make run failprint -- grep 'Features' CHANGELOG.md
make run failprint -- grep 'Bug Fixes' CHANGELOG.md
