#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( sum max );

chomp( my $n = <> );
my @s = do { chomp( my $l = <> ); split m{}, $l };

my @links = map { [ ] } 1 .. $n;

for ( my $i = 0; $i < $n - 1; ++$i ) {
    if ( $s[ $i ] eq q{A} ) {
        push @{ $links[ $i ] }, $i + 1;
    }
    elsif ( $s[ $i ] eq q{B} ) {
        push @{ $links[ $i + 1 ] }, $i;
    }
    else {
        die "Unknown input: [$s[ $i ]]";
    }
}

#die Dumper \@links;

my @heights = ( 1 ) x $n;
my %heighers;

for ( my $i = 0; $i < $n; ++$i ) {
    $heighers{ $_ }++
        for @{ $links[ $i ] };
}

#die Dumper \%heighers;
dfs( $_, 0 )
    for grep { !$heighers{ $_ } } 0 .. ( $n - 1 );

#die Dumper \@heights;
say sum( @heights );

exit;

sub dfs {
    my $u = shift;
    my $previous = shift;

    $heights[ $u ] = max( $heights[ $u ], $previous + 1 );

    dfs( $_, $heights[ $u ] )
        for @{ $links[ $u ] };
}
