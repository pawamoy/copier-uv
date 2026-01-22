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
uvx --from taskipy task --list
echo
if [ -z "${SKIP_SETUP:-}" ]; then
    echo ">>> Setting up Python environment"
    uvx --from taskipy task setup
    echo
    echo ">>> Listing tasks again"
    uvx --from taskipy task --list
    echo
fi
echo ">>> Formatting/linting and asserting there are no changes"
uvx --from taskipy task fix
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
echo ">>> Running CI checks"
uvx --from taskipy task ci
echo
echo ">>> Running tests"
uvx --from taskipy task test
echo
echo ">>> Creating second commit (fix)"
touch empty
git add empty
git commit -m "fix: Fix all bugs"
echo
echo ">>> Updating changelog"
uvx --from taskipy task changelog
echo
echo ">>> Checking changelog's contents"
grep '0\.1\.0' CHANGELOG.md
grep 'Features' CHANGELOG.md
grep 'Bug Fixes' CHANGELOG.md
echo
echo ">>> Cleaning directory"
uvx --from taskipy task clean
