#!/bin/bash -x

echo "============WELCOME TO TIC TAC TOE============"

#declaring dictonary
declare -A board

#variables
count=1
end=1
tie=0
#constants
HEAD=1

#function to reset board
function boardReset()
{
	local row=0
	local column=0
	##resetting each and every row and column of the board matrix
	for(( row=1; row<=3; row++))
	do
		for(( column=1; column<=3; column++))
		do
			board[$row,$column]=" "
		done
	done
}

#calling function to reset board
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

#accepting input from the player
read -p "Single Player : 1 OR Two Player : 2 Select Option:-" playerChoice

if (( $playerChoice == 1 ))
then
	PLAYER1="PLAYER1"
	PLAYER2="Computer"
else
	PLAYER1="PLAYER1"
	PLAYER2="PLAYER2"
fi
#assigning X to player1 and 0 to player2
printf "X For $PLAYER1 \nO For $PLAYER2\n"

#toss to decide which player plays first
toss=$((1+RANDOM%2))
if (( $toss == $HEAD ))
then
	printf "$PLAYER1 Wins \n"
else
	printf "$PLAYER2 Wins \n"
fi

#function to insert letter to a specfic position
function addAtPosition()
{
	if (( ${board[$1,$2]} == 0 || ${board[$1,$2]} == X ))
	then
		printf "This Position Already Filled \n"
	else
		if (( $(($toss%2)) == 0 ))
		then
			board[$1,$2]=0
		else
			board[$1,$2]=X
		fi
		winOrTie
		(( toss++ ))
	fi
}

#function to check if there is a win or a tie
function winOrTie()
{
	#rowscheck
	if [[ ${board[0,0]} == ${board[0,1]} && ${board[0,1]} == ${board[0,2]} || ${board[1,0]} == ${board[1,1]} && ${board[1,1]} == ${board[1,2]} || ${board[2,0]} == ${board[2,1]} && ${board[2,1]} == ${board[2,2]} ]]
	then
		decideWinner

	elif [[ ${board[0,0]} == ${board[1,1]} && ${board[1,1]} == ${board[2,2]} || ${board[0,2]} == ${board[1,1]} && ${board[1,1]} == ${board[2,0]} ]]
	then
		decideWinner
	#columnscheck
	elif [[ ${board[0,1]} == ${board[1,0]} && ${board[1,0]} == ${board[2,0]} || ${board[0,1]} == ${board[1,1]} && ${board[1,1]} == ${board[2,1]} || ${board[0,2]} == ${board[1,2]} && ${board[1,2]} == ${board[2,2]} ]]
	then
		decideWinner
	fi
	#tieconditioncheck
	(( tie++ ))
	if (( $tie == 9 ))
	then
		board
		printf "Match is Tie\n"
		end=0
	fi
}

#function to yield the winner
function decideWinner()
{
	board
	if (( $(($toss%2)) == 0 ))
	then
		printf "$PLAYER2 is the winner\n"
		end=0
	else
		printf "$PLAYER1 is the winner\n"
		end=0
	fi
}

# printing Board to insert letter at specific cell position
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

#function to include computer as a player
function computer()
{
	if (( ${board[0,0]} == 1 || ${board[1,0]} == ${board[2,0]} && ${board[0,0]} != X && ${board[0,0]} != 0 || ${board[0,1]} == ${board[0,2]} && ${board[0,0]} != X && ${board[0,0]} != 0 || ${board[1,1]} == ${board[2,2]} && ${board[0,0]} != X && ${board[0,0]} != 0 ))
	then
		addAtPosition 0 0
	elif (( ${board[0,0]} == ${board[0,2]} && ${board[0,1]} != X && ${board[0,1]} != 0 || ${board[1,1]} == ${board[2,1]} && ${board[0,1]} != X && ${board[0,1]} != 0 ))
	then
		addAtPosition 0 1
	elif (( ${board[0,0]} == ${board[0,1]} && ${board[0,2]} != X && ${board[0,2]} != 0 || ${board[1,2]} == ${board[2,2]} && ${board[0,2]} != X && ${board[0,2]} != 0 || ${board[1,1]} == ${board[2,0]} && ${board[0,2]} != X && ${board[0,2]} != 0 ))
	then
		addAtPosition 0 2
	elif (( ${board[0,0]} == ${board[2,0]} && ${board[1,0]} != X && ${board[1,0]} != 0 || ${board[1,1]} == ${board[1,2]} && ${board[1,0]} != X && ${board[1,0]} != 0 ))
	then
		addAtPosition 1 0
	elif (( ${board[1,0]} == ${board[1,2]} && ${board[1,1]} != X && ${board[1,1]} != 0 || ${board[0,1]} == ${board[2,1]} && ${board[1,1]} != X && ${board[1,1]} != 0 || ${board[0,0]} == ${board[2,2]} && ${board[1,1]} != X && ${board[1,1]} != 0 || ${board[0,2]} == ${board[2,0]} && ${board[1,1]} != X && ${board[1,1]} != 0 ))
	then
		addAtPosition 1 1
	elif (( ${board[1,0]} == ${board[1,1]} && ${board[1,2]} != X && ${board[1,2]} != 0 || ${board[0,2]} == ${board[2,2]} && ${board[1,2]} != X && ${board[1,2]} != 0 ))
	then
		addAtPosition 1 2
	elif (( ${board[0,0]} == ${board[1,0]} && ${board[2,0]} != X && ${board[2,0]} != 0 || ${board[2,1]} == ${board[2,2]} && ${board[2,0]} != X && ${board[2,0]} != 0 || ${board[0,2]} == ${board[1,1]} && ${board[2,0]} != X && ${board[2,0]} != 0 ))
	then
		addAtPosition 2 0
	elif (( ${board[2,0]} == ${board[2,2]} && ${board[2,1]} != X && ${board[2,1]} != 0 || ${board[1,1]} == ${board[0,1]} && ${board[2,1]} != X && ${board[2,1]} != 0 ))
	then
		addAtPosition 2 1
	elif (( ${board[2,0]} == ${board[2,1]} && ${board[2,2]} != X && ${board[2,2]} != 0 || ${board[0,2]} == ${board[1,2]} && ${board[2,2]} != X && ${board[2,2]} != 0 || ${board[0,0]} == ${board[1,1]} && ${board[2,2]} != 0 && ${board[2,2]} != X || ${board[2,2]} == 9 ))
	then
		addAtPosition 2 2
	elif (( ${board[0,2]} == 3 ))
	then
		addAtPosition 0 2
	elif (( ${board[2,0]} == 7 ))
	then
		addAtPosition 2 0
	elif (( ${board[1,1]} == 5 ))
	then
		addAtPosition 1 1
	else
		randomPosition1=$((RANDOM%3))
		randomPosition2=$((RANDOM%3))
		addAtPosition $randomPosition1 $randomPosition2
	fi
}

#looping till a player wins or reaches a tie condition
while (( $end != 0 ))
do
	board
	if (( $(($toss%2)) == 0 ))
	then
		if (( $playerChoice == 1 ))
		then
			computer
			printf "\n"
			board
		else
			read -p "$PLAYER2 Enter A Position" choice
		fi
	fi
	if (( $(($toss%2)) == 1 ))
	then
		read -p "$PLAYER1 Enter A Position" choice
	fi
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
			printf "Enter A Valid Position \n" ;;
	esac
done
