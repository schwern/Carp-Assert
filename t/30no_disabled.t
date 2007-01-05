#!/usr/bin/perl -w

# Test "no Carp::Assert"

use strict;
use Test::More tests => 4;


no Carp::Assert;
eval { assert(1==0) if DEBUG; };
is $@, '';


eval { assert(1==0); };
is $@, '';


eval { should('this', 'moofer') if DEBUG };
is $@, '';


eval { shouldnt('this', 'this') };
is $@, '';
