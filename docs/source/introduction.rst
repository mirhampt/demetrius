Concepts and Components of Demetrius
================================================================================

ItemTypes and Validators
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
An ItemType is any data structure that can be validated programmatically. The
function or class that performs the validation is called a Validator.
ItemTypes and their Validators are registered with Demetrius. Demetrius
will not store any data unless it has a defined ItemType and passes
validation by the Validator for that ItemType.

The Archivist and the Stacks
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
The Stacks in a physical library are where all the books are kept. Under
Demetrius, the Stacks are the main storage database. It is implemented as a Riak
database.

The Archivist is the server process that exposes the web API giving clients
access to the Stacks. It is implemented as a Django application.

The Stacks are entirely internal to Demetrius. All interactions with the Stacks
must be mediated by the Archivist, which implements safeguards and protocols to
ensure that each content item and its version history remains consistent.

The Archivist API requires that all content items submitted for storage have an
assigned ItemType and must pass the Validator for that ItemType.

Indexers, The Researcher, and the Catalogue
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
Within the context of Demetrius, an Archetype is any ItemType that has an
Indexer registered for it. Having an Indexer means the content is added to the
Catalogue as well as the Stacks and thus is available "end-to-end".

More broadly, an Archetype is a "well-known" data structure, that is, a data
structure that is compatible across a large number of platforms, services, or
tools. As the owner of your own Library of Alexandria, you get to decide which
data structures you want to become the *lingua franca* of your own library. 

However, since defining an entire information architecture can be burdensome and
difficult, Demetrius ships with its own set of Archetypes based on the `IPTC
News Architecture`_.  Demetrius also implements Archetypes compatible with the
Atom syndication format (`RFC 4287`_) for simpler needs. You are not required to
use either set of Archetypes in your own applications.

.. _RFC 4287: http://tools.ietf.org/html/rfc4287
.. _IPTC News Architecture: http://www.iptc.org/site/News_Exchange_Formats/Developers/

Scribes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
A Scribe is a class that transforms (or *transcribes*) data structures from one
format to another. A Scribe is registered for a specific ItemType, and
advertises the ability to transform items of that ItemType into items of an
Archetype. (Technically, a Scribe could translate from one ItemType to
another ItemType that was not an Archetype, but that is a useless task in
the context of Demetrius.)

Scribes are implemented as Celery background tasks.

Workflow: Following an Item through the system
================================================================================
An Item begins life somewhere outside of Alexandria, created in an off-the-shelf
publishing tool such as Wordpress, or a purpose-built tool that you have created
yourself. After its creation, the Item is submitted to the Archivist by some
process of your own design (we call such a process a Curator).

The Archivist receives from the Curator a request to store an Item of a
particular ItemType. The Archivist then looks up the appropriate Validator for
that ItemType and asks it to check the validity of the Item. If the Item passes
the validity check, it is stored in the Stacks, and a success response code is
returned to the Curator, along with the URL assigned to the new Item.

After storing the Item, the Archivist sends an Item-Updated message to the
Scribe.

The Scribe receives the Item-Updated message and retrieves the Item from the
Stacks (via the Archivist). The Scribe then looks up all registered
transcription functions for the ItemType and executes them. The transcription
functions take the Item as input, and generate as output a new rendition of the
Item conforming to a specific Archetype. Each transcription function then stores
its output back into the Stacks (via the Archivist), linking it to the original
input Item.

When transcription is complete, the Scribe sends an Item-Updated message to the
Indexer for each Archetype to which the Item has been transcribed.

The Indexer receives the Item-Updated message and retrieves the Item from the
Stacks (via the Archivist). The Indexer MAY then consult one or more Analysts to
add metadata to the Item for indexing. Finally, the Item is indexed into the
Catalogue, where it becomes available for general consumption.

API clients seeking to discover content send queries to the Researcher. The
Researcher searches the Catalogue for Items matching the client's query.
Depending on the nature of the query, the Researcher may fetch the requested
Item from the Stacks (via the Archivist) to return it to the client, or it may
return only some metadata, allowing the client to fetch the Item from the
Archivist in some future request.
