Item: Administrative Metadata
================================================================================
.. py:class:: Item()

    The Item class is the root of the item hierarchy. If you create your own
    ItemTypes, they must inherit from Item. The Item class implements the
    *administrative* metadata for content items, fields that are used by the
    content management system to manage the content.

    .. py:attribute:: guid

        If you POST a new item without a GUID, one will be provided by
        Demetrius. Duplicate GUIDs will be rejected.

        IPTC: GUID

        ATOM: id

    .. py:attribute:: item_type 

        Indicates the ItemType. Used for the selection of Validators, Scribes,
        and Indexers.
    
        IPTC: itemMeta.itemClass. CV required for NewsML serialization. 

        ATOM: entry.content[@type].

    .. py:attribute:: provider

        Indicates the party responsible for the origination and release of the
        content. This field references a :py:class:`PublishingOrganization`
        Concept. Demetrius will not accept content with an unknown provider. You
        must register your provider with Demetrius.

        IPTC itemMeta.provider

    .. py:attribute:: rights_info

        An embedded object with properties that indicate the copyright status
        and usage restrictions on the item. The object may have attributes for
        "accountable_party", "copyright_holder", "copyright_notice", and
        "usage_terms".

        IPTC: rightsInfo

        ATOM: rights

    .. py:attribute:: pub_status

        A reference to a :py:class:`PublishingStatus` Concept representing the
        publication status, that is, whether the content is available to be
        viewed by the public.

        IPTC: itemMeta.pubStatus. Controlled Vocabulary required for NewsML
        serialization. 
        
        ATOMPUB: entry.control.draft (roughly).

    .. py:attribute:: pub_date

        Datetime that the item became, or will become, available for viewing by
        the public. If in the future, this maps to the *itemMeta.embargoed*
        field in IPTC. Otherwise IPTC does not appear to have an equivalent.

        For performance reasons, Demetrius will truncate to the minute if the
        provided Datetime is more precise. A granularity of one hour or greater
        is recommended.

        IPTC: itemMeta.embargoed (Datetime that item embargo ends.)
        
        ATOM: entry.published

    .. py:attribute:: created_date

        Datetime when this item was first created within Demetrius (as distinct
        from when the content itself was created, which is always earlier).

        IPTC: itemMeta.firstCreated
        
        ATOM: entry.published

    .. py:attribute:: version

        An integer value that increases as updates are made to the item. Not
        guaranteed to be sequential, but larger integers always indicate newer
        versions.
    
        IPTC: version (Must be a positive integer for IPTC compliance.)

        ATOM: no equivalent

    .. py:attribute:: version_created

        Datetime value when this version of the item (as distinct from the
        content it contains) was created. This value MAY be modified when only
        administrative metadata has been changed. This is equivalent to the
        "last modified" date of the item (if you are looking at the latest
        version).

        IPTC: itemMeta.versionCreated

    .. py:attribute:: profile

        A string describing the structural template for the content.

        .. warning:: Is this needed in Demetrius? Or is the whole concept
            replaced by being able to subclass items? In NewsML this seems to be
            used to describe the shape of a Package.

        IPTC: profile

        ATOM: No equivalent

    .. py:attribute:: hash

        An integrity check on the content.

        IPTC: hash

    .. py:attribute:: admin_title

        A string that serves as the title of the item in the CMS. This string is
        intended for use *only* by the editorial staff, and is not necessarily
        the same as the title you would display to a consumer of the content
        (called a *headline*).

        IPTC: itemMeta.title

    .. py:attribute:: editorial_notes

        An array of descriptive notes tacked onto the item, meant for editorial
        staff to share notes. These notes should not be exposed to consumers of
        the content.

        A Note is actually an embedded object with a creator and modified date
        as well as the block of text that makes up the content of the note.
        Notes cannot be retrieved separately from the item they are attached to.

        IPTC: itemMeta.edNote

    .. py:attribute:: processing_flags

        Processing flags are signals that indicate instructions or constraints
        on how the item should be handled by content managers. These flags MAY
        be recognized by Demetrius itself, or MAY be opaque values that are
        merely passed through.

        IPTC: signal

    .. py:attribute:: version_history

        URI where you can retrieve the version history for the item. This
        property should only be exposed if you have permission to view the
        history.

    .. py:attribute:: alternatives

        Reference to a list of alternative TypedItems conveying the same content
        in an alternative format. 


.. note:: (`standard`, `standardversion`, and `conformance` are required fields for
      NewsML serialization, but pertain to the serialization format and not the
      item itself. They are not stored.)

