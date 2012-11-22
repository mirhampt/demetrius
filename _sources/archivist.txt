The Archivist -- Design
================================================================================

Nearly all REST APIs expose URLs of the following form::

    /{collection}/ # Returns a list of items
    /{collection}/{identifier}/ # Returns the identified item

In the case of most MVC frameworks (including Django with either REST framework
or Tastypie), `{collection}` actually translates to `{ItemType}`. 

Additionally, Tastypie exposes::

    /{collection}/set/{list-or-range-of-identifiers}/ # Returns a list of items
    /{collection}/schema/ # Description of the ItemType schema (non-standard)

This is great functionality, but the URL construction is problematic, as any
object that had an identifier of "set" or "schema" would be inaccessible through
the API. In typical MVC usage that isn't a problem, since the `{identifier}`
part is almost always an integer primary key. Integer primary keys don't scale,
so we'll be using UUID as an identifier, but in the URL we prefer to use a more
friendly format, see under `Assigning Identifiers`_.

A better construction::

    /schema/{itemtype}/
    /{itemtype}/{identfier}+{identifier} # Requires identifiers to be slugified

This should return a standard schema, for example a W3C XML Schema document or a
json-schema document. See :doc:`validators`.

Assigning Identifiers
--------------------------------------------------------------------------------
From IPTC-G2 Implementation Guide (4) section 7.3.1.3:

    GUID

    Each NewsML-G2 document MUST provide an identifier that is guaranteed to be
    globally unique for all time and independent of location, (The standard
    permits documents to be physically located in many places but each document
    may have only one ID). The form of the identifier MUST be an IRI
    (Internationalized URI). One way to guarantee uniqueness is to create an ID
    using some algorithm that combines the provider name and the date-time that
    the document was first generated, combined with some other information that
    may be needed to disambiguate the document.

    The IPTC has registered a URN for the purpose of creating GUIDs for
    NewsML-G2 Items using a specification in RFC 3085bis. The syntax for a GUID
    using this scheme is::

        guid=“urn:newsml:[ProviderId]:[DateId]:[NewsItemId]”

    The ProviderId must be in the form of a valid internet domain name owned by
    the provider: in our case this is acme-news.com. The DateId must be in the
    form CCYYMMDD, and the NewsItemId must be unique for all items published by
    the Provider on this Date. For this example we will use the story’s Slugline
    (but note that this is unlikely to be granular enough in a real-world
    implementation). ::

        guid=“urn:newsml:acme-news.com:20081125:US-FINANCE-ROBINSON”

    Any ID that can be guaranteed to be globally unique is valid for NewsML-G2.
    Some implementers use a Tag URI (RFC 4151), for example::

        guid=“tag:afp.com,2008:TX-PAR:20080529:JYC80”

    Other schemes used include UUID (Universally Unique Identifier, a URN
    namespace) (see IETF RFC 4122 Page) and DOI (Digital Object Identifier).

    Where a provider has used some algorithm based on date and time (such as RFC
    3085) to create a GUID, recipients MUST NOT “reverse engineer” the
    information to create a time-stamp.  This may have unintended consequences
    and result in errors.

See also section 23.6 (p. 245) for dealing with updates and corrections, even
when proper versioning is not supported by the source system (that is, when
every version gets a new ID).

Symbolic identifiers assigned by Demetrius should be either of the NewsML or Tag
URI format. The two are effectively equivalent, but the NewsML version gives
more flexibility in the ProviderID, where Tag URI must contain a domain or email
address.

Versioning
--------------------------------------------------------------------------------
None of these API conventions support versioning of resources. Some references
that might be interesting related to versioning:

* `An HTTP-based Versioning Mechanise for Linked Data <http://arxiv.org/abs/1003.3661>`_
* `WebDAV <http://www.webdav.org/>`_ (but this is terrible, do not use)

Some interesting features I would like to enable eventually:

* Retrieve a list of previous or alternate versions of an existing resource.
* Retrieve a specific alternate version by ID.
* Retrieve a representation of the state of the resource at a specific time.

The general outline is:

* Every resource is assigned a *symbolic identifier* that becomes part of its
  URI. `http://api.example.com/v1/{itemtype}/{identifier}`
* Every version is assigned a UUID, which serves as the identifier of that
  specific version. The identifier becomes part of the URI for that version, and
  also serves as the *etag* for the resource when fetched from the symbolic
  identifier URI. `http://api.example.com/v1/versions/{itemtype}/{identifier}/{UUID}`
* You can retrieve a list of all versions of a particular resources, along with
  some metadata for the version. `http://api.example.com/v1/versions/{itemtype}/{identifier}/`

Catalogs
--------------------------------------------------------------------------------
Is it the Archivist's job to expose Catalogs of Controlled Vocabularies?
