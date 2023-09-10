#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $a, $b ) = do { chomp( my $l = <> ); split m{\s}, $l };
my $gcd = $a > $b ? gcd( $a, $b ) : gcd( $b, $a );
say $a * $b / $gcd;

exit;

sub gcd {
    my( $a, $b ) = @_;
    $a %= $b;
    return $b
        if $a == 0;
    return gcd( $b, $a );
}
