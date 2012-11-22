Concepts and Components of Demetrius
================================================================================

The Stacks
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In a physical library, the Stacks are where all the books are kept. Under
Demetrius, the Stacks are the main storage database. Access to the Stacks is
managed by a program called the Archivist. The Stacks are implemented as a Riak
database, and the Archivist is a Django application.

The primary mission of the Archivist is storage and retrieval of content items.
The Archivist implements a permissions layer above the Stacks to manage access,
and manages a version history for each content item added to the Stacks. The
Archivist has no knowledge of the content of the items *per se*, but treats them
all as generic Items to be managed.

Before the Archivist stores any item into the Stacks, it must be able to
classify the item by its ItemType, and verify its validity as an item of that
type.

An ItemType is any data structure that can be validated programmatically. It
could be a JSON object, or an XML tree conforming to a specific schema.

The function or class that performs the validation is called a Validator.
Demetrius 1.0 will ship with 3 validators included. You may install others. The
three are:

* SimpleFeed: Validates simple syndication feeds such as Atom and the various
  versions of RSS. The validator basically accepts anything that can be parsed
  by feedparser.py.
* JSONSchema: Checks JSON data structures for conformance with a declared JSON
  schema.
* XMLSchema: Checks XML data structures for conformance with a declared XML
  schema.

The Catalogue
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
The Catalogue is the search index that allows you to find any content in the
library. It is implemented as a Solr 4 cluster.

Indexers take content items from the Stacks and add them to the Catalogue,
usually by extracting or generating metadata that will later be used for
searching. Indexers are implemented as Celery background tasks.

The Researcher is the server process that exposes the web API giving you access
to the Catalogue. It is implemented as a Django application.

The Catalogue is entirely internal to Demetrius. Any clients wishing to search
the Catalogue must do so through the Researcher. The Solr search service is
*not* directly exposed to Demetrius users. Nothing is added to the
Catalogue except by an Indexer.

Archetypes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
An Archetype is a "well-known" data structure, that is, a data structure that is
compatible across a large number of platforms, services, or tools. Archetypes
represent the formats preferred by *consumers* of the content in your library.

Archetypes are the hub of the information architecture in Demetrius. The
Catalogue is optimized for searching Archetypes, with detailed Archetype
metadata baked into the search schema. Because Archetypes are the preferred
format for consumption, Demetrius employs *Scribes* to transcribe content items
into Archetypes. The transcribed items are stored in the Stacks along with
the original.

As the owner of your own Library of Alexandria, the information architecture is
completely under your control. You can define your own Archetypes and change the
search schema to suit your needs. You get to decide which data structures you
want to become the *lingua franca* of your own library.

However, since defining an entire information architecture can be burdensome and
difficult, Demetrius ships with its own information architecture based on the `IPTC
News Architecture`_.  Demetrius also implements Archetypes compatible with the
Atom syndication format (`RFC 4287`_) for simpler needs. You are not *required* to
use either set of Archetypes in your own applications, but our intent is that
most applications should be able to use this architecture "out of the box".

More detail is available in the :doc:`information-architecture` section.

.. _RFC 4287: http://tools.ietf.org/html/rfc4287
.. _IPTC News Architecture: http://www.iptc.org/site/News_Exchange_Formats/Developers/

Curators and Spectators
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
As a librarian, Demetrius does not produce content, but merely stores and
catalogs it. All the content in the library must come from some external source.
Such an external source is sometimes called a *Codex*.

Some process is required to pull content from a Codex and submit it to Demetrius
for cataloging. Such a process is called a *Curator*. From the perspective of
Demetrius, you can think of a Curator as a *producer* of content. Curators
require special access permissions to put items into the library, and Curators
tend to work directly with ItemTypes rather than Archetypes.

Demetrius does not provide Curators. You will need to create them yourself.

.. note::
    A generic feed curator would be very useful and not terribly difficult to
    create. Should one ship with Demetrius? Should we ship it separately as a
    "contrib" tool?

At the opposite end are readers or consumers of content. Demetrius calls these
*Spectators*. Spectators may have varying levels of access based on permissions,
but even anonymous Spectators have some basic access to the library. Spectators
typically work with Archetypes rather than directly with ItemTypes.

Workflow: Following an Item through the system
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
**1. Codex creates item.** An Item begins life somewhere outside of Alexandria,
created in an off-the-shelf publishing tool such as Wordpress, or a
purpose-built tool that you have created yourself.

**2. Curator submits item.** After its creation, the Item is submitted to the
Archivist by some process of your own design (we call such a process a Curator).

**3. Archivist stores item.** The Archivist receives from the Curator a request
to store an Item of a particular ItemType. The Archivist then looks up the
appropriate Validator for that ItemType and asks it to check the validity of the
Item. If the Item passes the validity check, it is stored in the Stacks, and a
success response code is returned to the Curator, along with the URL assigned to
the new Item.

**4. Archivist alerts Scribe.** After storing the Item, the Archivist sends an
Item-Updated message to the Scribe.

**5. Scribe transcribes item into Archetypes.** The Scribe receives the
Item-Updated message and retrieves the Item from the Stacks (via the Archivist).
The Scribe then looks up all registered transcription functions for the ItemType
and executes them. The transcription functions take the Item as input, and
generate as output a new rendition of the Item conforming to a specific
Archetype. Each transcription function then stores its output back into the
Stacks (via the Archivist), linking it to the original input Item.

**6. Scribe alerts Indexer.** When transcription is complete, the Scribe sends
an Item-Updated message to the Indexer for each Archetype to which the Item has
been transcribed.

**7. Indexer catalogs item.** The Indexer receives the Item-Updated message and
retrieves the Item from the Stacks (via the Archivist). Finally, the Item is
indexed into the Catalogue, where it becomes available for search and general
consumption.

**8. Spectator accesses item.** API clients seeking to discover content send
queries to the Researcher. The Researcher searches the Catalogue for Items
matching the client's query.  Depending on the nature of the query, the
Researcher may fetch the requested Item from the Stacks (via the Archivist) to
return it to the client, or it may return only some metadata, allowing the
client to fetch the Item from the Archivist in some future request.
