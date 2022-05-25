#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

my %count;
my $duplicated = 0;

for my $a ( @a ) {
    $duplicated++
        if $count{ $a }++;
}

warn "\$duplicated: $duplicated";
warn Dumper \%count;

my $total = 0;

for my $i ( 0 .. $#a - 2 ) {
    warn "### \$i: $i";
    die "invalid count of $a[ $i ]"
        unless $count{ $a[ $i ] };

    my $combination_count = combination2( scalar( @a ) - ( $i + 1 ) - ( $count{ $a[ $i ] } - 1 ) );
    warn "--- \$combination_count: $combination_count";
    warn "--- before \$total: $total";
    my $delta = $combination_count - ( $duplicated - ( $count{ $a[ $i ] } - 1 ) );
    warn "--- \$delta: $delta";

    if ( $delta > 0 ) {
        $total += $delta;
        warn "--- after \$total: $total";
    }

    if ( $count{ $a[ $i ] } > 1 ) {
        $duplicated--;
        $count{ $a[ $i ] }--;
        warn "--- after \$duplicated: $duplicated";
    }
}

say $total;

exit;

sub combination2 {
    my $n = shift;
    return 0
        if $n <= 0;

    return $n * ( $n - 1 ) / 2;
}
