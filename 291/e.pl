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

my %in_degree;
my %link;

for my $ref ( @xy ) {
    my( $x, $y ) = @{ $ref };
    $in_degree{ $y }++
        unless $link{ $x }{ $y };
    $link{ $x }{ $y }++;
}

my @s = grep { !$in_degree{ $_ } } 1 .. $n;

if ( !@s ) {
    say YesNo::get( 0 );
    exit;
}

my @values;
my $value = 0;

while ( @s ) {
    if ( @s > 1 ) {
        say YesNo::get( 0 );
        exit;
    }
    my $v = shift @s;
    $values[ $v - 1 ] = ++$value;
    for my $w ( keys %{ $link{ $v } // { } } ) {
        $in_degree{ $w }--;
        push @s, $w
            if $in_degree{ $w } == 0;
    }
}

say YesNo::get( 1 );
#say join q{ }, map { $n - $_ + 1 } reverse @l;
say join q{ }, @values;

exit;

use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
