#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use Bitset;
use Test::More;

plan tests => 2;

my $a = Bitset->new( 100 + 1 )->one;
$a->shift_left( 100 );
is( $a->dump, "1000000000000000000000000000000000000_0000000000000000000000000000000000000000000000000000000000000000" );

my $b = Bitset->new( 100 + 1 )->one;
$b->or( $a );
is( $b->dump, "1000000000000000000000000000000000000_0000000000000000000000000000000000000000000000000000000000000001" );

__END__

my $b = Bitset->new( 100 + 1 );

for my $i ( 0 .. 100 ) {
    my $x = Bitset->new( 100 + 1 )->one;
    $x->shift_left( $i );
    $b->or( $x );
}

is( $b->dump, "1111111111111111111111111111111111111_1111111111111111111111111111111111111111111111111111111111111111" );



exit;

