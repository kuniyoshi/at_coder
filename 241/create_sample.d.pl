#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use Readonly;

Readonly my $MAX_X => 10 ** 18;
Readonly my $MAX_Q => 2 * 10 ** 5;

say $MAX_Q;

for my $i ( 1 .. ( $MAX_Q / 2 ) ) {
    say "1 ", int rand $MAX_X;
}

for my $i ( 1 .. ( $MAX_Q / 2 ) ) {
    if ( rand > 0.5 ) {
        say "2 ", ( int rand $MAX_X ), q{ }, ( int rand ( $MAX_Q / 2 ) );
    }
    else {
        say "3 ", ( int rand $MAX_X ), q{ }, ( int rand ( $MAX_Q / 2 ) );
    }
}


exit;

