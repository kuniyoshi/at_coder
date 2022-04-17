#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @a = do { chomp( my $l = <> ); split m{\s}, $l };
chomp( my $q = <> );
my @queries = map { chomp; [ split m{\s} ] }
              map { scalar <> }
              1 .. $q;

my %x;

for my $ref ( @queries ) {
    my( $l, $r, $x ) = @{ $ref };
    $x{ $x }++;
}

my %counts;

for my $i ( 0 .. $#a ) {
    next
        unless $x{ $a[ $i ] };

    if ( !exists $counts{ $a[ $i ] } ) {
        push @{ $counts{ $a[ $i ] } }, [ $i, 1 ];
    }
    else {
        push @{ $counts{ $a[ $i ] } }, [ $i, $counts{ $a[ $i ] }[-1][1] + 1 ];
    }
}

#warn Dumper \%counts;

for my $ref ( @queries ) {
    my( $l, $r, $x ) = @{ $ref };
    $l--;
    $r--;
    #warn "($l, $r, $x)";

    if ( !$counts{ $x } ) {
        #warn "not included: $x";
        say 0;
        next;
    }

    if ( $counts{ $x }[0][0] > $r ) {
        #warn "r is out of range: $r";
        say 0;
        next;
    }

    if ( $counts{ $x }[-1][0] < $l ) {
        #warn "l is out of range: $l";
        say 0;
        next;
    }

    if ( @{ $counts{ $x } } == 1 ) {
        say $counts{ $x }[0][1];
        next;
    }

    my $L = undef;

    if ( @{ $counts{ $x } } > 1 && $counts{ $x }[0][0] <= $l && $counts{ $x }[-1][0] > $l ) {
        my $ac = 0;
        my $wa = $#{ $counts{ $x } };

        while ( $wa - $ac > 1 ) {
            my $wj = int( $ac + $wa ) / 2;
            if ( $counts{ $x }[ $wj ][0] <= $l ) {
                $ac = $wj;
            }
            else {
                $wa = $wj;
            }
        }

        $L = $ac;
    }

    my $R = undef;

    if ( @{ $counts{ $x } } > 1 && $counts{ $x }[0][0] < $r && $counts{ $x }[-1][0] >= $r ) {
        my $ac = $#{ $counts{ $x } };
        my $wa = 0;

        while ( $ac - $wa > 1 ) {
            my $wj = int( $ac + $wa ) / 2;
            if ( $counts{ $x }[ $wj ][0] >= $r ) {
                $ac = $wj;
            }
            else {
                $wa = $wj;
            }
        }

        $R = $ac;
    }

    if ( defined $L && defined $R ) {
        say $counts{ $x }[ $R ][1] - $counts{ $x }[ $L ][1];
        next;
    }

    if ( defined $L ) {
        say $counts{ $x }[-1][1] - $counts{ $x }[ $L ][1];
    }
    elsif ( defined $R ) {
        say $counts{ $x }[ $R ][1];
    }
    else {
        say $counts{ $x }[-1][1];
    }
}

exit;
