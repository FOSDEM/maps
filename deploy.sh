#!/usr/bin/env bash

set -ex

# for use on nav.fosdem.org

cd ~/data/map/maps
git remote update
git reset --hard origin/master

cd ~/c3nav
source env/bin/activate
cd src
python ./manage.py loadmap -y
python ./manage.py rendermap
python ./manage.py buildgraph
