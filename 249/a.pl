#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $a, $b, $c, $d, $e, $f, $x ) = do { chomp( my $l = <> ); split m{\s}, $l };

my %takahashi = ( will_walking => 1, elapsed => 0 );
my %aoki = ( will_walking => 1, elapsed => 0 );

for my $i ( 1 .. $x ) {
    if ( $takahashi{will_walking} ) {
        $takahashi{walked} += $b;
        $takahashi{elapsed}++;
        $takahashi{will_walking} = $takahashi{elapsed} < $a;
        $takahashi{elapsed} = 0
            unless $takahashi{will_walking};
    }
    else {
        $takahashi{elapsed}++;
        $takahashi{will_walking} = $takahashi{elapsed} >= $c;
        $takahashi{elapsed} = 0
            if $takahashi{will_walking};
    }

    if ( $aoki{will_walking} ) {
        $aoki{walked} += $e;
        $aoki{elapsed}++;
        $aoki{will_walking} = $aoki{elapsed} < $d;
        $aoki{elapsed} = 0
            unless $aoki{will_walking};
    }
    else {
        $aoki{elapsed}++;
        $aoki{will_walking} = $aoki{elapsed} >= $f;
        $aoki{elapsed} = 0
            if $aoki{will_walking};
    }
}

say $takahashi{walked} > $aoki{walked} ? "Takahashi" : $aoki{walked} > $takahashi{walked} ? "Aoki" : "Draw";

exit;
