#!/usr/bin/env bash

set -ex

# for use on nav.fosdem.org

cd ~/maps
git remote update
git reset --hard origin/master

cp -r map ~/c3nav/src/data

cd ~/c3nav
source env/bin/activate
cd src
python ./manage.py loadmap -y
python ./manage.py rendermap
python ./manage.py buildgraph
