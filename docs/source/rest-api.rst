The REST API exported by Demetrius
================================================================================

The Catalogue API
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Most interactions with Demetrius begin with the Catalogue API, the central point of
content discovery.

The Catalogue API allows filtering on a variety of metadata fields. It can sort
results by many fields, and return faceted results for drill-down searches.

.. note:: See opensearch.org_ for some standards we should implement.

The Catalogue API is implemented by the Researcher. The default Researcher that
ships with Demetrius is a Django pluggable app, which can easily be run as its
own process.

If you wanted to use a search engine other than Solr as your Catalogue, you
would need to reimplement the Researcher.

Search Functions
--------------------------------------------------------------------------------
`/catalogue/`
    Search the Catalogue. Without query parameters, returns list of Archetypes.

`/catalogue/{archetype}/`



.. _opensearch.org: http://www.opensearch.org/

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
