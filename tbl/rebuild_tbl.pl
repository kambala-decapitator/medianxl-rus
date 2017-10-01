#!/usr/bin/env perl

use warnings;
use strict;
use File::Path qw/make_path/;

my $tblDir = $ARGV[0] or die 'tbl path not specified';
my @tbls = qw/string expansionstring patchstring/;

# ru tbls -> hash
my %ruStrings;
for my $tbl (@tbls) {
    open my $tblHandle, "<", "$tblDir/ru/$tbl.txt";
    for (<$tblHandle>) {
        $ruStrings{$1} = $2 if (/^(.+?)\t(.+)$/)
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
        next unless (/^(.+?)\t(.+)$/);
        my ($key, $str) = ($1, $2);
        print $ruOutTblHandle $1, "\t", $ruStrings{$1} // $2, "\n";
    }
    close $tblHandle
}
