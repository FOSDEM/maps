#!/usr/bin/env bash

set -ex

# for use on nav.fosdem.org

cd ~/data/map/maps
git remote update
git reset --hard origin/master

cd ~/data
docker run --rm --name fosdem-map --env LOCAL_USER_ID=$(id -u) -v $(pwd):/data -v $(pwd)/c3nav.cfg:/etc/c3nav/c3nav.cfg c3nav/c3nav load_build
