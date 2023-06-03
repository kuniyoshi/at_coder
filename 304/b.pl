#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max );

chomp( my $n = <> );

my $length = length $n;

while ( length( $n ) > 3 ) {
    $n = int( $n / 10 );
}

while ( length( $n ) != $length ) {
    $n *= 10;
}

say $n;

__END__

if ( $n < 1000 ) {
    say $n;
    exit;
}


say int( $n / ( 10 ** max( $length - 3, 3 ) ) ) * 10 ** max( $length - 3, 3 );

exit;
