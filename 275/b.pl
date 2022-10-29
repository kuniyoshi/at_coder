#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my $MOD = 998244353;

my( $a, $b, $c, $d, $e, $f ) = map { $_ % $MOD } do { chomp( my $l = <> ); split m{\s}, $l };

my $abc = m_mod( m_mod( $a, $b ), $c );
my $def = m_mod( m_mod( $d, $e ), $f );

my $result = $abc > $def ? s_mod( $abc, $def ) : s_mod( $abc + $MOD, $def );

say $result;

exit;

sub s_mod {
    my $x = shift;
    my $y = shift;
    my $z = ( $x - $y ) % $MOD;
    return $z;
}

sub m_mod {
    my $x = shift;
    my $y = shift;
    return( ( $x * $y ) % $MOD );
}
