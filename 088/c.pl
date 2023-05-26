#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my @c = map { chomp; [ split m{\s} ] }
        map { scalar <> }
        1 .. 3;


exit;

__END__
2

a1 + b1     a1 + b2     a1 + b3 = 3 a1 + b1 + b2 + b3
a2 + b1     a2 + b2     a2 + b3 = 3 a2 + b1 + b2 + b3
a3 + b1     a3 + b2     a3 + b3 = 3 a3 + b1 + b2 + b3
3 b1 + a{1,2,3}
            3 b2 + a{1,2,3}
                        3 b3 + a{1,2,3}
