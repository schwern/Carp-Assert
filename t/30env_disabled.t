#!/usr/bin/perl -w


use strict;

# Test with assert on.

$| = 1;
print "1..5\n";
my $t_num = 1;

local $@;
$@ = '';

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
print "not " if $@;
print "ok ",$t_num++,"\n";

$@ = '';
eval { assert(1==0); };
print "not " if $@;
print "ok ",$t_num++,"\n";

$@ = '';
eval { should('this', 'moofer') if DEBUG };
print "not " if $@ ne '';
print "ok ".$t_num++."\n";

$@ = '';
eval { shouldnt('this', 'this') };
print "not " if $@ ne '';
print "ok ".$t_num++."\n";

$@ = '';
eval { shouldn't('this', 'this') };
print "not " if $@ ne '';
print "ok ".$t_num++."\n";
