#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min );
use Memoize;

my( $n, $a, $b ) = do { chomp( my $l = <> ); split m{\s}, $l };

my @dp = ( 0 ) x ( $n + 1 );

for ( my $i = 0; $i < $n + 1; ++$i ) {
    $dp[ $i ]++
        if $i >= $a && !$dp[ $i - $a ];
    $dp[ $i ]++
        if $i >= $b && !$dp[ $i - $b ];
}

say $dp[ $n ] ? "First" : "Second";

__END__
memoize( "r" );

my( $n, $a, $b ) = do { chomp( my $l = <> ); split m{\s}, $l };
my $min = min( $a, $b );

say r( $n, 0 );

exit;

sub r {
    my $n = shift;
    my $who = shift;

    if ( $n < $min ) {
        if ( $who == 0 ) {
            #            warn "($n, $who): Second";
            return "Second";
        }
        else {
            #            warn "($n, $who): First";
            return "First";
        }
    }

    my $ra = r( $n - $a, $who ^ 1 );
    my $rb = r( $n - $b, $who ^ 1 );

    if ( $ra eq $rb ) {
        return $ra;
    }

    #    warn "($n, $who): ", $who == 0 ? "First" : "Second";
    return $who == 0 ? "First" : "Second";
}
