#!/usr/bin/env perl

use warnings;
use strict;
use File::Path qw/make_path/;

my $tblDir = $ARGV[0] or die 'tbl path not specified';
my @tbls = qw/string expansionstring patchstring/;
my $tblLineRegex = qr/^(.+?)\t(.+)$/;

# ru tbls -> hash
my %ruStrings;
for my $tbl (@tbls) {
    open my $tblHandle, "<", "$tblDir/ru/$tbl.txt";
    for (<$tblHandle>) {
        $ruStrings{$1} = $2 if /$tblLineRegex/
    }
    close $tblHandle
}

my $ruOutDir = "$tblDir/ru_new";
make_path $ruOutDir;

# rebuild ru tbls line by line based on en tbls
for my $tbl (@tbls) {
    open my $tblHandle, "<", "$tblDir/en/$tbl.txt";
    open my $ruOutTblHandle, ">", "$ruOutDir/$tbl.txt";
    for (<$tblHandle>) {
        next unless /$tblLineRegex/;
        my ($key, $str) = ($1, $2);
        print $ruOutTblHandle $key, "\t", $ruStrings{$key} // $str, "\n";
    }
    close $tblHandle
}
