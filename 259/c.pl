#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my @s = do { chomp( my $l = <> ); split m{}, $l };
my @t = do { chomp( my $l = <> ); split m{}, $l };

my @cs = convert( @s );
my @ct = convert( @t );

say YesNo::get( can( \@cs, \@ct ) );

exit;

sub can {
    my $s_ref = shift;
    my $t_ref = shift;

    for my $ref ( @{ $t_ref } ) {
        my $cursor = shift @{ $s_ref };

        return
            if $cursor->[0] ne $ref->[0];

        next
            if $cursor->[1] == $ref->[1];

        return
            if $cursor->[1] > $ref->[1];
        return
            if $cursor->[1] == 1;
    }

    return 1;
}

sub convert {
    my @s = @_;
    my @results;

    while ( @s ) {
        my $cursor = shift @s;
        my $count = 1;

        while ( @s && $s[0] eq $cursor ) {
            $count++;
            shift @s;
        }

        push @results, [ $cursor, $count ];
    }

    return @results;
}

use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
