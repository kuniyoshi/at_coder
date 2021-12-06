#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $d ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @walls = sort { $a->[1] <=> $b->[1] }
            map { chomp; [ split m{\s} ] }
            map { scalar <> }
            1 .. $n;

my $count = 0;
my @punched = ( -$d, -$d );

for my $wall_ref ( @walls ) {
    my( $begin, $end ) = @{ $wall_ref };
    my $is_in = ( $begin <= $punched[0] && $end >= $punched[1] )
        || ( $begin >= $punched[0] && $begin <= $punched[1] )
        || ( $end >= $punched[0] && $end <= $punched[1] )
        || ( $begin >= $punched[0] && $end <= $punched[1] );

    next
        if $is_in;

    @punched = ( $end, $end + $d - 1 );
    $count++;
}

say $count;

exit;
