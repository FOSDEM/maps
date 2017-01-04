FOSDEM maps
===========

This should soon contain the port of the FOSDEM campus to c3nav.de data. 

To test:

    $ git clone git@github.com:FOSDEM/maps.git
    $ docker pull c3nav/c3nav
    $ cd maps
    $ docker run --rm --name fosdem-map -v $(pwd):/data c3nav/c3nav loadmap
    $ docker run --rm --name fosdem-map -v $(pwd):/data c3nav/c3nav build
    $ docker run --rm --name fosdem-map -p 8042:8000 -v $(pwd):/data c3nav/c3nav runlocal

Maps should now be available at http://localhost:8042/.
