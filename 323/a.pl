#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $s = <> );

my( @nums ) = $s =~ m{(..)}g;

say YesNo::get( 8 == grep { $_ =~ m{.0} } @nums );


exit;
use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
