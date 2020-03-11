use strict;
use warnings;

use Test::More;

use Data::Dumper;
{
  package LD::Person;
  use Moo;
  use MooX::JSON_LD 'Person';

  has name => (
    is => 'ro',
    json_ld => 'name',
  );

  has parent => (
    is => 'ro',
    json_ld => 'parent',
  );

  no Moo;
  no MooX::JSON_LD;
}

my $parent = LD::Person->new(
  name => 'A Parent',
);

my $child = LD::Person->new(
  name => 'A Child',
  parent => $parent,
);

diag Dumper $child->json_ld_data;

ok(1);

done_testing;
