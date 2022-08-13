#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $h1, $w1 ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = map { chomp; [ split m{\s} ] }
        map { scalar <> }
        1 .. $h1;
my( $h2, $w2 ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @b = map { chomp; [ split m{\s} ] }
        map { scalar <> }
        1 .. $h2;

my $out = test( [ ], [ ] );
say YesNo->get( $out );

exit;

sub test {
    my( $r_ref, $c_ref ) = @_;
    warn sprintf "### [%s], [%s]", join( q{, }, @{ $r_ref } ), join( q{, }, @{ $c_ref } );
    return
        if @{ $r_ref } >= $h2 || @{ $c_ref } >= $w2;

    for my $i ( ( $r_ref->[-1] // 0 ) .. $h1 - 1 ) {
        my @rows = ( @{ $r_ref }, $i );

        for my $j ( ( $c_ref->[-1] // 0 ) .. $w1 - 1 ) {
            next
                if $a[ $i ][ $j ] ne $b[ scalar @{ $r_ref } ][ scalar @{ $c_ref } ];
            my @cols = ( @{ $c_ref }, $j );
            my $can = test( [ @rows ], \@cols );
            return 1
                if $can;
            if ( @rows == $h2 && @cols == $w2 && $can ) {
                return 1;
            }
        }
    }

    return;
}

use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
