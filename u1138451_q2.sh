#!/bin/bash
# This script takes two arguments
# an input file and an output file

# This if statement verifies if theres two arguments
if [ $# -eq 2 ]; then

# This if statement verifies that the input file exists and can be read  
if [ -e "$1" ]; then
    
if [ -r "$2" ]; then

while true; do

# this prompts the user to approve to overwrite the file and assings their answer to the var ANS
  read -p "Is it ok to  overwrite the file? " ANS
    
# This case statement takes the user input tests it against the case statements 
    case $ANS in
    
    y | Y) 
	   
# This sed command matches and removes skips the first line the matches any comments and blank lines and removes them, the cmhod gives the owner executable permission	
   sed '1b;/^[ \t]*#/d;/^$/d' "$1" > "$2";
   chmod u+x $2;
   echo " $2 was created ";
	break
	exit 0;
    ;;

    n | N) echo "The file was not overwritten"
    exit 1
    ;;
    
    *)  echo "Please ansewr with a y,Y for yes or n,N for no " >&2

 
    esac

done
    
else

echo "new file created"

# This sed command matches and removes skips the first line the matches any comments and blank lines and removes them, the cmhod gives the owner executable permission

    sed '1b;/^[ \t]*#/d;/^$/d' "$1" > "$2";
    chmod u+x $2;

exit 0

fi


else
  
echo "please enter a usable input file"
exit 1

fi

else

echo "Please provide two arguments"
exit 1
 

fi
