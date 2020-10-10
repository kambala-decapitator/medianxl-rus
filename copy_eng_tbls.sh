#!/usr/bin/env bash

modVersion="$1"
pathToOriginalRepo="${2:-../mxl-translations}"
engStringsPath="tbl/sigma/en"

cp "$pathToOriginalRepo/MXL_translation_ENG_SIGMA/"*.{txt,tbl} "$engStringsPath"
git commit -m "$modVersion en strings" "$engStringsPath"/*
