#!/bin/bash
GALLERIES=(tutorial record fantasy)
for GALLERY in "${GALLERIES[@]}"; do
	cd "$GALLERY"
	ls -1 -A | grep -v ".DS_Store" | while read DIRNAME
	do
	       # Call Function fltyp with the filename as a parameter
	       cd "${DIRNAME}"
		latexmk -pdflatex="xelatex --shell-escape -synctex=1" -pdf "${GALLERY}_${DIRNAME}.tex"
	       cd ..
       done
       cd ..
done
