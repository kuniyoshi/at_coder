#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use Test::More tests => 1;
use IPC::Open2;

chomp( my @lines = <> );

my $input1 = shift @lines;
my $input2 = shift @lines;
shift @lines;
my @outputs = @lines;

my $pid = open2( my $OUT, my $IN, q{../d.pl} )
    or die $!;

say { $IN } $input1;
say { $IN } $input2;

waitpid $pid, 0;

chomp( my @result = <$OUT> );

#diag(join q{, }, @result);
#is_deeply( \@result, \@outputs );
is( join( q{, }, @result ), join( q{, }, @outputs ) );

exit;
