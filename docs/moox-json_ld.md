# NAME

MooX::JSON\_LD - Extend Moo to provide JSON-LD mark-up for your objects.

# SYNOPSIS

    # Your Moo (or Moose) Class
    package My::Moo::Class;

    use Moo;

    use MooX::JSON_LD 'Person';

    has first_name => (
      is => 'ro',
      # various other properties...
      json_ld => 1,
    );

    has last_name  => (
      is => 'ro',
      # various other properties...
      json_ld => 1,
    );

    has birth_date => (
      is => 'ro',
      # various other properties...
      json_ld => 'birthDate',
      json_ld_serializer => sub { shift->birth_date },
    );

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

This is a companion module for [MooX::Role::JSON\_LD](https://metacpan.org/pod/MooX%3A%3ARole%3A%3AJSON_LD). It extends the
`has` method to support options to add attributes to the
`json_ld_fields` and create the `json_ld_type` .

To declare the type, add it as the option when importing the module,
e.g.

    use MooX::JSON_LD 'Thing';

Moo attributes are extended with the following options:

- `json_ld`

        has headline => (
          is      => 'ro',
          json_ld => 1,
        );

    This adds the "headline" attribute to the `json_ld_fields`.

        has alt_headline => (
          is      => 'ro',
          json_ld => 'alternateHeadline',
        );

    This adds the "alt\_headline" attribute to the `json_ld_fields`, with
    the label "alternateHeadline".

- `json_ld_serializer`

        has birth_date => (
          is      => 'ro',
          isa     => InstanceOf['DateTime'],
          json_ld => 'birthDate',
          json_ld_serializer => sub { shift->birth_date->ymd },
        );

    This allows you to specify a method for converting the data into an
    object that [JSON](https://metacpan.org/pod/JSON) can serialize.

# AUTHOR

Robert Rothenberg <rrwo@cpan.org>

# SEE ALSO

[MooX::Role::JSON\_LD](https://metacpan.org/pod/MooX%3A%3ARole%3A%3AJSON_LD)

# COPYRIGHT AND LICENSE

Copyright (C) 2018, Robert Rothenberg.  All Rights Reserved.

This script is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.
