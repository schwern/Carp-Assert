#!/usr/bin/perl -w

# Test environment variable control

use strict;
use Test::More tests => 5;


my %Saved_Env;
my @Env_Keys;
BEGIN {
    @Env_Keys = qw(PERL_NDEBUG NDEBUG);
}

BEGIN {
    # Normalize the environment.
    # This extra work to save and restore %ENV is necessary because on 
    # VMS %ENV persists between processes
    for my $key (@Env_Keys) {
        next unless exists $ENV{$key};
        $Saved_Env{$key} = delete $ENV{$key};
    }
    
    $ENV{NDEBUG} = 1;
}

END {
    for my $key (@Env_Keys) {
        delete $ENV{$key};
        $ENV{$key} = $Saved_Env{$key} if exists $Saved_Env{$key};
    }
}

use Carp::Assert;
eval { assert(1==0) if DEBUG; };
is $@, '';


eval { assert(1==0); };
is $@, '';


eval { should('this', 'moofer') if DEBUG };
is $@, '';


eval { shouldnt('this', 'this') };
is $@, '';


eval { shouldn't('this', 'this') };
is $@, '';
