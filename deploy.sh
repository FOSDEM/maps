#!/usr/bin/env bash

set -ex

# for use on nav.fosdem.org

cd ~/maps
git remote update
git reset --hard origin/master

cd ~/c3nav
source env/bin/activate
python ./manage.py loadmap
python ./manage.py build
