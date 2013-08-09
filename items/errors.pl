#!/usr/bin/perl

use warnings;
use strict;

use HTML::FormatText;


sub print_errors
{
	(my $line, my $reCond, my $msg) = @_;
	print "$msg: $line\n" if $line =~ /$reCond/ and $line ne '[IMAGE]';
}


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
			&print_errors($_, $failsHash{$failedLang}, $failedLang);
		}
	}
}
