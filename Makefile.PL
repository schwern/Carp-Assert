use ExtUtils::MakeMaker;

warn "Carp::Assert likes to have B::Deparse but can't find it.\n" unless 
  eval { require B::Deparse };

WriteMakefile(
    'NAME'  => 'Carp::Assert',
    'VERSION_FROM' => 'lib/Carp/Assert.pm', # finds $VERSION
     'PREREQ_PM' => { Carp => 0 },
     'dist'      => {COMPRESS => 'gzip -9',
                     SUFFIX   => '.gz',
                     DIST_DEFAULT => 'all tardist',
                    },
);
