FOSDEM maps
===========

This is the port of the FOSDEM campus to c3nav.de data. 

# TODO (in descending order of urgency)
## Align the source maps
The source maps need to be fit to the correct scale and location so they line up with the rest of the map.
This is so you can tick a box and see them in the editor.

In the github repo, there's files like maps/sources/k-1.png.json, with contents like:
<pre>"bounds": [[0.0, 0.0], [100.0, 100.0]]</pre>

You need to change those coordinates to make things look right by editing the json, running loadmap, refreshing the editor and finally doing a visual check.

## Fill in rooms and main pathways
This needs to happen in http://nav.fosdem.org/editor . 

## Add 2017 details (stands and devrooms mainly)

# Play with it locally

    $ mkdir -p fosdem-map-data/map
    $ cd fosdem-map-data/map
    $ git clone git@github.com:FOSDEM/maps.git
    $ docker pull c3nav/c3nav
    $ cd ..
    $ docker run --rm --name fosdem-map -v $(pwd):/data c3nav/c3nav loadmap
    $ docker run --rm --name fosdem-map -v $(pwd):/data c3nav/c3nav build
    $ docker run --rm --name fosdem-map -p 8042:8000 -v $(pwd):/data c3nav/c3nav runlocal

Maps should now be available at <http://localhost:8042/>.

Use the editor at <http://localhost:8042/editor/>.

When you're done adding a feature, run

    $ docker run --rm --name fosdem-map -v $(pwd):/data c3nav/c3nav dumpmap

Then commit the changes.

# nav.fosdem.org
To allow this server to act as nav.fosdem.org and use the fosdem maps, we created a file named `~/.c3nav.cfg`:
<pre>
[c3nav]
public_packages=map.fosdem.org
[django]
hosts = nav.fosdem.org
</pre>

A c3nav development server is available in a tmux session for now on http://nav.fosdem.org:8000 .
