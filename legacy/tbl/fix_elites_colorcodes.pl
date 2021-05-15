#!/usr/bin/perl -w

use strict;

my %elites;
open my $fh, '<', 'elites.txt' or die "couldn't open elites.txt for reading!";
while (<$fh>)
{
	chomp;
	$elites{$_} = 1;
}
close $fh;

$^I = '~';
while (<>)
{
	/^\"([^\"]+)\"\t\"([^\"]*)\"$/;
	(my $key, my $str) = ($1, $2);
	substr($_, -1) = '\blue;"'."\n" if exists($elites{$key}) and $str !~ /\\[a-z]+;$/;
	print;
}
