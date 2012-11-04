Demetrius: Web Content Librarian
================================================================================
Demetrius is a "librarian" who manages a central content library for a large
web content management system ("Alexandria"). You could say Demetrius IS a web
content management system, but it lacks certain features that are commonly
expected in a CMS. Demetrius does not implement publishing tools or web site
templates. Demetrius is intended to fill the role of a large-scale,
high-performance data store accessed over HTTP.

Demetrius is designed to solve several problems for large web publishing
operations:

* Enable discovery and sharing of available content across the entire
  organization using a simple, cross-platform API.
* Simplify content reuse by transforming data into well-known formats.
* Allow the use of a variety of off-the-shelf or purpose-built publishing tools.
* Allow the acquisition of content from sources external to the organization.
* Allow for the enrichment of content metadata, without requiring alterations to
  publishing tools.
* Clean separation of the presentation layer (which could be a web page, a
  native mobile app, or any other client) from the data storage layer.

Demetrius allows you to define your own information architecture, but ships with
a built-in architecture based on the `IPTC News Architecture`_. This should make
it relatively easy for media organizations to get up and running quickly without
having to do a lot of custom development work.

.. _IPTC News Architecture: http://www.iptc.org/site/News_Exchange_Formats/Developers/


