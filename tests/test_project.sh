#!/usr/bin/env bash
set -eu

. tests/helpers.sh
output=tests/tmp

echo
echo "///////////////////////////////////////////"
echo "             GENERATING PROJECT"
echo "///////////////////////////////////////////"
echo
generate "${PWD}" "${output}"
cd "${output}"
cat .copier-answers.yml
git init .
git remote add origin git@github.com:oedokumaci/oedokumaci-testing

echo
echo "///////////////////////////////////////////"
echo "             TESTING PROJECT"
echo "///////////////////////////////////////////"
echo
echo ">>> Creating initial commit (feat)"
uv run python <<EOF
import re
with open(".copier-answers.yml") as file:
    answers = file.read()
with open(".copier-answers.yml", "w") as file:
    file.write(re.sub(r"(_commit: [a-z0-9.]+)(-.*|$)", r"\1", answers))
EOF
cat .copier-answers.yml
git add -A .
git commit -am "feat: Initial commit"
git tag -m "" -a 0.1.0
echo
echo ">>> Listing available tasks"
uvx task --list
echo
if [ -z "${SKIP_SETUP:-}" ]; then
    echo ">>> Setting up Python environment"
    uvx task setup
    echo
    echo ">>> Listing tasks again"
    uvx task --list
    echo
fi
echo ">>> Formatting and asserting there are no changes"
uvx task format
diff="$(git status --porcelain=v1 2>/dev/null)"
if [ -n "${diff}" ]; then
    echo
    echo "Status:"
    echo "${diff}"
    echo "Diff:"
    git diff
    exit 1
fi
echo
echo ">>> Running quality checks"
uvx task check
echo
echo ">>> Running tests"
uvx task test
echo
echo ">>> Creating second commit (fix)"
touch empty
git add empty
git commit -m "fix: Fix all bugs"
echo
echo ">>> Updating changelog"
uvx task changelog
echo
echo ">>> Checking changelog's contents"
grep '0\.1\.0' CHANGELOG.md
grep 'Features' CHANGELOG.md
grep 'Bug Fixes' CHANGELOG.md
echo
echo ">>> Cleaning directory"
uvx task clean
