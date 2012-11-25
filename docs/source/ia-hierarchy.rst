Hierarchy of ItemTypes
================================================================================

Item (IPTC: anyItem)

  * Content

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

  * Concept (IPTC: Concept type=cpnat:abstract)

    * AdminConcept
      
        * PublishingStatus
        * PublishingOrganization
        * ProcessingFlag

    * Topic 

        * Person (IPTC type=cpnat:person)
        * Organization (IPTC type=cpnat:organisation)
        * Location (IPTC type=cpnat:geoArea)
        * Venue (IPTC type=cpnat:poi)
        * Object (IPTC type=cpnat:object)
        * Event (IPTC type=cpnat:event)

    * Ontology (IPTC: KnowledgeItem)
    * [not implemented] (IPTC: PlanningItem)

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

