Notes on IPTC Architecture in Demetrius
================================================================================
When creating a consumer experience, Assets are seldom the primary mode of
presentation. Usually, Assets will be composed together into Packages which are
presented to the consumer as a single entity. The IPTC architecture allows for
creation of composite Packages, but does not define any specific Package
patterns for reuse. Things like ImageGalleries and VideoPlaylists are not
specified in the architecture, and must be constructed by convention.

News stories are listed under Packages tentatively, because news stories are
often not merely a block of article text, but may include supplemetary photos,
videos, interactive maps, and other "related objects". It seems reasonable that
we want to deliver this collection of assets as a Package.

.. note:: 

    *CMG-specific:* This IA could have some upstream impact on the publishing
    tools and the way content is produced.  Perhaps we need to specify a new
    entity called a StoryPackage?

.. _Atom syndication format: http://tools.ietf.org/html/rfc4287
.. _IPTC News Architecture: http://www.iptc.org/site/News_Exchange_Formats/Developers/

Hierarchy of ItemTypes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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

    * Package (IPTC: PackageItem[@itemClass=ninat:composite])

        * Section
        * List (Automatic, Manual, RSS)
        * ImageGallery
        * VideoPlaylist
        * NewsStory?

    * Topic (IPTC: ConceptItem type=cpnat:abstract)

        * Person (IPTC type=cpnat:person)
        * Organization (IPTC type=cpnat:organisation)
        * Location (IPTC type=cpnat:geoArea)
        * Venue (IPTC type=cpnat:poi)
        * Object (IPTC type=cpnat:object)
        * Event (IPTC type=cpnat:event)

    * Ontology (IPTC: KnowledgeItem)
    * [not implemented] (IPTC: PlanningItem)

ItemTypes and their Attributes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
This section describes the common attributes of Items in the IPTC architecture,
and potential mappings to the corresponding ATOM structures. Nearly all of these
attributes are optional and can be omitted in practice.

Although the distinction is not clear in this simplified list, it is an
important point that the IPTC architecture makes a distinction between
*administrative metadata* (information meant to be used by editors and the
publishing tools) as separate from *descriptive metadata* (information to be
presented to the audience). **The architecture as presented through Demetrius
should make the distinction between administrative and descriptive metadata much
more visible.**

.. note::

    Carve out a workable subset of this for the first release. Even "core"
    compliance is too broad an implementation for a first iteration.

Item
    * GUID
    * version (Must be a positive integer for IPTC compliance.)
    * icon [ATOM:feed.icon? No equivalent for entry.]
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
    * contentMeta.description [ATOM:entry.summary]
    * contentMeta.genre
    * contentMeta.headline [ATOM:entry.title]
    * contentMeta.keyword
    * contentMeta.language
    * contentMeta.slugline
    * contentMeta.subject [ATOM:category]

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

