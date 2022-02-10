#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $t = <> );
my @q = map { chomp; [ split m{\s} ] }
        map { scalar <> }
        1 .. $t;

my %can;
#    a  s  i  x  y
$can{0}{0}{0}{0}{0}++;
$can{0}{0}{1}{0}{1}++;
$can{0}{0}{1}{1}{0}++;
$can{0}{1}{0}{0}{1}++;
$can{0}{1}{0}{1}{0}++;
$can{0}{1}{1}{0}{0}++;
$can{1}{0}{0}{1}{1}++;
$can{1}{1}{1}{1}{1}++;

for my $q_ref ( @q ) {
    my( $a, $s ) = @{ $q_ref };
    my $has = test( $a, $s, 0 );
    say $has ? "Yes" : "No";
}

exit;

sub test {
    my( $and, $sum, $increment ) = @_;
    #    warn sprintf "(%b, %b, %b)", $and, $sum, $increment;
    return $can{ $and }{ $sum }{ $increment }{0}{0}
        if $and == 0 && $sum == 0;
    my $a = $and & 1;
    my $s = $sum & 1;
    my $canbe;
    for my $x ( 0 .. 1 ) {
        for my $y ( 0 .. 1 ) {
            #            if ( $a == 1 && $s == 0 && $increment == 0 && $x == 1 && $y == 1 ) {
            #                warn "### $a $s $increment $x $y : $can{ $a }{ $s }{ $increment }{ $x }{ $y }";
            #            }
            #            warn sprintf "%b, %b, %b: [%b %b %b] [%b, %b] -> %d", $and, $sum, $increment, $a, $s, $increment, $x, $y, $can{ $a }{ $s }{ $increment }{ $x }{ $y } // 0;
            next
                unless $can{ $a }{ $s }{ $increment }{ $x }{ $y };
            next
                unless test( $and >> 1, $sum >> 1, ( ( $increment + $x + $y ) & 2 ) ? 1 : 0 );
            $canbe++;
        }
    }
    return $canbe;
}
