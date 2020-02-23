#!/bin/bash

# This is easier than an actual error log
echo "$1 $2 $3" >>file.txt

#trump

#render top line
convert -size 1600x1152 xc:transparent -font TRUMP.otf -fill '#C90022' -pointsize 110 -annotate -4.6x1+0+367 "$1" -blur 2x2 -trim $3_TRUMP.png 

#identify size of top line and calculate geometry
declare -i trumpwidth
trumpwidth=$(identify -format "%w" $3_TRUMP.png)
trumpdivisor=$(echo "scale=2; $trumpwidth / 1580" | bc)
trumpx=$(echo "scale=1; 914 - ($trumpdivisor * 761)" | bc)
trumpy=$(echo "scale=1; 344 - ($trumpdivisor * 64)" | bc)

#bloomberg

#render bottom line
convert -size 1600x1152 xc:transparent -font BLOOMBERG.ttf -fill '#07143A' -pointsize 48 -annotate -4.2x1+0+367 "$2" -blur 2x2 -trim $3_BLOOMBERG.png

#identify size of bottom line and calculate geometry
declare -i bloomberg
bloombergwidth=$(identify -format "%w" $3_BLOOMBERG.png)
bloombergdivisor=$(echo "scale=2; $bloombergwidth / 1585" | bc)
bloombergx=$(echo "scale=1; 915 - ($bloombergdivisor * 762)" | bc)
bloombergy=$(echo "scale=1; 490 - ($bloombergdivisor * 65)" | bc)

#composite, in two steps, because composite can't do two things at once
composite -geometry +$trumpx+$trumpy $3_TRUMP.png BLANK.png $3_TEMP.png 
composite -geometry +$bloombergx+$bloombergy $3_BLOOMBERG.png $3_TEMP.png -quality 75 $3.jpg 

#clean up
rm $3_TRUMP.png
rm $3_TEMP.png
rm $3_BLOOMBERG.png