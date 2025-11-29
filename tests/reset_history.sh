#!/usr/bin/env bash
cd tests/tmp || exit 1
rm -rf .git
git init .
if [ -n "${GH_TOKEN}" ]; then
    git remote add origin https://oedokumaci:${GH_TOKEN}@github.com/oedokumaci/oedokumaci-testing.git
else
    git remote add origin git@github.com:oedokumaci/oedokumaci-testing.git
fi
git add -A
git commit -m "feat: Initial commit"
git tag -m "" -a 0.1.0
git push origin main -f --tags
