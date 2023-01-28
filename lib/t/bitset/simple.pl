#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use Bitset;
use Readonly;

Readonly my $SIZE => 7;

my $a = Bitset->new( $SIZE )->one;
say $a->dump;
$a->shift_left( 2 );
say $a->dump;

__END__
my $a = Bitset->new( $SIZE )->one;
$a->shift_left( 3 );
say q{[}, $a->dump, q{]};

my $b = Bitset->new( $SIZE )->one;
$b->shift_left( 2 );
say q{[}, $b->dump, q{]};

my $c = Bitset->new( $SIZE );
$c->or( $a );
say q{[}, $c->dump, q{]};
$c->or( $b );
say q{[}, $c->dump, q{]};

exit;
