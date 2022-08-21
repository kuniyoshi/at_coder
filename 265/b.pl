#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $m, $t ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = do { chomp( my $l = <> ); split m{\s}, $l };
my @bonuses = map { chomp; [ split m{\s} ] }
              map { scalar <> }
              1 .. $m;

my %bonus;
$bonus{ $_->[0] - 1 } = $_->[1]
    for @bonuses;

say YesNo::get( can( ) );

exit;

sub can {
    my $has = $t;

    for my $i ( 0 .. $n - 2 ) {
        my $require = $a[ $i ];

        return
            if $has <= $require;

        $has -= $require;
        $has += $bonus{ $i + 1 } // 0;
    }

    return 1;
}

use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
