use ExtUtils::MakeMaker 6.64;

WriteMakefile(
    NAME              => 'MooX::Role::JSON_LD',
    VERSION_FROM      => 'lib/MooX/Role/JSON_LD.pm',
    MIN_PERL_VERSION  => '5.6.0',
    PREREQ_PM         => {
        List::Util      => 1.33,
        Moo             => 0,
        Sub::Quote      => 0, # no longer part of Moo
        Types::Standard => 0,
        JSON::MaybeXS   => 0,
    },
    TEST_REQUIRES => {
        Moose => 0,
    },
    BUILD_REQUIRES    => {
        Test::More    => 0,
        namespace::autoclean => 0,
    },
    ABSTRACT_FROM     => 'lib/MooX/Role/JSON_LD.pm',
    AUTHOR            => 'Dave Cross <dave@perlhacks.com>',
    LICENSE           => 'perl',
    MIN_PERL_VERSION  => '5.6.0',
    META_MERGE        => {
        'meta-spec' => { version => 2 },
        resources => {
            repository => {
                type => 'git',
                url => 'git://github.com/davorg-cpan/moox-role-json_ld.git',
                web => 'https://github.com/davorg-cpan/moox-role-json_ld',
            },
            bugtracker => {
                "web" => "https://github.com/davorg-cpan/moox-role-json_ld/issues"
            }
        },
        x_contributors => [
            'Robert Rothenberg <rrwo@cpan.org>',
            'Mohammad S Anwar <mohammad.anwar@yahoo.com>',
            'Anirvan Chatterjee <anirvan@cpan.org>',
        ],
    },
);
