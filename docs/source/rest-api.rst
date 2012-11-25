The REST API exported by Demetrius
================================================================================

.. note:: See opensearch.org_ for some standards we should implement.

.. _opensearch.org: http://www.opensearch.org/

.. note::

    The structure of the Catalogue is dependent on your information
    architecture. This document describes the default information architecture
    that ships with Demetrius. If you have customized your information
    architecture, you must provide your own docs!


Resources:

`/` 
    API service discovery document. List of major sub-services in the API.

`/content/` 
    API service discovery document. List of available Archetypes, supported
    serialization formats, and valid query parameters for general search. This
    is the bulk of the common API functions. See under :ref:`Searching the
    Catalogue`.

`/concepts/` 
    API service discovery document. The `/concepts/` namespace is used mostly
    for administrative concepts used by the publishing tools. For concepts
    relating to content subjects, see under `/ontology/`.

`/concepts/publishing_status/`
    List of all valid publishing statuses.

`/concepts/publishing_organizations/`
    List of registered publishing organizations.

`/concepts/processing_flags/`
    List of processing flags understood by Demetrius.

`/ontology/` 
    API service discovery document. List of Ontology sub-types.

`/ontology/topics/`
    List of all Topic sub-types known by the system. Given search parameters,
    returns the list of Topics matching the search. This can be used as an
    auto-completion service for web forms.

`/ontology/categories/`
    List of category hierarchies known by the system.

`/collections/`
    API service discovery document. List of Collection types.
    

Operations we might want:

* Recent items of a particular Archetype.
* Single Item of a particular Archetype by GUID.
* Search for items matching a string or phrase.
* Search for items related to a specific Concept or group of Concepts.


Searching the Catalogue
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Most interactions with Demetrius begin with the Catalogue, the central point of
content discovery.

Filters applied automatically to all queries:

* pub_status: usable
* pub_date: >= NOW (truncated to 1 min granularity)
* provider: permitted-only (filters out rights-restricted content based on
  permissions)

Some clients will have permission to alter or remove these filters. Clients who
attempt to alter or remove these filters without permission will receive a "400
Bad Request" response.


The Stacks API
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
The Stacks API gives you access to Item storage. It allows you to access
a list of ItemTypes, or a list of Items of a particular ItemType. With
sufficient privileges, you can retrieve the current version of any Item, and
potentially any previous version, including a complete version history.

The Stacks API provides almost no search capability, and no sorting options (all
lists are returned sorted in reverse chronological order). 

The Stacks API provides write capability for clients with sufficient privileges.
New Items or new versions of existing Items can be stored.

The Stacks API is useful mostly to publishing tools and Curators. Other clients
should start with the Catalogue API instead. With the exception of historical
version information, all data available through the Stacks API can also be
retrieved through the Catalogue API.

The Stacks API is implemented by the Archivist. The default Archivist that ships
with Demetrius is a Django pluggable app, which can easily be run as its own
process.
