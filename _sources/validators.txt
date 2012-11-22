Validators
================================================================================

Custom Validation Functions
--------------------------------------------------------------------------------
To register custom Python validation functions, you need to install the code for
your Validator where Demetrius can load it, and add the function to the
Registry.

.. TODO:: 
    Define how to register such a function, both manually and programmatically.


Validation Schemas
--------------------------------------------------------------------------------
Although custom validation functions are useful to a certain extent, you don't
want your clients necessarily installing code onto your server. Yet there are
times when you want to enable clients to register new validators for ItemTypes,
for example you might want to enable clients to register their own ItemTypes.

To support this, Demetrius supports declarative schema validators for some MIME
types, notably application/json and text/xml.

If an ItemType is defined as belonging to one of these MIME types, then the
Validator may be a supported declarative schema document rather than a function.
Supported schema types are:

* For JSON: `JSON Schema`_ (as implemented in the Python jsonschema_ module).
* For XML: `W3C XML Schema`_ (as implemented in the Python lxml_ module).

.. _JSON Schema: http://json-schema.org/
.. _jsonschema: https://python-jsonschema.readthedocs.org/en/latest/
.. _W3C XML Schema: http://www.w3.org/XML/Schema.html
.. _lxml: http://lxml.de/validation.html

