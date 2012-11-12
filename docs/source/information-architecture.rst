Information Architecture
================================================================================
Although you are free to create your own ItemTypes and Archetypes, Demetrius
ships with a set of built-in components comprising a ready-made information
architecture for publishing. It is designed to be compatible with the `IPTC News
Architecture`_, as well as the `Atom syndication format`_. This document
describes that information architecture and how it maps to the IPTC News
Architecture.

.. _Atom syndication format: http://tools.ietf.org/html/rfc4287
.. _IPTC News Architecture: http://www.iptc.org/site/News_Exchange_Formats/Developers/

* Item (IPTC: anyItem)

    * Asset (IPTC: NewsItem)

        * Article (IPTC: itemClass=ninat:text)
        * Audio (IPTC: itemClass=ninat:audio)
        * Video (IPTC: itemClass=ninat:video)
        * Image

            * Photo (IPTC itemClass=ninat:picture
            * Graphic (IPTC itemClass=ninat:graphic)
            * Animation (IPTC itemClass=ninat:animated)

        * WebWidget (No IPTC equivalent)

    * Package (IPTC: PackageItem)

        * ImageGallery
        * NewsStory
        * List
        * Section

    * Topic (IPTC: ConceptItem type=cpnat:abstract)

        * Person (IPTC type=cpnat:person)
        * Organization (IPTC type=cpnat:organisation)
        * Location (IPTC type=cpnat:geoArea)
        * Venue (IPTC type=cpnat:poi)
        * Object (IPTC type=cpnat:object)
        * Event (IPTC type=cpnat:event)

    * Ontology (IPTC: KnowledgeItem)
    * [not implemented] (IPTC: PlanningItem)


Assets and Packages
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Assets are reusable content objects which can be addressed individually.

When creating a consumer experience, Assets are seldom the primary mode of
presentation. Usually, assets will be composed together into Packages which are
presented to the consumer as a single entity.

ItemTypes and their Attributes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Item
    * GUID
    * version (Must be a positive integer for IPTC compliance.)
    * icon [ATOM:feed.icon]
    * rightsInfo.accountable
    * rightsInfo.copyrightHolder
    * rightsInfo.copyrightNotice [ATOM:entry.rights]
    * rightsInfo.usageTerms
    * itemMeta.itemClass (IPTC controlled vocabulary required)
      [ATOM:entry.content[@type]]
    * itemMeta.provider
    * itemMeta.pubStatus (IPTC controlled vocabulary required)
      [ATOMPUB:entry.control.draft]
    * itemMeta.embargoed (Datetime that item embargo ends.)
      [ATOM:entry.published see also itemMeta.firstCreated]
    * itemMeta.versionCreated
    * itemMeta.firstCreated [ATOM:entry.published if no embargo date]
    * itemMeta.role
    * itemMeta.filename
    * itemMeta.service
    * itemMeta.title (internal for editors).
    * itemMeta.edNote (internal for editors).
    * itemMeta.deliverableOf (reference to the PlanningItem that spawned it)
    * contentMeta.audience
    * contentMeta.contentCreated
    * contentMeta.contentModified [ATOM:entry.updated]
    * contentMeta.contributor [ATOM:entry.contributor]
    * contentMeta.creator [ATOM:entry.author]
    * contentMeta.located
    * contentMeta.infoSource
    * contentMeta.urgency
    * contentMeta.by
    * contentMeta.creditline
    * contentMeta.dateline
    * contentMeta.description
    * contentMeta.genre
    * contentMeta.headline [ATOM:entry.title]
    * contentMeta.keyword
    * contentMeta.language
    * contentMeta.slugline
    * contentMeta.subject

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

