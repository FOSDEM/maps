FOSDEM maps
===========

This should soon contain the port of the FOSDEM campus to c3nav.de data. 

To test locally:

    $ git clone git@github.com:FOSDEM/maps.git
    $ docker pull c3nav/c3nav
    $ cd maps
    $ docker run --rm --name fosdem-map -v $(pwd):/data c3nav/c3nav loadmap
    $ docker run --rm --name fosdem-map -v $(pwd):/data c3nav/c3nav build
    $ docker run --rm --name fosdem-map -p 8042:8000 -v $(pwd):/data c3nav/c3nav runlocal

Maps should now be available at <http://localhost:8042/>.

Use the editor at <http://localhost:8042/editor/>.

When you're done adding a feature, run

    $ docker run --rm --name fosdem-map -v $(pwd):/data c3nav/c3nav dumpmap

Then commit the changes.

# nav.fosdem.org
To allow this server to act as nav.fosdem.org, we created a file named `~/.c3nav.cfg`:
<pre>
[django]
hosts = nav.fosdem.org
</pre>

A c3nav development server is available in a tmux session for now on http://nav.fosdem.org:8000 .
