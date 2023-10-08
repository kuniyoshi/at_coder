#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( sum max );

my( $n, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = do { chomp( my $l = <> ); split m{\s}, $l };
my @s = map { chomp; [ split m{} ] }
        map { scalar <> }
        1 .. $n;
#die Dumper \@s;

my @sorted = map { $_->[0] } sort { $b->[1] <=> $a->[1] } map { [ $_, $a[ $_ ] ] } 0 .. $#a;
#die Dumper \@sorted;

my @scores;

for ( my $i = 0; $i < $n; ++$i ) {
    my $ref = $s[ $i ];
    my $score = $i + 1;
    push @scores, $score + ( sum( map { $_->[1] } grep { $ref->[ $_->[0] ] eq q{o} } map { [ $_, $a[ $_ ] ] } 0 .. ( $m - 1 ) ) // 0 );
}
#die Dumper \@scores;

for ( my $i = 0; $i < $n; ++$i ) {
    my $max = max( @scores[ 0 .. ( $i - 1 ), ( $i + 1 ) .. ( $n - 1 ) ] );
    die $i
        unless defined $max;
    my $current = $scores[ $i ];
    my $want_to = 0;

    for ( my $j = 0; $j < $m; ++$j ) {
        next
            if $s[ $i ][ $sorted[ $j ] ] eq q{o};

        last
            if $current > $max;

        $current += $a[ $sorted[ $j ] ];
        $want_to++;
    }

    say $want_to;
}

exit;
