#!/usr/bin/env bash
cd tests/tmp || exit 1
rm -rf .git
git init .
if [ -n "${GH_TOKEN}" ]; then
    git remote add origin https://pawamoy:${GH_TOKEN}@github.com/pawamoy/pawamoy-testing.git
else
    git remote add origin git@github.com:pawamoy/pawamoy-testing.git
fi
git add -A
git commit -m "feat: Initial commit"
git tag 0.1.0
git push origin main -f --tags
