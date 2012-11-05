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
