Concepts and Components of Demetrius
================================================================================

ContentClasses and Validators
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
A ContentClass is any data structure that can be validated programmatically. The
function or class that performs the validation is called a Validator.
ContentClasses and their Validators are registered with Demetrius. Demetrius
will not store any data unless it has a defined ContentClass and passes
validation by the Validator for that ContentClass.

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
assigned ContentClass and must pass the Validator for that ContentClass.

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
Within the context of Demetrius, an Archetype is any ContentClass that has an
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
format to another. A Scribe is registered for a specific ContentClass, and
advertises the ability to transform items of that ContentClass into items of an
Archetype. (Technically, a Scribe could translate from one ContentClass to
another ContentClass that was not an Archetype, but that is a useless task in
the context of Demetrius.)

