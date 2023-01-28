#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my @s = do { chomp( my $l = <> ); split m{}, $l };
my @t = do { chomp( my $l = <> ); split m{}, $l };

my @fronts = ( 0 );
my @backs = ( 0 );

my $acc = 0;

for ( my $i = 0; $i < @t; ++$i ) {
    $acc++
        if $s[ $i ] eq $t[ $i ] || $s[ $i ] eq q{?} || $t[ $i ] eq q{?};

    push @fronts, $acc;
}

$acc = 0;

my $diff = @s - @t;

for ( my $i = @s - @t; $i < @s; ++$i ) {
    $acc++
        if $s[ $i ] eq $t[ $i - $diff ] || $s[ $i ] eq q{?} || $t[ $i - $diff ] eq q{?};

    push @backs, $acc;
}

for my $i ( 0 .. @t ) {
    my $fc = $i;
    my $bc = @t - $fc;

    my $fy = $fronts[ $fc ];
    my $by = $backs[ -1 ] - $backs[ -1 - $bc ];

    say YesNo::get( $fy + $by == @t );
}

exit;

use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}
