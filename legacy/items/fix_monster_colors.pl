#!/usr/bin/perl -w

use strict;

sub recolor
{
	(my $lineRef, my $color, my $arrayRef) = @_;
	for my $monster (@$arrayRef) { $$lineRef =~ s/(?<=: )$monster/<font color="$color">$&<\/font>/g }
}

my @green = ("Wracked Soul", "Bloodbrother", "Ratfink", "Armored Titan", "Venom Fiend", "Moon Panther", "Darksister");
my @yellow = ("Black Death", "Deathfire Bearer", "Dirge", "Avalanche", "Trap Rat", "Black Ice Demon", "Living Flame", "Fireblood", "Iced Soul", "Onyx Knight", "Cenobite", "Tree of Life", "Cog", "Daystar", "Serafiend", "Lament", "Corruptor Archer", "Edyrem", "Ulfhedinn", "Black Cat", "Broken Soul", "Shrieker");
my @gold = ("Slain Soul", "Andariel", "Dark Star Dragon", "Imperius", "Death Projector");
my @grey = ('Baal (Vision of Destruction)', "Stone(?! )");

my %colorHash = (
	"#20b020" => \@green,
	"#ffff20" => \@yellow,
	"#ff9900" => \@gold,
    "#808080" => \@grey,
);

$^I = "~";
while (<>)
{
	for my $colorCode (keys %colorHash) { &recolor(\$_, $colorCode, $colorHash{$colorCode}) }
	print;
}
