#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $a, $b, $c ) = do { chomp( my $l = <> ); split m{\s}, $l };

if ( $a + $b + 1 >= $c ) {
    say $c + $b;
}
else {
    say $b + $a + $b + 1;
}


exit;

__END__
1 2 3 -> 5 -> 
A + B + 1 = C -> B + C
1 1 3 -> 4 -> B + C
A + B + 1 < C -> C の個数: (A + B + 1), + B
