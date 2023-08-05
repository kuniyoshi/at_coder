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

say t( $mean );
#say min( t( $mean ), t( $mean + 1 ) );

exit;

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
