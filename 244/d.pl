#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my @s = do { chomp( my $l = <> ); split m{\s}, $l };
my @t = do { chomp( my $l = <> ); split m{\s}, $l };

for my $i ( 1 .. 2 ) {
    my $fail;

    for my $j ( 0 .. 2 ) {
        next
            if $s[ $j ] eq $t[ $j ];
        $fail = $j;
        last;
    }

    if ( defined $fail ) {
        my $required;

        for my $j ( 0 .. 2 ) {
            next
                if $s[ $j ] ne $t[ $fail ];
            $required = $j;
        }

        die "could not faind required"
            unless defined $required;

        @s[ $fail, $required ] = @s[ $required, $fail ];
    }
    else {
        @s[ 0, 1 ] = @s[ 1, 0 ];
    }
}

for my $i ( 0 .. 2 ) {
    if ( $s[ $i ] ne $t[ $i ] ) {
        say "No";
        exit;
    }
}

say "Yes";

exit;
