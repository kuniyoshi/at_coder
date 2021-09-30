#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use Path::Class qw( file );

for my $index ( 1 .. 100 ) {
    my $n = int( 10 * rand ) + 1;
    my @a = map { int 10 * rand } 1 .. $n;
    my $file = file( "t/data.d/$index" );
    my $FH = $file->openw;
    say { $FH } $n;
    say { $FH } join q{ }, @a;
}

exit;

