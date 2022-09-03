#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( all );

my @pins = do { chomp( my $l = <> ); split m{}, $l };
my @cols;

my %column = (
    1 => 4,
    2 => 3,
    3 => 5,
    4 => 2,
    5 => 4,
    6 => 6,
    7 => 1,
    8 => 3,
    9 => 5,
    10 => 7
);
$_--
    for values %column;

for ( my $i = 0; $i < @pins; ++$i ) {
    $cols[ $column{ $i + 1 } ]++
        if $pins[ $i ];
}

shift @cols
    while @cols && !defined $cols[0];
pop @cols
    while @cols && !defined $cols[-1];

my @rules;
push @rules, !$pins[0];
push @rules, @cols >= 3 && scalar( grep { !defined $_ } @cols );

say YesNo::get( all { $_ } @rules );

exit;

use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
