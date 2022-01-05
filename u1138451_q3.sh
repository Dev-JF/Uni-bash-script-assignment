#!/bin/bash


# This block ensures that the correct files and directories exist and are readable, if they dont the script exits


if [[ -r ./Cars.txt && -r ./Marks.txt ]]; then
 


  if [[ -s ./Marks.txt ]]; then


  if [[ -f ./overviewTemplate.md ]]; then
	
	if [[ -d ./OUTPUT ]]; then




# This while loop extracts the nessecary information from each doucment and places them in a temp var then uses that information to replace the section in the template then compiles the pandoc
X=2

LINECOUNT=$(wc -l < ./Marks.txt)

while [ $X -le $LINECOUNT ]; do





# This var takes the the carid and description from the first file

CARID=$(sed -n ${X}p ./Cars.txt | cut -d "," -f1)
DESCRIPTION=$(sed -n ${X}p ./Cars.txt | cut -d "," -f2)
T1=$(sed -n /$CARID/p ./Marks.txt | cut -d "," -f2)
T2=$(sed -n /$CARID/p ./Marks.txt | cut -d "," -f3)
T3=$(sed -n /$CARID/p ./Marks.txt | cut -d "," -f4)
TT=$(( $T1 + $T2 + $T3 ))
COMMENTS=$(sed -n /$CARID/p ./Marks.txt | cut -d "," -f5)




# using the carid it takes the line that contains the carid in the second file and cuts them into the correct section

sed 's,carid,'"$CARID"',g' overviewTemplate.md | sed 's,description,'"$DESCRIPTION"',g' | sed 's,t1,'"$T1"',g' | sed 's,t2,'"$T2"',g' | sed 's,t3,'"$T3"',g' | sed 's,tt,'"$TT"',g' | sed 's,comments,'"$COMMENTS"',g'  > ./OUTPUT/${CARID}.md

echo " The ${CARID}.md document has been created "

pandoc ./OUTPUT/${CARID}.md -o ./OUTPUT/${CARID}.pdf;

rm ./OUTPUT/${CARID}.md;

echo " The ${CARID}.pdf file has been created and the ${CARID}.md document has been removed "

X=$(( $X + 1 ))


done


  
  exit 0
  

else
 echo " The Output directory does not exist"
exit 1
fi

else
 echo  " The overview templae does not exits "
exit 1
fi 

else 
  
echo " The Marks.txt doucment is empty "
  exit 1
  
  fi

else
echo " The Cars.txt or Marks.txt doucment is not reabable by the script or they dont exist "

exit 1
fi