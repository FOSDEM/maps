FOSDEM maps
===========

This is the port of the FOSDEM campus to c3nav.de data. We gather on irc.freenode.net#fosdem-nav to coordinate the work.

# TODO (in descending order of urgency)
## Align the source maps
The source maps need to be fit to the correct scale and location so they line up with the rest of the map.
This is so you can tick a box and see them in the editor as underlays, or "sources" as c3nav calls them.

Just add the image you want to add to a source folder in your map package and a file with the named <imagefilename>.json. the json files describes where in the editor the image should be displayed. see the link for details. :) if you don't have any map/dwg file of the building, try to obtain rescue plans.

In the github repo, there's files like maps/sources/k-1.png.json, with contents like:
<pre>"bounds": [[0.0, 0.0], [100.0, 100.0]]</pre>

You need to change those coordinates to make things look right by editing the json, running loadmap, refreshing the editor and finally doing a visual check.

## Fill in rooms and main pathways
This needs to happen in http://nav.fosdem.org/editor . 

### Overlaps
 What about connecting two outside areas properly? We have two fairly complex shapes. They're on the same level and should have been one continuous area in the first place.
Just overlap them. This is also often done in the 33c3 maps with rooms, obstacles, buildings… anything that is of the same type and overlaps will be merged on map/graph creation (with a few exceptions like elevator levels). 

### Levels
    The FOSDEM site as you may know is built on a slope: level 0 of the
    campus main street is both level 0 and level 1 of the same building.
    Does c3nav provide for that? How do we best enter information in that
    situation?

Yes you can and yes it provides. :)

To connect levels, you need an intermedate level anyway. Thats a level that contains no buildings but rooms that represent staircases, escalators and slopes. these intermediate levels are connected to non-intermediate levels by levelconnectors, which are polygons belonging to mor than one level. (just look at level 0-1 oder 1-2 in c3nav-33c3 for more details… btw, if you want to go completely crazy look at the stairs and interwithin hall 1 and 2). These “intermediate rooms“ are slopes, if you dont add anything else to it. They only become escalators when you overlap them with an escalator area or if you add steps to it.

Some things to consider:
- Steps are lines. c3nav has to now in which direction the steps goes, so steps have to be always drawn from left to right (facing upstairs). The lower side of the step line is marked by a dark „shadow“ in the editor (it only appears after finishing drawing the step).
- Escalators have a property whether they are going upwards or downwards. However, c3nav still needs to now, which side of the elevator is “up”. To do so, draw an „escalator slope“ in the middle of the escalator, overlapping it. It works exactly like a stair, and c3nav determines the „slope“ of an escalantor by the angle of the nearest escalator slope.
- Steps and escalators can be everywhere, not only on intermediate levels.
- Each level has an altitude. These don't have an important meaning yet but are used to indicate the order of the levels.
- Elevators however don't appear in intermediate levels. They are created by first adding an escalator and then drawing an „escalator levels“ on each level on which the escalator has en exit. This allows diagonal escalators, multiple exits on one level or plain teleportation devices. For multiple exits on one level, you can override the altitude of the elevator level so c3nav nows which „station“ is higher. (used in 33c3 maps for the accessibility elevator, whic hhas to exits on level 3 and 4. for example: level 3 has an altitude of 3.0, the two exits have the altitudes 3.0 and 3.1 (or something like that, i'm currently on a train and can't verify the exact numbers)

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
