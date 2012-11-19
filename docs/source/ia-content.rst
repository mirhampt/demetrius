Content Items: Descriptive Metadata
================================================================================
.. py:class:: ContentItem()

     Subclasses: :py:class:`Item`

    .. py:attribute:: content_created

        IPTC: contentMeta.contentCreated

    .. py:attribute:: content_modified

        IPTC: contentMeta.contentModified

        ATOM: entry.updated

    .. py:attribute:: headline

        IPTC: contentMeta.headline

        ATOM: entry.title

    .. py:attribute:: description

        IPTC: contentMeta.description
        
        ATOM: entry.summary

    .. py:attribute:: byline

        From IPTC NewsML-G2 Specification 2.9:

            The byline provides a natural-language statement of the author/creator
            information. It may include a byline title, i.e. the author's job title.
            Examples of bylines are RUPAK DE CHOWDHURI (a person), isotype.com (a
            provider) or STR (a stringer). It is up to the provider to decide if the
            label starts with a word like "By".
    
        IPTC: contentMeta.by

        ATOM: entry.author

    .. py:attribute:: contributor

        IPTC: contentMeta.contributor
        
        ATOM: entry.contributor

    .. py:attribute:: creator

        IPTC: contentMeta.creator
        
        ATOM: entry.author 

    .. py:attribute:: topics

        A list of references to :py:class:`Topic` items that relate to this Content.

        IPTC: contentMeta.subject
        
        ATOM: category

    .. py:attribute:: dateline

        IPTC: contentMeta.dateline

        From IPTC NewsML-G2 Specification 2.9:

            A natural-language statement of the date and/or place of creation of the
            content.

            The dateline provides a natural-language statement of the date and/or
            place of the news content creation, to be displayed in situations where
            an abstract of the content is shown (case of search results) or the
            content is remote.

            Traditionally a dateline indicates when and where news content is
            created, not necessarily the time and place relative to the news event.

            As an example a dateline `BAGHDAD, March 26, 2007 (AFP)` could head a
            story about blast in Mosul, because the story was actually written in
            Baghdad. Also, by tradition a dateline will follow the stylebook of the
            information provider and possibly leave out certain time and location
            information that could be useful for specifying searches of a database.
            Editorial policy dictates the dateline; it is not automatically
            derivable from other markup (location, date, etc.). The dateline should
            not end with a separating character (of the kind that separates the
            dateline from the first sentence in a traditional wire story).
        
    .. py:attribute:: creditline

        IPTC: contentMeta.creditline

    .. py:attribute:: language

        IPTC: contentMeta.language

    .. py:attribute:: slugline

        IPTC: contentMeta.slugline

Optional:
    * `icon` [ATOM:feed.icon? No equivalent for entry.]

