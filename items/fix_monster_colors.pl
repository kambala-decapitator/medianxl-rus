#!/usr/bin/perl

use warnings;
use strict;

sub recolor
{
	(my $lineRef, my $color, my $arrayRef) = @_;
	$$lineRef =~ s/$monster(?!<\/font>)/<font color="$color">$&<\/font>/g for my $monster (@$arrayRef);
}

my @green = ("Wracked Soul", "Bloodbrother", "Ratfink", "Armored Titan", "Venom Fiend", "Moon Panther");
my @yellow = ("Black Death", "Deathfire Bearer", "Dirge", "(?<=: )Avalanche", "Trap Rat(?! )", "Black Ice Demon", "Living Flame", "Fireblood", "Iced Soul", "Onyx Knight", "Cenobite", "Tree of Life", "Cog", "Daystar", "Serafiend", "Lament(?!s)", "Corruptor Archer", "Edyrem", "Ulfhedinn", "(?<= )Black Cat");
my @gold = ("Slain Soul", "Andariel", "Dark Star Dragon", "Imperius(?!')", "Death Projector");

my %colorHash = (
	"#20b020" => \@green,
	"#ffff20" => \@yellow,
	"#ff9900" => \@gold,
);

$^I = "~";
while (<>)
{
	&recolor(\$_, $colorCode, $colorHash{$colorCode}) for my $colorCode (keys %colorHash);
	print;
}
