#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use Test::More;
use Path::Class qw( file );
use IPC::Open2;
use File::HomeDir;

my @filenames = glob "data.d/*";
my $home = File::HomeDir->my_home;

plan tests => scalar @filenames;

for my $filename ( @filenames ) {
    open2( my $OUT, my $IN, "./run.o2n.sh" )
        or die $!;

    print { $IN } file( $filename )->slurp;
    chomp( my @results = <$OUT> );

    open2( my $OUT2, my $IN2, "../d.pl" )
        or die $!;
    print{ $IN2 } file( $filename )->slurp;
    chomp( my @results2 = <$OUT2> );

    is_deeply( \@results2, \@results );
}

exit;

