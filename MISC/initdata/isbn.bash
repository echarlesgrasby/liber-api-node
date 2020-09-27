#!/bin/bash

while read -u 5 isbn;
do
	echo "ISBN: $isbn";
	[ -f ../covers/${isbn}.jpg ] && echo "\"${isbn}\",\"covers/${isbn}.jpg\"" >> isbn_with_cover_path.csv
done 5<#use a csv file as a HEREDOC. 