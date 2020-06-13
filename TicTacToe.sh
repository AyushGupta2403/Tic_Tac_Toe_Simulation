###!/bin/bash -x

XXXXXXXXXX	WELCOME TO TIC TAC TOE	XXXXXXXXXXX

#declaring a dictonary
declare -A board

#variables
count=1
end=1
tie=0
#constants
head=1
end=1
tie=0

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
}
#calling borad reset function
boardReset

#cell position on the board matrix
for ((row=0; row<3; row++))
do
	for ((column=0; column<3; column++))
	do
		board[$row,$column]=$(( count++ ))
	done
	printf "\n"
done
#assigning X and 0 to player1 and player2 respectively
PLAYER1="PLAYER1"
PLAYER2="PLAYER2"
printf "X For $PLAYER1 \nO For $PLAYER2\n"

#toss to decide who plays first randomly
toss=$((1+RANDOM%2))
if (( $toss == $head ))
then
	printf "$PLAYER1 Is Win \n"
else
	printf "$PLAYER2 Is Win \n"
fi

#function to place X or 0 at a specific position
function addAtPosition()
{
	if [ $(($toss%2)) -eq 0 ]
	then
		board[$1,$2]=0
	else
		board[$1,$2]=X
	fi
	winOrTie
}

#function to check Win or a Tie
function winOrTie()
{
	#ROWS
	if [[ ${board[0,0]} == ${board[0,1]} && ${board[0,1]} == ${board[0,2]} || ${board[1,0]} == ${board[1,1]} && ${board[1,1]} == ${board[1,2]} || ${board[2,0]} == ${board[2,1]} && ${board[2,1]} == ${board[2,2]} ]]
	then
		whoIsWin

	elif [[ ${board[0,0]} == ${board[1,1]} && ${board[1,1]} == ${board[2,2]} || ${board[0,2]} == ${board[1,1]} && ${board[1,1]} == ${board[2,0]} ]]
	then
		whoIsWin
	#COLUMES
	elif [[ ${board[0,1]} == ${board[1,0]} && ${board[1,0]} == ${board[2,0]} || ${board[0,1]} == ${board[1,1]} && ${board[1,1]} == ${board[2,1]} || ${board[0,2]} == ${board[1,2]} && ${board[1,2]} == ${board[2,2]} ]]
	then
		whoIsWin
	fi
	# TIE
	(( tie++ ))
	if (( $tie == 9 ))
	then
		board
		printf "Match is Tie\n"
		end=0
	fi
}

#function to check winner between player1 and player2
function whoIsWin()
{
	board
	if [ $(($toss%2)) -eq 0 ]
	then
		printf "$PLAYER2 is the winner\n"
		end=0
	else
		printf "$PLAYER1 is the winner\n"
		end=0
	fi
}

#function to call board to choose  a cell
function  board()
{
	for ((row=0; row<3; row++))
	do
		for ((column=0; column<3; column++))
		do
			printf "[""${board[$row,$column]}""]"    
		done
			printf "\n"
	done
}

#looping till a player wins or there is a tie
while (( $end != 0 ))
do
	board
	if (( $(($toss%2)) == 0 ))
	then
		read -p "$PLAYER2 Enter A Position" choice
	else
		read -p "$PLAYER1 Enter A Position" choice
	fi
	((toss++))
	case $choice in
		1)
			addAtPosition 0 0 ;;
		2)
			addAtPosition 0 1 ;;
		3)
			addAtPosition 0 2 ;;
		4)
			addAtPosition 1 0 ;;
		5)
			addAtPosition 1 1 ;;
		6)
			addAtPosition 1 2 ;;
		7)
			addAtPosition 2 0 ;;
		8)
			addAtPosition 2 1 ;;
		9)
			addAtPosition 2 2 ;;
		*)
			printf "Enter A Valied Position \n" ;;
	esac
done
