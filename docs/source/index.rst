Demetrius: The First Librarian of Alexandria
================================================================================
Demetrius is a "librarian" who manages a central content library ("Alexandria")
for a large web content management system. You could say Demetrius IS a web
content management system, but it lacks certain features that are commonly
expected in a CMS. Demetrius does not implement publishing tools or web site
templates. Demetrius is intended to fill the role of a large-scale,
high-performance content repository accessed over HTTP.

Note that Demetrius is not a general-purpose database, but is explicitly a
content repository. Its mission is to store and catalog content (however you
define content in your application). Demetrius is built on these principles:

* Store content as structured objects, separate from any presentation details,
  allowing clients to adapt presentation to the consumer's context.
* Enable search, discovery, and sharing of content objects, using metadata and
  relationships between objects, both explicit and inferred.
* Expose the structured content through a simple web-based API in standard
  formats, so that content can be reused easily across a variety of platforms.

Demetrius is designed to solve several problems for large web publishing
organizations:

* Enable discovery and sharing of available content across the entire
  organization using a simple, cross-platform API.
* Simplify content reuse by transforming data into well-known formats.
* Allow the use of a variety of off-the-shelf or purpose-built publishing tools.
* Allow the acquisition of content from sources external to the organization.
* Allow for the enrichment of content metadata, without requiring alterations to
  publishing tools.
* Clean separation of the presentation layer (which could be a web page, a
  native mobile app, or any other client) from the data storage layer.

This document describes the inner workings of Demetrius, the software
architecture and the information architecture. It should be useful to people
developing Demetrius or running their own instance. For clients who merely wish
to access services provided by Demetrius, separate documentation will be
provided later.

Contents:

.. toctree::
    :maxdepth: 2

    introduction
    information-architecture
    rest-api
    archivist
    validators
    catalogue
    iptc-notes


Indices and tables
==================

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`

