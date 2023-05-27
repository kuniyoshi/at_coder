#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my @c = map { chomp; [ split m{\s} ] }
        map { scalar <> }
        1 .. 3;

SEARCH:
for my $a1 ( 0 .. 100 ) {
    my @b = map { $c[0][ $_ ] - $a1 } 0 .. 2;
    my $a2 = $c[1][0] - $b[0];
    my $a3 = $c[2][0] - $b[0];
    my @a = ( $a1, $a2, $a3 );

    for my $i ( 0 .. 2 ) {
        for my $j ( 0 .. 2 ) {
            next SEARCH
                if $a[ $i ] + $b[ $j ] != $c[ $i ][ $j ];
        }
    }

    say YesNo::get( 1 );
    exit;
}

say YesNo::get( 0 );

exit;

use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
__END__
c11 = a1 + b1
c12 = a1 + b2
c13 = a1 + b3
c21 = a2 + b1
c22 = a2 + b2
c23 = a2 + b3
c31 = a3 + b1
c32 = a3 + b2
c33 = a3 + b3

c12 - c11 = b2 - b1
c13 - c11 = b3 - b1
c13 - c12 = b3 - b2

c13 - c11 = b3 - ( -( c12 - c11 ) + b2 )

a1 + b1     a1 + b2     a1 + b3 = 3 a1 + b1 + b2 + b3
a2 + b1     a2 + b2     a2 + b3 = 3 a2 + b1 + b2 + b3
a3 + b1     a3 + b2     a3 + b3 = 3 a3 + b1 + b2 + b3
3 b1 + a{1,2,3}
            3 b2 + a{1,2,3}
                        3 b3 + a{1,2,3}
