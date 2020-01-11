#!/usr/bin/env perl -w

use strict;
use List::Util qw(pairs);

open(my $tbl, "< :raw :bytes", $ARGV[0]) || die "can't open input file";

# find strings' start offset
seek $tbl, 9, 0;
my $stringsOffsetBytes;
read $tbl, $stringsOffsetBytes, 4;
seek $tbl, unpack("L", $stringsOffsetBytes), 0;

local $/ = "\0"; # "line" separator
my @strings;
my $longestKeyLength = 0;
while (my $stringKey = <$tbl>) {
    my $stringValue = <$tbl>;
    $stringValue =~ s/\n/\\n/g;
    chop ($stringKey, $stringValue);
    push @strings, $stringKey, $stringValue;

    my $keyLength = length $stringKey;
    $longestKeyLength = $keyLength if $longestKeyLength < $keyLength
}
close $tbl;

for (pairs @strings) {
    my ($stringKey, $stringValue) = @$_;
    printf "%-*s %s\n", $longestKeyLength, $stringKey, $stringValue
}
