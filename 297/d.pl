#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use POSIX qw( floor );
use bigint;

my( $a, $b ) = do { chomp( my $l = <> ); split m{\s}, $l };

my $count = 0;

while ( $a != $b ) {
    my( $large, $small ) = $a > $b ? ( \$a, \$b ) : ( \$b, \$a );

    my $ac = 1;
    my $wa = int( ${ $large } / ${ $small } ) + 1;

    while ( $wa - $ac > 1 ) {
        my $wj = int( ( $ac + $wa ) / 2 );
        if ( $$large >= ( 1 + $wj ) * $$small ) {
            $ac = $wj;
        }
        else {
            $wa = $wj;
        }
    }

    $count += $ac;

    ${ $large } = ${ $large } - $ac * ${ $small };
}

say $count;

exit;
