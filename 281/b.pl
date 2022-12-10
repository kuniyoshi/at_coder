#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $s = <> );

my $satisfy = $s =~ m{\A [A-Z] [1-9][0-9]{5} [A-Z] \z}msx;

say YesNo::get( $satisfy );

exit;

use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
