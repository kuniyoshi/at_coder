#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $q ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @events = map { chomp; [ split m{\s} ] }
             map { scalar <> }
             1 .. $q;

my %count;

for my $ref ( @events ) {
    my( $op, $who ) = @{ $ref };

    if ( $op == 1 ) {
        $count{ $who }++;
    }
    elsif ( $op == 2 ) {
        $count{ $who } += 2;
    }
    else {
        say YesNo::get( ( $count{ $who } // 0 ) >= 2 );
    }
}



exit;
use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
