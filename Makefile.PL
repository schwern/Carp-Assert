use ExtUtils::MakeMaker;

warn "Carp::Assert likes to have B::Deparse but can't find it.\n" unless 
  eval { require B::Deparse };

WriteMakefile(
    NAME        => 'Carp::Assert',
    VERSION_FROM => 'lib/Carp/Assert.pm', # finds $VERSION
    PREREQ_PM   => { Carp       => 0,
                     Test::More => 0.40,
                   },
    'dist'      => {COMPRESS => 'gzip -9',
                    SUFFIX   => '.gz',
                    DIST_DEFAULT => 'all tardist',
                   },
);

{
    package MY;
    sub top_targets {
        my($self) = @_;

        return $self->SUPER::top_targets(@_) unless
          eval { require Test::Inline; 1 };

        my $out = "POD2TEST_EXE = pod2test\n";

        $out .= $self->SUPER::top_targets(@_);
        $out =~ s/^(pure_all\b.*)/$1 testifypods/m;

        $out .= "\n\ntestifypods : \n";

        foreach my $pod (keys %{$self->{MAN1PODS}},
                         keys %{$self->{MAN3PODS}})
        {
            (my $test = $pod) =~ s/\.(pm|pod)$//;
            $test =~ s/^lib\W//;
            $test =~ s/\W/-/;
            $test = "embedded-$test.t";
            $out .= "\t$self->{NOECHO}\$(POD2TEST_EXE) $pod t/$test \\\n";
        }

        return $out;
    }


    sub test_via_harness {
        my($self, $orig_perl, $tests) = @_;

        my @perls = ($orig_perl);
        push @perls, qw(bleadperl
                        perl5.6.1
                        perl5.005_03
                        perl5.004_05
                        perl5.004_04
                        perl5.004
                       )
          if $ENV{PERL_TEST_ALL};

        my $out;
        foreach my $perl (@perls) {
            $out .= $self->SUPER::test_via_harness($perl, $tests);
        }

        return $out;
    }
}
