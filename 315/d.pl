#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( sum );

my( $h, $w ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @c = map { chomp; [ split m{} ] }
        map { scalar <> }
        1 .. $h;

my @rows;
my @cols;

for ( my $i = 0; $i < $h; ++$i ) {
    $rows[ $i ]{ $_ }++
        for @{ $c[ $i ] };
}

for ( my $i = 0; $i < $w; ++$i ) {
    $cols[ $i ]{ $_ }++
        for map { $c[ $_ ][ $i ] } 0 .. $h - 1;
}

while ( 1 ) {
    my %deletes;

    for my $ref ( @rows ) {
        next
            if %{ $ref } != 1;
        my( $key ) = keys %{ $ref };
        next
            if $ref->{ $key } == 1;
        push @{ $deletes{row} }, $ref;
    }

    for my $ref ( @cols ) {
        next
            if %{ $ref } != 1;
        my( $key ) = keys %{ $ref };
        next
            if $ref->{ $key } == 1;
        push @{ $deletes{col} }, $ref;
    }

    last
        if !$deletes{row} && !$deletes{col};

    for my $ref ( @{ $deletes{row} } ) {
        my( $key ) = keys %{ $ref };
        delete $ref->{ $key };

        for my $col ( @cols ) {
            next
                unless $col->{ $key };
            $col->{ $key }--;
            delete $col->{ $key }
                unless $col->{ $key };
        }
    }

    for my $ref ( @{ $deletes{col} } ) {
        next
            unless %{ $ref };
        my( $key ) = keys %{ $ref };
        delete $ref->{ $key };

        for my $row ( @rows ) {
            next
                unless $row->{ $key };
            $row->{ $key }--;
            delete $row->{ $key }
                unless $row->{ $key };
        }
    }
}

say sum( map { values %{ $_ } } ( @rows ) ) // 0;

exit;

__END__
my %neighbor;

for ( my $i = 0; $i < $h; ++$i ) {
    for ( my $j = 0; $j < $w; ++$j ) {
        $neighbor{ $i }{ $j } = {
            down => $i + 1 < $h ? [ $i + 1, $j ] : undef,
            left => $j - 1 >= 0 ? [ $i, $j - 1 ] : undef,
            up => $i - 1 >= 0 ? [ $i - 1, $j ] : undef,
            right => $j + 1 < $w ? [ $i, $j + 1 ] : undef,
        };
    }
}

for ( my $i = 0; $i < $h; ++$i ) {
    for ( my $j = 0; $j < $w; ++$j ) {
        erase_horizontal( $i, $j );
    }
}

say scalar grep { defined } map { @{ $_ } } @c;

exit;

sub erase_horizontal {
    my( $i, $j ) = @_;
    my %horizontal;
    my $cursor = [ $i, $j ];
    while ( $neighbor{ $cursor[0] }{ $cursor[1] }{left} ) {
        $cursor = $neighbor{ $cursor[0] }{ $cursor[1] }{left};
    }
    my @cells;
    while ( $neighbor{ $cursor[0] }{ $cursor[1] }{right} ) {
        push @cells, $cursor;
        $cursor = $neighbor{ $cursor[0] }{ $cursor[1] }{right};
        $horizontal{ $c[ $cursor[0] ][ $cursor[1] ] }++;
    }
    return
        if @cells != 1;
    for my $ref ( @cells ) {

    }
}

__END__
my @rows;
my @cols;

for ( my $i = 0; $i < $h; ++$i ) {
    $rows[ $i ]{ $_ }++
        for @{ $c[ $i ] };
}

for ( my $i = 0; $i < $w; ++$i ) {
    $cols[ $i ]{ $_ }++
        for map { $c[ $_ ][ $i ] } 0 .. $h - 1;
}

while ( 1 ) {
    for my $
}

my $sum = 0;

for my $ref ( @rows, @cols ) {
    $sum += sum( values %{ $ref } );
}

say $sum;

exit;
