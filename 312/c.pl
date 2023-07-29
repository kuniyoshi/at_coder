#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = sort { $a <=> $b } do { chomp( my $l = <> ); split m{\s}, $l };
my @b = sort { $a <=> $b } do { chomp( my $l = <> ); split m{\s}, $l };

my $price = 1;
my $ai = 0;
my $bi = 0;

while ( 1 ) {
    my $ca = bin( $price, \@a );
    my $cb = @b - bin( $price, \@b );
    if ( $ca >= $cb ) {
        say $price;
        exit;
    }
    if ( $a[ $ai ] > $b[ $bi ] && $bi <= $#b ) {
        $price = $b[ $bi ];
        $bi++;
    }
    elsif ( $ai <= $#a ) {
        $price = $a[ $ai ];
        $ai++;
    }
    else {
        say $price + 1;
        exit;
    }
}

exit;

sub bina {
    my $price = shift;
    my $ref = shift;

    my 
}


__END__

for my $a ( @a ) {
    my $count = bina( $a );
    if ( bin( $a, $count ) ) {
        say $a;
        exit;
    }
}

say $b[-1]+1;

exit;

sub bina {
    my $price = shift;

    return 0
        if $price < $a[0];

    return scalar @a
        if $price > $a[-1];

    my $ac = 0;
    my $wa = $#a;

    while ( $wa - $ac > 1 ) {
        my $wj = int( ( $ac + $wa ) / 2 );
        if ( $a[ $wj ] <= $price ) {
            $ac = $wj;
        }
        else {
            $wa = $wj;
        }
    }

    return $ac + 1;
}


sub bin {
    my $a = shift;
    my $count = shift;

    return $count >= @b
        if $a < $b[0];

    return $count == 0
        if $a > $b[-1];

    my $ac = 0;
    my $wa = $#b;

    while ( $wa - $ac > 1 ) {
        my $wj = int( ( $ac + $wa ) / 2 );
        if ( $b[ $wj ] < $a ) {
            $ac = $wj;
        }
        else {
            $wa = $wj;
        }
    }

    return $count >= $wa + 1;
}

__END__

my $ac = 1;
my $wa = 1e9;

while ( $wa - $ac > 1 ) {
    my $wj = int( ( $ac + $wa ) / 2 );
    if ( bin_ans( $wj ) ) {
        $ac = $wj;
    }
    else {
        $wa = $wj;
    }
}

say $ac;


exit;


__END__

while ( $wa - $ac > 1 ) {
    my $wj = int( ( $ac + $wa ) / 2 );
    my $count = bina( $wj );
    warn "($wj, $count)";
    if ( bin( $wj, $count ) ) {
        warn "ac";
        $ac = $wj;
    }
    else {
        warn "wa";
        $wa = $wj;
    }
}

say $ac;

exit;

sub bina {
    my $price = shift;

    return 0
        if $price < $a[0];

    return scalar @a
        if $price > $a[-1];

    my $ac = 0;
    my $wa = $#a;

    while ( $wa - $ac > 1 ) {
        my $wj = int( ( $ac + $wa ) / 2 );
        if ( $a[ $wj ] <= $price ) {
            $ac = $wj;
        }
        else {
            $wa = $wj;
        }
    }

    return $ac + 1;
}


sub bin {
    my $a = shift;
    my $count = shift;

    return $count >= @b
        if $a < $b[0];

    return
        if $a > $b[-1];

    my $ac = $#b;
    my $wa = 0;

    while ( $ac - $wa > 1 ) {
        my $wj = int( ( $ac + $wa ) / 2 );
        if ( $b[ $wj ] <= $a ) {
            $ac = $wj;
        }
        else {
            $wa = $wj;
        }
    }

    return $count >= $ac + 1;
}
