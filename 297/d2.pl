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

while ( $a != 0 && $b != 0 ) {
    my( $large, $small ) = $a > $b ? ( \$a, \$b ) : ( \$b, \$a );
    $count += int( $$large / $$small );
    $$large %= $$small;
}

say $count;

exit;
