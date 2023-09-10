#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my %index = (
    0 => [ 0, 3, 6 ],
    1 => [ 0, 4 ],
    2 => [ 0, 5, 7 ],
    3 => [ 1, 3 ],
    4 => [ 1, 4, 6, 7 ],
    5 => [ 1, 5 ],
    6 => [ 2, 3, 7 ],
    7 => [ 2, 4 ],
    8 => [ 2, 5, 6 ],
);
my @numbers = map { @{ $_ } }
              map { chomp; [ split m{\s} ] }
              map { scalar <> }
              1 .. 3;
              #my @numbers = ( 1, 1, 2, 3 );

my $count = 0;

dfs( [ ], { } );

say $count;

my $whole = kaijou( scalar @numbers );

say( ( $whole - $count ) / $whole );

exit;

sub dfs {
    my $history_ref = shift;
    my $used_ref = shift;

    if ( @{ $history_ref } == @numbers ) {
        #        say join q{, }, @{ $history_ref };
        $count += judge( $history_ref );
        return;
    }

    for ( my $i = 0; $i < @numbers; ++$i ) {
        next
            if $used_ref->{ $i };
        push @{ $history_ref }, $i;
        $used_ref->{ $i }++;
        dfs( $history_ref, $used_ref );
        delete $used_ref->{ $i };
        pop @{ $history_ref };
    }
}

sub judge {
    my $ref = shift;
    my @values;

    for ( my $i = 0; $i < @{ $ref }; ++$i ) {
        push @{ $values[ $_ ] }, $numbers[ $ref->[ $i ] ]
            for @{ $index{ $ref->[ $i ] } };
    }

    for my $ref ( @values ) {
        return 1
            if $ref->[0] == $ref->[1] && $ref->[2] != $ref->[0];
    }

    return 0;
}

sub kaijou {
    my $v = shift;
    my $result = 1;
    while ( $v ) {
        $result *= $v--;
    }
    return $result;
}
