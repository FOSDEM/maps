#!/usr/bin/env bash

set -ex

# for use on nav.fosdem.org

# FIXME: make this a function and remove this duplication
cd ~/data/map/maps
git remote update
git reset --hard origin/master

cd ~/data/map/maps-2017
git remote update
git reset --hard origin/master

cd ~/data/map/maps-2017-sat
git remote update
git reset --hard origin/master

cd ~/data/map/maps-2017-sun
git remote update
git reset --hard origin/master


cd ~/c3nav
source env/bin/activate
cd src
python ./manage.py migrate
python ./manage.py loadmap -y
python ./manage.py rendermap
python ./manage.py buildgraph
