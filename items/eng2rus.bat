@echo off
echo start: %time%
perl eng2rus.pl uniques_sacred.html uniques_tiered.html runewords.html sets.html
perl errors.pl uniques_sacred.html uniques_tiered.html runewords.html sets.html
echo finish: %time%
pause
