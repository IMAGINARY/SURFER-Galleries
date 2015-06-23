#!/bin/bash
ORIG=/path/to/original/files
DEST=/path/to/destination/files

for f in tutorial_2kugeln tutorial_en tutorial_intro tutorial_koord2 tutorial_kugel tutorial_tricks1 tutorial_wuerfel tutorial_ebene tutorial_gerade tutorial_koord1 tutorial_kreis tutorial_parabel tutorial_tricks2 tutorial_zitrus
do

iconv -f windows-1255 -t UTF-8 $ORIG/$f.TEX > $DEST/$f.tex
awk 'NR==1{sub(/^\xef\xbb\xbf/,"")}{print}' $f.tex > temp.tex
mv temp.tex $f.tex
echo $f.tex
done

