
#include "RockPaperScissors.h"

RESULT_ Compete(POSITION_ you, POSITION_ opp)
{
	if (you == opp)
	{
		return DRAW;
	}
	
	if ((you == ROCK && opp == SCISSORS) ||
			(you == PAPER && opp == ROCK) ||
			(you == SCISSORS && opp == PAPER))
	{
		return WIN;
	}
		
	return LOSS;
}
