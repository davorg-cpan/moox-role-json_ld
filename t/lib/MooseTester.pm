package MooseTester;

use Moose;
with 'MooX::Role::JSON_LD';

has foo => (
  is => 'ro',
  default => 'Foo',
);

has bar => (
  is => 'ro',
  default => 'Bar',
);

sub json_ld_type { 'Example' }
sub json_ld_fields { [ qw[ foo bar ], {
  bax => 'bar',
  baz => sub { $_[0]->bar . ' ' . $_[0]->foo },
} ] }

no Moose;
__PACKAGE__->meta->make_immutable;

1;