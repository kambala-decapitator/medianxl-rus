medianxl-rus
============

A collection of scripts and files for Diablo II: Median XL Russian translation.

## Setting up .tbl diff tool
First, make sure that you have Perl 5 installed. Then, open `.git/config` file and add the following:

	[diff "tbl"]
		textconv = tbl/dump_tbl.pl
		cachetextconv = true
		binary = true
