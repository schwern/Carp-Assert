#!/usr/bin/perl -w

# Test with assert on.

use strict;
use Test::More tests => 8;


use Carp::Assert;
eval { assert(1==0) if DEBUG; };
like $@, '/^Assertion failed/i';


eval { assert(1==1); };
is $@, '';


eval { assert(Dogs->isa('People'), 'Dogs are people, too!') };
like $@, '/Dogs are people, too!/';


eval { should('this', 'this') };
is $@, '';


eval { should('this', 'that') };
like $@, '/^Assertion \(.*\) failed/i';


eval { shouldnt('this', 'that') };
is $@, '';


eval { shouldnt('up', 'up') };
like $@, '/^Assertion \(.*\) failed/i';


eval { shouldn't('up', 'up') };
like $@, '/^Assertion \(.*\) failed/i';
