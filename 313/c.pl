#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( sum max min );

chomp( my $n = <> );
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

if ( @a == 1 ) {
    say 0;
    exit;
}

my $sum_a = sum( @a );

my $mean = int( $sum_a / $n );
my $remain = $sum_a % $mean;

say solve( $mean, $remain );

exit;

sub solve {
    my $mean = shift;
    my $remain = shift;
    my @to_be = (
        ( $mean ) x ( $n - $remain ),
        ( $mean + 1 ) x $remain,
    );
    my @originals = sort { $a <=> $b } @a;
    my $diff = sum( map { abs( $to_be[ $_ ] - $originals[ $_ ] ) } 0 .. $n - 1 );
    return $diff / 2;
}

sub t {
    my $mean = shift;
    my @positives = grep { $_ > $mean } @a;
    my @negatives = grep { $_ < $mean } @a;
    if ( sum( map { $_ - $mean } @positives ) > sum( map { $mean - $_ } @negatives ) ) {
        return sum( map { $_ - $mean + 1 } @positives );
    }
    else {
        return sum( map { $mean - $_ } @negatives );
    }
    #    return max( $positives, -$negatives );
}

__END__


#$_ -= $mean
#    for @a;

my @negatives = grep { $_ < $mean } @a;
my @positives = grep { $_ > $mean } @a;

my $p_sum = sum( @positives );
my $n_sum = sum( @negatives );

if ( sum( map { $_ - $mean } @positives ) > abs( sum( map { $_ - $mean } @negatives ) ) ) {
    say min( sum( map { $_ - $mean + 1 } @positives ), sum( map { $mean - $_ } @negatives ) );
}
else {
    say min( sum( map { $_ - $mean } @positives ), sum( map { $mean - 1 - $_ } @negatives ) );
}

exit;
