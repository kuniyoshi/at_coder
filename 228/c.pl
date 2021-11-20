#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( sum );

my ( $n, $k ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @p = map { chomp; sum split m{\s} }
        map { scalar <> }
        1 .. $n;

my @scores = sort { $b <=> $a }
             @p;

my %count;

for my $score ( @scores ) {
    $count{ $score }++;
}

my $target;
my $ranking = 0;
my $border = $scores[0] + 1;
$count{ $border }++;
push @scores, -1;

for my $score ( @scores ) {
    if ( $score < $border ) {
        $ranking = $ranking + $count{ $border };

        if ( $ranking == $k ) {
            $target = $score;
            last;
        }

        if ( $ranking > $k ) {
            $target = $border;
            last;
        }

        $border = $score;
    }
}

die "No target found"
    unless defined $target;

$target = $scores[1]
    if $target == $scores[0];

for my $p ( @p ) {
    my $can_be = $p + 300 >= $target;
    say $can_be ? "Yes" : "No";
}

exit;
