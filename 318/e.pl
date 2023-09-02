#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

my %indexes;

for ( my $i = 0; $i < $n; ++$i ) {
    push @{ $indexes{ $a[ $i ] } }, $i;
}

my $total = 0;
my @keys = sort { $a <=> $b } keys %indexes;

for my $key ( @keys ) {
    warn "\$key: $key";
    next
        if @{ $indexes{ $key } } == 1;

    my @counts;

    for ( my $i = 1; $i < @{ $indexes{ $key } }; ++$i ) {
        for my $other ( @keys ) {
            next
                if $other == $key;
            warn "\$other: $other";

            push @counts, bin( @{ $indexes{ $key } }[ $i - 1, $i ], $indexes{ $other } );
        }
    }

    my $count = 0;

    for ( my $i = 0; $i < @counts; ++$i ) {
        $count += $counts[ $i ] * ( @counts - $i );
    }

    $total += $count;
}

say $total;

exit;

sub bin {
    my( $start, $end, $candidates ) = @_;
    my $l = bin2( $start, $candidates );
    my $r = bin2( $end, $candidates );
    return 1
        if defined $l && !defined $r;
    return 1
        if !defined $l && defined $r;
    return 0
        if !defined $l || !defined $r;
    return 0
        if $candidates->[ $l ] > $start || $candidates->[ $r ] < $end;
    return 1
        if $l == $r;
    die "($l, $r): ", join q{, }, @{ $candidates };
    return $candidates->[ $r ] - $candidates->[ $l + 1 ] + 1;
}

sub bin2 {
    my $i = shift;
    my $ref = shift;

    return
        if $ref->[0] > $i;
    return $#{ $ref }
        if $ref->[-1] < $i;

    my $ac = 0;
    my $wa = $#{ $ref };

    while ( $wa - $ac > 1 ) {
        my $wj = int( ( $ac + $wa ) / 2 );
        if ( $ref->[ $wj ] < $i ) {
            $ac = $wj;
        }
        else {
            $wa = $wj;
        }
    }

    return $ac;
}
