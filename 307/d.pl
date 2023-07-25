#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
chomp( my $s = <> );
my @s = split m{}, $s;

my @stacks = ( [ ] );

for my $char ( @s ) {
    if ( $char eq q{(} ) {
        push @stacks, [ $char ];
        next;
    }

    if ( $char eq q{)} ) {
        if ( @stacks && $stacks[-1][0] eq q{(} ) {
            pop @stacks;
        }
        else {
            push @{ $stacks[-1] }, $char;
        }
        next;
    }

    push @{ $stacks[-1] }, $char;
}

while ( @stacks ) {
    my $ref = shift @stacks;
    print join q{}, @{ $ref };
}

print "\n";

exit;
