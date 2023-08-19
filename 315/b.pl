#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( sum );

chomp( my $m = <> );
my @d = do { chomp( my $l = <> ); split m{\s}, $l };

my $day = int( sum( @d ) / 2 ) + 1;

for ( my $i = 0; $i < @d; ++$i ) {
    $day -= $d[ $i ];

    if ( $day <= 0 ) {
        say $i + 1, q{ }, $d[ $i ] + $day;
        exit;
    }
}

__END__

my @acc = ( 0 );

for my $d ( @d ) {
    push @acc, $acc[-1] + $d;
}



for ( my $i = 0; $i < @acc; ++$i ) {
    if ( $day <= $acc[ $i ] ) {
    }
}

exit;

__END__
my $day = int( sum( @d ) / 2 ) + 1;

my $acc = 0;
my $month = 0;

for ( my $i = 0; $i < @d; ++$i ) {
    last
        if $acc + $d[ $i ] > $day;
    $acc += $d[ $i ];
    $month++;
}

say $month + 1, q{ }, $day - $acc + 1;



exit;
