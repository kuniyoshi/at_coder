#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my @cells = map { chomp; [ split m{\s} ] }
            map { scalar <> }
            1 .. 3;

exit;
