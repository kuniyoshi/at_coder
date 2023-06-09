package FenwickTree;
use utf8;
use strict;
use warnings;

sub new {
    my $class = shift;
    my $n = shift;
    return bless {
        n => $n,
        data => [ ( 0 ) x $n ],
    }, $class;
}

sub add {
    my( $self, $p, $x ) = @_;
    $p++;
    while ( $p <= $self->{n} ) {
        $self->{data}[ $p - 1 ] += $x;
        $p += $p & -$p; # 最下位ビットを加える
    }
}

sub sum {
    my( $self, $p ) = @_;
    my $ret = 0;
    while ( $p > 0 ) {
        $ret += $self->{data}[ $p - 1 ];
        $p -= $p & -$p; # 最下位ビットを引く
    }
    return $ret;
}

1;
