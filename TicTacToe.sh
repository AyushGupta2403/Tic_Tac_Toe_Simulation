###!/bin/bash -x
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
boardReset
function toss(){
	firstPlayTurns=0
	tossDecision=$((RANDOM%2))
	if [ $tossDecision -eq 1 ]
	then
		firstPlayTurns=1
		echo "Computer Won Toss"
		symbol=$((RANDOM%2))
                if [ $symbol -eq 1 ]
                then
                        compSymbol='X'
                        userSymbol='O'
                else
                        compSymbol='O'
                        userSymbol='X'
                fi
	else
		firstPlayTurns=2
		echo "User won toss"
		read -p "Enter 1 for 'X' symbol and 2 for 'O' symbol: " symbol
                if [ $symbol -eq 1 ]
                then
                        userSymbol='X'
                        compSymbol='O'
                else
                        userSymbol='O'
                        compSymbol='X'
                fi
        fi
	echo " ";echo "Assigned Symbols";echo "Computer: $compSymbol";echo "User: $userSymbol"
}
function printingBoard()
{
for ((row=0; row<3; row++))
do
	for ((column=0; column<3; column++))
	do
		board[$row,$column]=$(( count++ ))
		printf "[""${board[$row,$column]}""]"
	done
	printf "\n"
done
}

#calling function
toss
printingBoard
