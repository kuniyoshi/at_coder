#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $t ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @s = map { chomp; $_ }
        map { scalar <> }
        1 .. $n;

my @candidates;

for ( my $i = 0; $i < $n; ++$i ) {
    push @candidates, $i + 1
        if test( $s[ $i ] );
}

say scalar @candidates;
say join q{ }, @candidates;

exit;

sub test2 {
    my $s = shift;
    my $length = length( $s );
    my $errors = 0;

    for ( my $i = 0; $i < $length; ++$i ) {
        next
            if substr( $s, $i, 1 ) eq substr( $t, $i, 1 );
        return
            if ++$errors > 1;
    }

    return 1;
}

sub is_substring {
    my $substring = shift;
    my $string = shift;

    my $cursor = 0;

    for ( my $i = 0; $i < length $string; ++$i ) {
        if ( substr( $substring, $cursor, 1 ) eq substr( $string, $i, 1 ) ) {
            return 1
                if ++$cursor == length $substring;
        }
    }

    return;
}

sub test {
    my $s = shift;
    if ( length( $s ) == length( $t ) ) {
        return test2( $s );
    }
    elsif ( length( $s ) == length( $t ) - 1 ) {
        return is_substring( $s, $t );
    }
    elsif ( length( $s ) == length( $t ) + 1 ) {
        return is_substring( $t, $s );
    }
    else {
        return;
    }
}

