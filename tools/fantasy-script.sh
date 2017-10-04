#!/bin/bash
ORIG=/home/ppxasjsm/Desktop/surfer_ar/fantasy_ar/


for f in fantasy_dingdong fantasy_intro fantasy_tuelle fantasy_dullo fantasy_kolibri fantasy_visavis fantasy_nepali fantasy_zeck fantasy_helix fantasy_quaste fantasy_zitrus fantasy_himmel fantasy_suess
do
cp ${ORIG}${f}_ar.tex ./$f.tex
echo $f.tex
done

