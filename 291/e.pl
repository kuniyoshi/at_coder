#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @xy = map { chomp; [ split m{\s} ] }
         map { scalar <> }
         1 .. $m;

my %out_degree;
my %link;

for my $ref ( @xy ) {
    my( $x, $y ) = @{ $ref };
    $out_degree{ $x }++
        unless $link{ $y }{ $x };
    $link{ $y }{ $x }++;
}

my @s = grep { !$out_degree{ $_ } } 1 .. $n;

if ( !@s ) {
    say YesNo::get( 0 );
    exit;
}

my @l;

while ( @s ) {
    if ( @s > 1 ) {
        say YesNo::get( 0 );
        exit;
    }
    my $v = shift @s;
    push @l, $v;
    for my $w ( keys %{ $link{ $v } // { } } ) {
        delete $link{ $v }{ $w };
        if ( $out_degree{ $w } ) {
            $out_degree{ $w }--;
            push @s, $w
                unless $out_degree{ $w };
        }
    }
}

say YesNo::get( 1 );
say join q{ }, map { $n - $_ + 1 } @l;

exit;

use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
