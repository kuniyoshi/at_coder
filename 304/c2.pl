#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use Memoize;

my( $n, $d ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @people = map { chomp; [ split m{\s} ] }
             map { scalar <> }
             1 .. $n;

my %link;

for my $i ( 0 .. $n - 1 ) {
    for my $j ( 0 .. $i - 1 ) {
        my $dx = $people[ $i ][0] - $people[ $j ][0];
        my $dy = $people[ $i ][1] - $people[ $j ][1];
        my $is = $dx * $dx + $dy * $dy <= $d * $d;

        next
            unless $is;

        push @{ $link{ $i } }, $j;
        push @{ $link{ $j } }, $i;
    }
}

my @infections = ( 0 ) x $n;

my @queue = ( 0 );

while ( @queue ) {
    my $v = shift @queue;
    next
        if $infections[ $v ]++;

    push @queue, grep { !$infections[ $_ ] } @{ $link{ $v } // [ ] };
}

say map { YesNo::get( $_ ), "\n" } @infections;

exit;

use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
