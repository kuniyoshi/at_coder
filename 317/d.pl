#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( sum );

chomp( my $n = <> );
my @xyz = map { chomp; [ split m{\s} ] }
          map { scalar <> }
          1 .. $n;

my $total_seats = sum( map { $_->[-1] } @xyz );

my @dp;

for ( my $i = 0; $i < $n; ++$i ) {
    for ( my $j = 0; $j <= $total_seats; ++$j ) {
        $dp[ $i ][ $j ] = 
    }
}

__END__

my $wa = 0;
my $ac = 1e9;

while ( $ac - $wa > 1 ) {
    my $wj = int( ( $ac + $wa ) / 2 );
    if ( t( $wj ) ) {
        $ac = $wj;
    }
    else {
        $wa = $wj;
    }
}

say $ac;

exit;

sub t {
    my $count = shift;
}

__END__
my %seat;

for my $ref ( @xyz ) {
    my( $x, $y, $z ) = @{ $ref };
    push @{ $seat{ $z } }, [ $x, $y ];
}

my @seats = do {
    my @numbers = sort { $a <=> $b } map { $_->[-1] } @xyz;
    my $acc = 0;
    map { $acc += $_ } @numbers;
};

my $wa = 0;
my $ac = $#seats;

while ( $ac - $wa 

exit;
