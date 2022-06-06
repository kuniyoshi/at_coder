#!/usr/bin/env perl -s
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use Path::Class qw( file );

our $start;
our $end;
our $debug;

die usage( )
    if !$start || !$end;

my %summary;

for my $contest ( $start .. $end ) {
    warn "\$contest: $contest"
        if $debug;

    my $file = file( "$contest/README.md" );

    if ( !-e $file ) {
        warn "No $file found, skip this";
        next;
    }

    $summary{joined}++;

    my @acs = parse( $file->slurp( chomp => 1, iomode => "<:encoding(UTF-8)" ) );
    warn "\@acs: ", join q{, }, @acs
        if $debug;

    warn "D found at $contest"
        if grep { $_ eq q{D} } @acs;

    $summary{ $_ }++
        for @acs;
}

warn Data::Dumper->new( [ \%summary ] )->Sortkeys( 1 )->Terse( 1 )->Dump;

exit;

sub parse {
    my @lines = @_;
    my @target_lines;

    for my $line ( @lines ) {
        if ( $line =~ m{\A [#] \s A \b }msx ) {
            last;
        }

        push @target_lines, $line;
    }

    my @problems = "A" .. "E";
    my @acs;

    for my $problem ( @problems ) {
        my( $result ) = grep { defined }
                        map { m{\A [|] \s* \Q$problem\E \s* [|] \s* ([-\w]+) \s* [|] }msx ? $1 : undef }
                        @target_lines;
        die "No result of $problem found, it is [$result]: ", Dumper \@target_lines
            if !$result || !grep { $_ eq $result } qw( AC WA TLE - );
        warn "--- $problem: $result"
            if $debug;
        push @acs, $problem
            if $result eq "AC";
    }

    return @acs;
}

sub usage {
    return <<END_USAGE;
usage: $0 [-debug] -start=<start> -end=<end>
END_USAGE
}
