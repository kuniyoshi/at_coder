#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @w = do { chomp( my $l = <> ); split m{\s}, $l };
my %keyword = map { $_ => 1 } qw( and not that the you );

say YesNo::get( scalar grep { $keyword{ $_ } } @w );


exit;
use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
