# MooX::Role::JSON_LD

[![Build Status](https://github.com/davorg-cpan/moox-role-json_ld/actions/workflows/perltest.yml/badge.svg?branch=master)](https://github.com/davorg-cpan/moox-role-json_ld/actions/workflows/perltest.yml) [![Coverage Status](https://coveralls.io/repos/github/davorg-cpan/moox-role-json_ld/badge.svg?branch=master)](https://coveralls.io/github/davorg-cpan/moox-role-json_ld?branch=master)

`MooX::Role::JSON_LD` is a role for Moo and Moose classes that adds methods for
producing [JSON-LD](https://json-ld.org/) from your objects.

## What this module does

When your class consumes this role, you define:

* `json_ld_type` - the Schema.org type (for example, `Person`)
* `json_ld_fields` - the object attributes/methods to expose

The role then gives you:

* `json_ld_data` - a Perl data structure
* `json_ld` - pretty JSON text
* `json_ld_wrapped` - JSON in a `<script type="application/ld+json">` block

## Why you might want it

Use this when you already model data with Moo/Moose and need structured
metadata for web pages, APIs, or search indexing, without hand-building JSON
payloads for every class.

## Example

```perl
package My::Person;

use Moo;
with 'MooX::Role::JSON_LD';

has first_name => (is => 'ro');
has last_name  => (is => 'ro');
has birth_date => (is => 'ro');

sub json_ld_type { 'Person' }
sub json_ld_fields {
  [
    { givenName  => 'first_name' },
    { familyName => 'last_name'  },
    { birthDate  => 'birth_date' },
    { name       => sub { $_[0]->first_name . ' ' . $_[0]->last_name } },
  ]
}
```

```perl
my $person = My::Person->new(
  first_name => 'David',
  last_name  => 'Bowie',
  birth_date => '1947-01-08',
);

print $person->json_ld;
```

## Full documentation and project links

* MetaCPAN docs: <https://metacpan.org/pod/MooX::Role::JSON_LD>
* GitHub issue log: <https://github.com/davorg-cpan/moox-role-json_ld/issues>
