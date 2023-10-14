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

sub test4 {
    my $s = shift;
    my $length = length( $s );
    my $errors = 0;

    for ( my $i = 0; $i < $length; ++$i ) {
        next
            if substr( $s, $i, 1 ) eq substr( $t, $i - $errors, 1 );
        return
            if ++$errors > 1;
    }

    return 1;
}

sub test3 {
    my $s = shift;
    my $length = length( $t );
    my $errors = 0;

    for ( my $i = 0; $i < $length; ++$i ) {
        next
            if substr( $s, $i - $errors, 1 ) eq substr( $t, $i, 1 );
        return
            if ++$errors > 1;
    }

    return 1;
}

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

sub test {
    my $s = shift;
    if ( length( $s ) == length( $t ) ) {
        return test2( $s );
    }
    elsif ( length( $s ) == length( $t ) - 1 ) {
        return test3( $s );
    }
    elsif ( length( $s ) == length( $t ) + 1 ) {
        return test4( $s );
    }
    else {
        return;
    }
}

