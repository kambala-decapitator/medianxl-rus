medianxl-rus
============

A collection of scripts and files for Diablo II: Median XL Russian translation.

## Setting up YAML function context

This will let you see entry number (like line number in .txt file) in the hunk context when viewing git diff. Open `.git/config` file and add the following:

```
[diff "yaml"]
	xfuncname = "^- # [0-9]+$"
```

## Setting up .tbl diff tool
First, make sure that you have Perl 5 installed. Then, open `.git/config` file and add the following:

	[diff "tbl"]
		textconv = tbl/dump_tbl.pl
		cachetextconv = true
		binary = true
