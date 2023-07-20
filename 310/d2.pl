#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $t, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @pairs = map { chomp; [ split m{\s} ] }
            map { scalar <> }
            1 .. $m;

my %bad;

for my $ref ( @pairs ) {
    my( $a, $b ) = @{ $ref };
    $bad{ $a }{ $b }++;
    $bad{ $b }{ $a }++;
}

say dfs( [ ], 1 );

exit;

sub dfs {
    my $teams_ref = shift;
    my $who = shift;

    return $t == @{ $teams_ref }
        if $who > $n;

    push @{ $teams_ref }, [ $who ];
    my $count = dfs( $teams_ref, $who + 1 );
    pop @{ $teams_ref };

    for my $ref ( @{ $teams_ref } ) {
        next
            if grep { $bad{ $_ }{ $who } } @{ $ref };

        push @{ $ref }, $who;
        $count += dfs( $teams_ref, $who + 1 );
        pop @{ $ref };
    }

    return $count;
}
