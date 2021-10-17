#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @doukasens = map { chomp( my $line = <> ); [ split m{\s}, $line ] }
                1 .. $n;

for my $doukasen_ref ( @doukasens ) {
    my( $length, $speed ) = @{ $doukasen_ref };
    my $duration = $length / $speed;
    push @{ $doukasen_ref }, $duration;
}

my $total_duration = sum( map { $_->[2] } @doukasens );
my $half_duration = $total_duration / 2;

my $total_length = 0;
my $elapsed = 0;

for my $doukasen_ref ( @doukasens ) {
    my( $length, $speed, $duration ) = @{ $doukasen_ref };

    if ( $elapsed + $duration < $half_duration ) {
        $elapsed += $duration;
        $total_length += $length;
        next;
    }

    my $remain = $half_duration - $elapsed;
    $total_length += $remain * $speed;

    last;
}

say $total_length;

exit;

sub sum {
    my $result = 0;
    $result += $_
        for @_;

    return $result;
}
