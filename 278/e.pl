#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min max );

my( $height, $width, $n, $h, $w ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = map { chomp; [ split m{\s} ] }
        map { scalar <> }
        1 .. $height;

my %count;

for my $ref ( @a ) {
    for my $a ( @{ $ref } ) {
        $count{ $a }++;
    }
}

my $type_count = scalar %count;

my @areas;
my %index;

for my $i ( 1 .. $height ) {
    for my $j ( 1 .. $width ) {
        my $v = $a[ $i - 1 ][ $j - 1 ];

        unless ( defined $index{ $v } ) {
            $index{ $v } = @areas;
            push @areas, [ ];
        }

        my $index = $index{ $v };

        $areas[ $index ][0] = min( $areas[ $index ][0] // $i, $i );
        $areas[ $index ][1] = max( $areas[ $index ][1] // $i, $i );
        $areas[ $index ][2] = min( $areas[ $index ][2] // $j, $j );
        $areas[ $index ][3] = max( $areas[ $index ][3] // $j, $j );
    }
}

@areas = sort { $a->[0] <=> $b->[0] }
         sort { $a->[2] <=> $b->[2] }
         @areas;

for my $k ( 0 .. $height - $h ) {
    my @results;

    for my $l ( 0 .. $width - $w ) {
        my $disappears = 0;

        for my $i ( 0 .. $#areas ) {
            my $ref = $areas[ $i ];

            my( $min_i, $max_i, $min_j, $max_j ) = @{ $ref };

            my @k = ( $k + 1, $k + $h );
            my @l = ( $l + 1, $l + $w );

            last
                if $k[0] < $min_i;

            last
                if $l[0] < $min_j;


            if ( $k[0] <= $min_i && $k[1] >= $max_i && $l[0] <= $min_j && $l[1] >= $max_j ) {
                #                warn "($k, $l), $i, ($k[0], $k[1]), ($l[0], $l[1])";
                $disappears++;
            }
        }

        push @results, $type_count - $disappears;
    }

    say join q{ }, @results;
}

exit;
__END__
my %count;

for my $ref ( @a ) {
    for my $a ( @{ $ref } ) {
        $count{ $a }++;
    }
}

for my $k ( 0 .. $height - $h ) {
    my @results;
    for my $l ( 0 .. $width - $w ) {
        for my $i ( $k + 1 .. $k + $h ) {
            for my $j ( $l + 1 .. $l + $w ) {
                my $value = $a[ $i - 1 ][ $j - 1 ];
                $count{ $value }--;
                delete $count{ $value }
                    if $count{ $value } <= 0;
            }
        }

        push @results, scalar %count;

        for my $i ( $k + 1 .. $k + $h ) {
            for my $j ( $l + 1 .. $l + $w ) {
                my $value = $a[ $i - 1 ][ $j - 1 ];
                $count{ $value }++;
            }
        }
    }

    say join q{ }, @results;
}

exit;
