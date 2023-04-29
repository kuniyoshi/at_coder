#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $h, $w ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = map { chomp; [ split m{} ] }
        map { scalar <> }
        1 .. $h;
my @b = map { chomp; [ split m{} ] }
        map { scalar <> }
        1 .. $h;

my $a = join q{}, map { join q{}, @{ $_ } } @a;

my @cols = 0 .. $w - 1;
my @rows = 0 .. $h - 1;

for my $i ( 0 .. $h - 1 ) {
    for my $j ( 0 .. $w - 1 ) {
        my $b = join q{}, map { join q{}, @{ $b[ $_ ] }[ @cols ] } @rows;

        if ( $b eq $a ) {
            say YesNo::get( 1 );
            exit;
        }

        push @cols, shift @cols;
    }

    push @rows, shift @rows;
}

say YesNo::get( 0 );

exit;
use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
