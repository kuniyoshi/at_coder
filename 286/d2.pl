#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use Math::BigInt;

my( $n, $x ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @pairs = map { chomp; [ split m{\s} ] }
            map { scalar <> }
            1 .. $n;

my $bits = Math::BigInt->bone;

for my $ref ( @pairs ) {
    my( $a, $b ) = @{ $ref };
    my $c = Math::BigInt->bone;
    for my $i ( 1 .. $b ) {
        my $v = $bits->copy->blsft( $a ** $i );
        $c = $c->bior( $v );
    }

    $bits->bior( $c );
}

my $cant = $bits->band( Math::BigInt->bone->blsft( 1 << $x ) )->is_zero;

say YesNo::get( !$cant );

exit;

use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}
