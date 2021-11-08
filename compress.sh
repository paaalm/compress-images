#!/bin/bash

# ---
# Example: 
# sh compress.sh '/path/to/files' '/path/to/destination'
# ---

FILES=$1
DESTINATION=$2

mkdir -p $DESTINATION

for FILE in $FILES/*
do
if [[ "$FILE" == *\.* ]]
then
	WIDTH=`identify -format '%w' $FILE`
	
	QUALITY=85
	
	if [ $WIDTH > 3839 ]; then	
		QUALITY=45
	elif [ $WIDTH > 1959 ]; then	
		QUALITY=55
	elif [ $WIDTH > 1279 ]; then
		QUALITY=65
	fi

	convert $FILE -sampling-factor 4:2:0 -strip -quality $QUALITY -interlace JPEG -set colorspace RGB $DESTINATION/$(basename "${FILE}")
	echo compressed $FILE "("$WIDTH"px, "$QUALITY"%)" $?
fi
done
