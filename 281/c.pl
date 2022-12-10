#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( sum );

my( $n, $t ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

my $total = sum( @a );
my $remain = $t % $total;

my( $music, $elapsed ) = progress( $remain );
$music++;

say join q{ }, $music, $elapsed;

exit;

sub progress {
    my $remain = shift;
    my $elapsed = 0;
    for my $i ( 0 .. $#a ) {
        my $next = $elapsed + $a[ $i ];
        if ( $next >= $remain ) {
            return $i, $remain - $elapsed;
        }
        $elapsed = $next;
    }
    die "Could not found";
}
