.. title:: clang-tidy - hicpp-explicit-conversions
.. meta::
   :http-equiv=refresh: 5;URL=../google/explicit-constructor.html

hicpp-explicit-conversions
==========================

This check is an alias for :doc:`google-explicit-constructor <../google/explicit-constructor>`.
Used to enforce parts of `rule 5.4.1 <http://www.codingstandard.com/rule/5-4-1-only-use-casting-forms-static_cast-excl-void-dynamic_cast-or-explicit-constructor-call/>`_.
This check will enforce that constructors and conversion operators are marked `explicit`.
Other forms of casting checks are implemented in other places.
The following checks can be used to check for more forms of casting:

- :doc:`cppcoreguidelines-pro-type-static-cast-downcast <../cppcoreguidelines/pro-type-static-cast-downcast>`
- :doc:`cppcoreguidelines-pro-type-reinterpret-cast <../cppcoreguidelines/pro-type-reinterpret-cast>`
- :doc:`cppcoreguidelines-pro-type-const-cast <../cppcoreguidelines/pro-type-const-cast>`
- :doc:`cppcoreguidelines-pro-type-cstyle-cast <../cppcoreguidelines/pro-type-cstyle-cast>`
