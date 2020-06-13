#!/bin/bash -x
echo "=================WELCOME TO TIC_TAC_TOE SIMULATION================"
#declaring a dictonary
declare -A board

#function to reset board
function boardReset()
{
	local row=0
	local column=0
	#resetting each and every row and column of the board matrix
	for(( row=1; row<=3; row++))
	do
		for(( column=1; column<=3; column++))
		do
			board[$row,$column]=" "
		done
	done
	echo "--Board Reseted--"
}
function toss(){
	tossDecision=$((RANDOM%2))
	if [ $tossDecision -eq 1 ]
	then
		echo Users Turn
                compSymbol='O'
                userSymbol='X'
        else
               	echo Computers Turn
		compSymbol='X'
                userSymbol='O'
        fi
	echo " ";echo "Assigned Symbols";echo "Computer: $compSymbol";echo "User: $userSymbol"
}
#calling board reset function
boardReset
toss
