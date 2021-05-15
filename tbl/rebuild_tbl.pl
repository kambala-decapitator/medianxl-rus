#!/usr/bin/env perl

use warnings;
use strict;
use File::Path qw/make_path/;

die 'tbl path(s) not specified' if @ARGV == 0;
my ($enTblDir, $ruTblDir) = @ARGV == 1 ? ("$ARGV[0]/en", "$ARGV[0]/ru") : @ARGV;

my @tbls = qw/string expansionstring patchstring/;
my $tblLineRegex = qr/^(.+?)\t(.+)$/;
my ($x_key, $X_key) = (qq/"x"/, qq/"X"/);

sub xKeyCounter {
	my ($keyToModifyRef, $counterRef, $keyToCheck, $xKey) = @_;
	$$keyToModifyRef .= $$counterRef++ if $keyToCheck eq $xKey
}


# ru tbls -> hash
my %ruStrings;
my ($x_counter, $X_counter);
for my $tbl (@tbls) {
	$x_counter = 0;
	$X_counter = 0;

	open my $tblHandle, "<", "$ruTblDir/$tbl.txt";
	for (<$tblHandle>) {
		next unless /$tblLineRegex/;

		my ($key, $str) = ($1, $2);
		xKeyCounter(\$key, \$x_counter, $key, $x_key);
		xKeyCounter(\$key, \$X_counter, $key, $X_key);
		$ruStrings{$key} = $str
	}
	close $tblHandle
}

my $ruOutDir = $ARGV[2] // "$ruTblDir/../ru_new";
make_path $ruOutDir;

# rebuild ru tbls line by line based on en tbls
for my $tbl (@tbls) {
	$x_counter = 0;
	$X_counter = 0;

	open my $tblHandle, "<", "$enTblDir/$tbl.txt";
	open my $ruOutTblHandle, ">", "$ruOutDir/$tbl.txt";
	for (<$tblHandle>) {
		next unless /$tblLineRegex/;

		my ($key, $str, $ruKey) = ($1, $2, $1);
		xKeyCounter(\$ruKey, \$x_counter, $key, $x_key);
		xKeyCounter(\$ruKey, \$X_counter, $key, $X_key);
		print $ruOutTblHandle $key, "\t", $ruStrings{$ruKey} // $str, "\n"
	}
	close $tblHandle
}
