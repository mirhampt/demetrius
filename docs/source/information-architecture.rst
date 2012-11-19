Information Architecture
================================================================================
Although you are free to create your own ItemTypes and Archetypes, Demetrius
ships with a set of built-in components comprising a ready-made information
architecture for publishing. It is designed to be compatible with the `IPTC News
Architecture`_, as well as the `Atom syndication format`_. This document
describes that information architecture and how it maps to the IPTC News
Architecture.

Assets are reusable content objects which can be addressed individually.

When creating a consumer experience, Assets are seldom the primary mode of
presentation. Usually, Assets will be composed together into Packages which are
presented to the consumer as a single entity. The IPTC architecture allows for
creation of composite Packages, but does not define any specific Package
patterns for reuse. Things like ImageGalleries and VideoPlaylists are not
specified in the architecture, and must be constructed by convention.

News stories are listed under Packages tentatively, because news stories are
often not merely a block of article text, but may include supplementary photos,
videos, interactive maps, and other "related objects". It seems reasonable that
we want to deliver this collection of assets as a Package.

The Demetrius architecture makes a distinction between *administrative metadata*
(information meant to be used by editors and the publishing tools) as separate
from *descriptive metadata* (information to be presented to the audience).
Administrative metadata is implemented in the Item base class which must be
inherited by all ItemTypes. This ensures that all content can be uniformly
managed by the system.

.. note::

    This represents a (hopefully) workable subset of this for the first
    release. Even "core" compliance is too broad an implementation for a first
    iteration.

.. note:: 

    *CMG-specific:* This IA could have some upstream impact on the publishing
    tools and the way content is produced.  Perhaps we need to specify a new
    entity called a StoryPackage?

.. _Atom syndication format: http://tools.ietf.org/html/rfc4287
.. _IPTC News Architecture: http://www.iptc.org/site/News_Exchange_Formats/Developers/

.. toctree::
    :maxdepth: 2

    ia-hierarchy
    ia-item
    ia-content

NewsItem inherits Item
    * contentSet: inlineXML, inlineData, or remoteContent

PackageItem inherits Item
    * groupSet: contains groups
    * groupSet.group: contains instances groupRef, itemRef, conceptRef

Concept
    * type
    * name
    * definition
    * note
    * remoteInfo
    * hierarchyInfo
    * sameAs
    * related
    * broader
    * narrower

Person inherits Concept
    * born
    * died
    * affiliation
    * contactInfo.role
    * contactInfo.email
    * contactInfo.im
    * contactInfo.phone
    * contactInfo.fax
    * contactInfo.web
    * contactInfo.address
    * contactInfo.note

Organisation inherits Concept
    * founded
    * disolved
    * location
    * contactInfo

GeoArea inherits Concept
    * position
    * founded
    * disolved

PointOfInterest inherits Concept
    * position
    * openHours
    * capacity
    * access
    * details
    * contactInfo
    * created
    * ceasedToExist

Object inherits Concept
    * created
    * creator
    * copyrightNotice
    * ceasedToExist

