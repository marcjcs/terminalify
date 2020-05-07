#!/usr/bin/env sh

set -e

yarn build

cd dist

printf -v date '%(%d/%m/%Y %R)T\n' -1
message="Deploy - $date"
git init
git add -A
git commit -m "$message"

git push -f git@github.com:marcjcs/terminalify.git master:gh-pages

cd -