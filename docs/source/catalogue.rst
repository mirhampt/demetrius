The Catalogue
================================================================================
The Catalogue implements the search schema for your information architecture.

This document describes the built-in Catalogue schema for the Atom and Extended
NAR architectures that ship with Demetrius.

Due to Solr/Lucene internal design, fields in the schema are designed for
specific functions, for example searching, sorting, faceting, or display. Often
a single logical field will be replicated into several function-specific fields.
For example, the `headline` field might be stored unchanged for display, but the
data may also be copied to a `headline_str_ix` field that is normalized and
tokenized for search, and a `headline_str_sort` field for sorting by headline which
is case-normalized.

This complexity is largely hidden from the user by the Researcher, which knows
how to use these specific fields. Indexers may need to have some inside
knowledge of this process, however.

If you are constructing your own information architecture, you will need to
provide your own Solr schema as well. You should find the included schema an
excellent starting point.

.. TODO:: Produce a comprehensive Solr schema.

