#!/usr/bin/env perl

use warnings;
use strict;
use File::Path qw/make_path/;

die 'tbl path(s) not specified' if @ARGV == 0;
my ($enTblDir, $ruTblDir) = @ARGV == 1 ? ("$ARGV[0]/en", "$ARGV[0]/ru") : @ARGV;

my @tbls = qw/string expansionstring patchstring/;
my $tblLineRegex = qr/^(.+?)\t(.+)$/;

# ru tbls -> hash
my %ruStrings;
for my $tbl (@tbls) {
    open my $tblHandle, "<", "$ruTblDir/$tbl.txt";
    for (<$tblHandle>) {
        $ruStrings{$1} = $2 if /$tblLineRegex/
    }
    close $tblHandle
}

my $ruOutDir = $ARGV[2] // "$ruTblDir/../ru_new";
make_path $ruOutDir;

# rebuild ru tbls line by line based on en tbls
for my $tbl (@tbls) {
    open my $tblHandle, "<", "$enTblDir/$tbl.txt";
    open my $ruOutTblHandle, ">", "$ruOutDir/$tbl.txt";
    for (<$tblHandle>) {
        next unless /$tblLineRegex/;
        my ($key, $str) = ($1, $2);
        print $ruOutTblHandle $key, "\t", $ruStrings{$key} // $str, "\n";
    }
    close $tblHandle
}
