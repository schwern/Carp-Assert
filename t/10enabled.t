#!/usr/bin/perl


use strict;

# Test with assert on.

$| = 1;
print "1..8\n";
my $t_num = 1;

local $@;
$@ = '';

use Carp::Assert;
eval { assert(1==0) if DEBUG; };
print "not " if($@ eq '' || $@ !~ /^Assertion failed/i);
print "ok ".$t_num++."\n";

$@ = '';
eval { assert(1==1); };
print "not " if $@ ne '';
print "ok ".$t_num++."\n";

eval { assert(Dogs->isa('People'), 'Dogs are people, too!') };
print "not " unless $@ =~ /Dogs are people, too!/;
print "ok ".$t_num++."\n";

eval { should('this', 'this') };
print "not " if $@ ne '';
print "ok ".$t_num++."\n";

eval { should('this', 'that') };
print "not " if $@ !~ /^Assertion \(.*\) failed/i;
print "ok ".$t_num++."\n";

eval { shouldnt('this', 'that') };
print "not " if $@ ne '';
print "ok ".$t_num++."\n";

eval { shouldnt('up', 'up') };
print "not " if $@ !~ /^Assertion \(.*\) failed/i;
print "ok ".$t_num++."\n";

eval { shouldn't('up', 'up') };
print "not " if $@ !~ /^Assertion \(.*\) failed/i;
print "ok ".$t_num++."\n";
