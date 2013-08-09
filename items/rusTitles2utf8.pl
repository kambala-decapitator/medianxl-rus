#!/usr/bin/perl

use warnings;
use strict;

my @titles = qw/Матриарх Страж Покоритель Разрушитель Патриарх Чемпион Убийца/;
print "$_: ".unpack("H*", $_)."\n" for (@titles);
