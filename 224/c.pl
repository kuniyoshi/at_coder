#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @v = sort { ( $a->[0] + $a->[1] ) <=> ( $b->[0] + $b->[1] ) }
        map { chomp; [ split m{\s} ] }
        map { <> }
        1 .. $n;

my $count = 0;

for my $i ( 0 .. $n - 3 ) {
    for my $j ( $i + 1 .. $n - 2 ) {
        for my $k ( $j + 1 .. $n - 1 ) {
            warn "($v[$i][0], $v[$i][1])";
            warn "($v[$j][0], $v[$j][1])";
            warn "($v[$k][0], $v[$k][1])";
            my $x = $v[ $j ][0] - $v[ $i ][0];
            my $y = $v[ $j ][1] - $v[ $i ][1];
            next
                if $v[ $i ][0] + 2 * $x == $v[ $k ][0] and $v[ $i ][1] + 2 * $y == $v[ $k ][1];
            my $ijx = $v[ $j ][0] - $v[ $i ][0];
            my $ikx = $v[ $k ][0] - $v[ $i ][0];

            my $ijy = $v[ $j ][1] - $v[ $i ][1];
            my $iky = $v[ $k ][1] - $v[ $i ][1];

            #            next
            #                if $ijx == 0 and $ikx == 0;
            #            next
            #                if $ijy == 0 and $iky == 0;
            #
            #                warn "\$ijx $ijx";
            #                warn "\$ikx $ikx";
            #                warn "\$ijy $ijy";
            #                warn "\$iky $iky";
            #            next
            #                if ( ( $v[ $i ][0] + 2 * $ijx ) == $v[ $k ][0] and ( $v[ $i ][1] + 2 * $ijy ) == $v[ $k ][1] );


warn "count up ($i, $j, $k)";
            $count++;
        }
    }
}

say $count;

exit;
