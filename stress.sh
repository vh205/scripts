#!/usr/bin/bash
# stress code slow gen numtest

build $1
build $2
build $3

RED='\033[0;31m'
GREEN='\033[0;32m'
for ((testNum=0;testNum<$4;testNum++))
do 
    ./$3 > inp
    ./$2 < inp > out
    ./$1 < inp > ans
    H1='md5sum out'
    H2='md5sum ans'
	echo $(cat out) > out
	echo $(cat ans) > ans
    if !(cmp -s "outWrong" "outSlow")
    then
        echo -e $"\e[1mInput:\e[0m"
        cat inp
        echo -e $"\e[1mSlow Output:\e[0m"
        cat out 
        echo -e $"\e[1mOutput:\e[0m"
        cat ans 
        echo $""
		echo -e "${RED}Wrong answer!${NC}"
        exit
    fi
done
if [ $4 -eq 1 ]; then echo -e "${GREEN}Passed 1 test${NC}"; else echo -e "${GREEN}Passed $4 tests${NC}"; fi
