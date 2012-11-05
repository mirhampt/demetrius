DEVELOPMENT TODO
================

Phase One: Design
---------------------
* Decide how to implement versioning, and whether to expose it through the REST
  API.
    * How to generate version identifiers?
    * How to link versions of the same item?
    * How to select the "latest" version?
* Define the REST API for the Archivist CRUD.
    * What to use for item identifiers?
    * Allow clients to set their own identifiers?
    * URLs namespaced by ItemType?
* Document how data will be stored in the Stacks.
* Define the Validator API.
* Define how the Registry works, for registering ItemType-Validator and
  Archetype-Indexer.
* How to deal with NewsML Catalogs for controlled vocabularies? What about CVs
  not controlled by IPTC (e.g. Medley Lolcats)?
* Create a Solr Schema

Phase Two: The Stacks
---------------------
* Create the AtomEntry and AtomFeed ItemTypes, with Validators.
* Create the Archivist web service.
* Create a Registry bootstrap of some kind (depending how the Registry works).

