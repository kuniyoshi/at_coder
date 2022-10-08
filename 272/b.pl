#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @dances = map { chomp; [ split m{\s} ] }
             map { scalar <> }
             1 .. $m;

my %did;

for my $ref ( @dances ) {
    my @members = @{ $ref };
    shift @members;
    for my $i ( 0 .. $#members ) {
        for my $j ( 0 .. $i - 1 ) {
            my $a = $members[ $i ];
            my $b = $members[ $j ];
            $did{ $a }{ $b }++;
            $did{ $b }{ $a }++;
        }
    }
}

say YesNo::get( t( $n, %did ) );

exit;

sub t {
    my $n = shift;
    my %did = @_;

    for my $i ( 1 .. $n ) {
        for my $j ( 1 .. $i ) {
            next
                if $i == $j;
            die "not same: ($i, $j), $did{ $i }{ $j } == $did{ $j }{ $i }"
                if ( ( $did{ $i }{ $j } // 0 ) != ( $did{ $j }{ $i } // 0 ) );
            return
                if !$did{ $i }{ $j };
        }
    }

    return 1;
}

use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
