
#ifndef _ROCKPAPERSCISSORS_H_
#define _ROCKPAPERSCISSORS_H_

typedef enum {
	ROCK,
	PAPER,
	SCISSORS,
	NONE
} POSITION_;

typedef enum {
	DRAW,
	LOSS,
	WIN
} RESULT_;

RESULT_ Compete(POSITION_ you, POSITION_ opp);

#endif
