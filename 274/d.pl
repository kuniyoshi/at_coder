#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( sum );

my( $n, $x, $y ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

my $can_x = can( $x - $a[0], map { $a[ $_ ] } grep { $_ > 1 && !( $_ % 2 ) } 0 .. $#a );
my $can_y = can( $y, map { $a[ $_ ] } grep { $_ % 2 } 0 .. $#a );

#warn "x: ", YesNo::get( $can_x );
#warn "y: ", YesNo::get( $can_y );

say YesNo::get( $can_x && $can_y );

exit;

sub can {
    my $goal = shift;
    my @steps = @_;

    if ( !@steps ) {
        return $goal == 0;
    }

    my $length = sum( @steps );
    my $min = -$length;
    my $max = $length;

    my @dp;
    $dp[0]{0}++;

    for my $i ( 1 .. @steps ) {
        my $step = $steps[ $i - 1 ];
        for my $j ( $min .. $max ) {
            next
                unless $dp[ $i - 1 ]{ $j };
            $dp[ $i ]{ $j + $step }++;
            $dp[ $i ]{ $j - $step }++;
        }
    }

    #    warn Dumper \@dp;

    return $dp[ @steps ]{ $goal };
}

use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
