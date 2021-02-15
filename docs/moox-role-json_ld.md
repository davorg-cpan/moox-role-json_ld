# NAME

MooX::Role::JSON\_LD - Easily provide JSON-LD mark-up for your objects.

# SYNOPSIS

    # Your Moo (or Moose) Class
    package::My::Moo::Class

    use Moo;
    with 'MooX::Role::JSON_LD';

    # define your attributes
    has first_name => (
      is => 'ro',
      # Various other properties
    );
    has last_name  => (
      is => 'ro',
      # Various other properties
    );
    has birth_date => (
      is => 'ro',
      # Various other properties
    );

    # Add two required methods
    sub json_ld_type { 'Person' };

    sub json_ld_fields { [ qw[ first_name last_name birth_date ] ] };

    # Then, in a program somewhere...
    use My::Moo::Class;

    my $obj = My::Moo::Class->new({
      first_name => 'David',
      last_name  => 'Bowie',
      birth_date => '1947-01-08',
    });

    # print a text representation of the JSON-LD
    print $obj->json_ld;

    # print the raw data structure for the JSON-LD
    use Data::Dumper;
    print Dumper $obj->json_ld_data;

# DESCRIPTION

This role allows you to easily add a method to your class that produces
JSON-LD representing an instance of your class.

To do this, you need to do three things:

- 1. Add the role to your class

        with 'MooX::Role::JSON_LD';

- 2. Add a method telling the role which JSON-LD type to use in the output

        sub json_ld_type { 'Person' }

- 3. Add a method defining the fields you want to appear in the JSON-LD

        sub json_ld_fields { [ qw[ first_name last_name birth_date ] ] };

## Using the role

`MooX::Role::JSON_LD` can be loaded into your class using the `with`
keyword, just like any other role. The role has been written so that it
works in both [Moo](https://metacpan.org/pod/Moo) and [Moose](https://metacpan.org/pod/Moose) classes.

## Defining your type

JSON-LD can be used to model many different types of object. The current list
can be found at [https://schema.org/](https://schema.org/). Once you have chosen one of the types
you want to use in your JSON-LD, simply add a method called `json_ld_type`
which returns the name of your type as a string. This string will be used
in the `@type` field of the JSON-LD.

## Defining your fields

You also need to define the fields that are to be included in your JSON-LD.
To do this, you need to add a method called `json_ld_fields` which returns
an array reference containing details of the fields you want.

The simplest approach is for each element of the array to be the name of
a method on your object. In our example above, we call the three methods,
`first_name`, `last_name` and `birth_date`. The names of the methods are
used as keys in the JSON-LD and the values returned will be the matching values.
So in our example, we would get the following as part of our output:

    "birth_date" : "1947-01-08",
    "first_name" : "David",
    "last_name" : "Bowie",

Unfortunately, these aren't valid keys in the "Person" type, so we need to
use a slightly more complicated version of the `json_ld_fields` method, one
that enables us to rename fields.

    sub json_ld_fields {
        [
          qw[ first_name last_name],
          { birthDate => 'birth_date' },
        ]
    }

In this version, the last element of the array is a hash reference. The key
in the hash will be used as the key in the JSON-LD and the value is the name
of a method to call. If we make this change, our JSON will look like this:

    "birthDate" : "1947-01-08",
    "first_name" : "David",
    "last_name" : "Bowie",

The `birthDate` key is now a valid key in the JSON-LD representation of a
person.

But our `first_name` and `last_name` keys are still wrong. We could take
the same approach as we did with `birthDate` and translate them to
`givenName` and `familyName`, but what if we want to combine them into the
single `name` key. We can do that by using another version of
`json_ld_fields` where the value of the definition hash is a subroutine
reference. That subroutine is called, passing it the object, so it can build
anything you want. We can use that to get the full name of our person.

    sub json_ld_fields {
        [
          { birthDate => 'birthDate'},
          { name => sub{ $_[0]-> first_name . ' ' . $_[0]->last_name} },
        ]
      }

That configuration will give us the following output:

    "birthDate" : "1974-01-08",
    "name" : "David Bowie",

## Other contexts

By default, this role uses the URL [http://schema.org](http://schema.org), but you can change
this. This role adds an attribute (called `context`) which can be used to
change the context.

# AUTHOR

Dave Cross <dave@perlhacks.com>

# SEE ALSO

perl(1), Moo, Moose, [https://json-ld.org/](https://json-ld.org/), [https://schema.org/](https://schema.org/)

[MooX::JSON\_LD](https://metacpan.org/pod/MooX%3A%3AJSON_LD) is included in this distribution and provides an alternative
interface to the same functionality.

# COPYRIGHT AND LICENSE

Copyright (C) 2018, Magnum Solutions Ltd.  All Rights Reserved.

This script is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.
