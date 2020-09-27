#!/bin/bash -u
echo "db.book.drop();" > insert_comments.js
echo "db.book.insertMany([" >> insert_comments.js

for isbn in $(awk -F\",\" '{if(FNR==1){next};print $6}' isbn.csv | tr -d '"');do
   title=`grep "${isbn}" isbn.csv | awk -F\",\" '{print $1}' | tr -d '"'`
   author=`grep "${isbn}" isbn.csv | awk -F\",\" '{print $2}' | tr -d '"'`
   publisher=`grep "${isbn}" isbn.csv | awk -F\",\" '{print $3}' | tr -d '"'`
   comment=`sed -n -e '/^\[.*'"$isbn"'.*\]$/I,/^$/p;' read_comments.txt | grep -v "^\[.*\]\|^\$" | sed "s/\"/\\/\"/g" | tr '/' '\' 2>/dev/null`
   document=`cat <<EOF
	\n{ "isbn": "${isbn}",
     "title": "${title}",
     "author": "${author}",
     "publisher": "${publisher}",
     "comment": "${comment}"
   },
EOF
`
   echo -e $document >> insert_comments.js
done

sed -i '$ s/,$//g' insert_comments.js
echo "]);" >> insert_comments.js

#TODO:
# 1. Determine why sed code isn't pattern matching correctly when running via WSL2 Bash vs GitBash
# 2. Replace the invididual invocations of awk with a single awk pipeline to get all of the other variables. The current script is running slow..
