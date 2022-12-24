#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $s = <> );
my @chars = split m{}, $s;

my @counts = ( { } );
my %whole;

for my $c ( @chars ) {
    if ( $c eq q{(} ) {
    }
    elsif ( $c eq q{)} ) {
        delete $whole{ $_ }
            for keys %{ pop @counts };
        push @counts, { }
            unless @counts;
    }
    else {
        if ( $whole{ $c } ) {
            say YesNo::get( 0 );
            exit;
        }

        $whole{ $c }++;
        $counts[-1]{ $c }++;
    }
}

say YesNo::get( 1 );

exit;

use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
