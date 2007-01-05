#!/usr/bin/perl -w

# Test with assert off.


use strict;
use Test::More tests => 4;


use Carp::Assert qw(:NDEBUG);
eval { assert(1==0) if DEBUG; };
is $@, '';


eval { assert(1==0); };
is $@, '';


eval { should('this', 'moofer') if DEBUG };
is $@, '';


eval { shouldnt('this', 'this') };
is $@, '';
