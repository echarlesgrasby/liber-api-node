#!/bin/bash -u

#\x22 is the hex code for ASCII 
#" \x27 is the hex code for '

tstamp=`date +%m%d%y_%H%M`
echo "Records will be appended to liber_$tstamp.csv"

while true;
do
	echo -e "Press Ctrl-C to exit.\n\n"
	
	read -p "Title: " title
	read -p "Author: " author
	read -p "Published Year (YYYY): " pubDate
	read -p "Edition Number: " edition
	read -p "Physical/Digital (P/D): " digState
	read -p "Genre: " genre
	
	echo -e "
	Title: $title
	Author: $author
	Publisher Date: $pubDate
	Edition: $edition
	Copy Owned: $digState
	Genre: $genre
	" 
	
	read -p "Is this correct? (y/n) " submit
	[[ $submit = "y" ]] && echo "Writing to $title to liber.csv" && 
	
	#create one entry per book for csv. Since I probably will catalogue them in sprints, make a new csv file each time. I'll cat them together with a different script later..
	echo "\"${title}\",\"${author}\",\"${pubDate}\",\"${edition}\",\"${digState}\",\"${genre}\"" | tee -a liber_$tstamp.csv
	
done
