#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @a = map { chomp; [ split m{\s} ] }
        map { scalar <> }
        1 .. $n;
my @b = map { chomp; [ split m{\s} ] }
        map { scalar <> }
        1 .. $n;

for my $i ( 0 .. 3 ) {
    if ( is_match( ) ) {
        say YesNo::get( 1 );
        exit;
    }
    rotate( );
}

say YesNo::get( 0 );

exit;

sub rotate {
    my @c = map { [ @{ $_ } ] } @a;
    for my $i ( 0 .. $n - 1 ) {
        for my $j ( 0 .. $n - 1 ) {
            $c[ $i ][ $j ] = $a[ $n - 1 - $j ][ $i ];
        }
    }
    @a = @c;
}

sub is_match {
    for my $i ( 0 .. $n - 1 ) {
        for my $j ( 0 .. $n - 1 ) {
            next
                unless $a[ $i ][ $j ];
            return
                unless $b[ $i ][ $j ];
        }
    }

    return 1;
}

use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
