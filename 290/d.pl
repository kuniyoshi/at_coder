#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use POSIX qw( ceil floor );

chomp( my $t = <> );

while ( $t-- ) {
    solve( );
}

exit;

sub solve {
    my( $n, $d, $k ) = do { chomp( my $l = <> ); split m{\s}, $l };
    $d = $d % $n;
    $k--;
    my $group_count = $d ? ceil( $n / $d ) : 1;
    my $group = $k % $d;
    warn "\$group: $group";

    say( ( $group + ( $d * $k ) ) % $n );

    return;
    my $index = int( $k / $group_count );
    my $candidate = $d * $group + $index;

    if ( $candidate == $n ) {
        say $candidate - $d;
    }
    else {
        say $candidate;
    }
}
