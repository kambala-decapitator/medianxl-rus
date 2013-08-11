#!/usr/bin/perl

use warnings;
use strict;

use HTML::FormatText;


my %failsHash = (
	eng => qr/[a-zA-Z]+/,
	rus => qr/[\d)]-[а-яА-Я]/,
);
for my $filename (@ARGV)
{
	my $string = HTML::FormatText->format_file($filename, leftmargin => 0, rightmargin => 50);
	print "\n-----$filename-----\n";
	for (split /\n/, $string)
	{
		for my $failedLang (keys %failsHash)
		{
			print "$failedLang: $_\n" if $_ =~ /$failsHash{$failedLang}/ and $_ ne '[IMAGE]'
		}
	}
}
