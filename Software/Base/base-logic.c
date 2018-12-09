
#include "../Libraries/QEI.h"
#include "../Libraries/PWM.h"
#include "../Libraries/SysTick.h"
#include "../Libraries/UART.h"
#include "../Libraries/LCD.h"
#include "../Libraries/PRNG.h"
#include "../Libraries/Frame.h"
#include "../Libraries/RockPaperScissors.h"

#include <tm4c123gh6pm.h>

////////////////////////////////////////////////////////////////////////////////

byte frame[1 + 5] = {0};
byte data[5] = {0};

PWM_ servos[5] = {M0PWM0_, M0PWM1_, M1PWM4_, M1PWM6_, M0PWM6_0_};

unsigned ByteToPercent(byte b)
{
	return 100.0 / 255.0 * b;
}

void UpdateDisplay(void)
{
	for (int i = 0; i < 5; i++)
	{
		LCD_PrintChar(LCD0_, i + 'A');
		int n = LCD_PrintNumber(LCD0_, data[i]);
		for (int j = 0; j < 5-n; j++)
		{
			LCD_PrintChar(LCD0_, ' ');
		}
	}
}

void MoveFingers(void)
{
	int min_raw = 90;
	int max_raw = 160;
	
	for (int i = 0; i < 3; i++)
	{
		PWM_Position(servos[i], 18000.0 + (1000.0/(max_raw-min_raw)*(data[i]-min_raw)));
	}
	for (int i = 3; i < 5; i++)
	{
		PWM_Position(servos[i], 19000.0 - (1000.0/(max_raw-min_raw)*(data[i]-min_raw)));
	}
}

void MoveFingersDiscrete(bool position[])
{
	for (int i = 0; i < 3; i++)
	{
		PWM_Position(servos[i], 18000 + 1000*position[i]);
	}
	for (int i = 3; i < 5; i++)
	{
		PWM_Position(servos[i], 19000 - 1000*position[i]);
	}
}

///////////////////////////////////////////////////////////////
// Rock Paper Scissors
///////////////////////////////////////////////////////////////


bool positions[][5] = {
[ROCK]     = { 1, 1, 1, 1, 1 },
[PAPER]    = { 0, 0, 0, 0, 0 },
[SCISSORS] = { 1, 0, 0, 1, 1 }
};

bool Match(bool a[], bool b[], unsigned size)
{
	for (unsigned i = 0; i < size; i++)
	{
		if (a[i] != b[i])
		{
			return false;
		}
	}
	
	return true;
}

POSITION_ DeduceGlove(void)
{
	bool position[5] = {};
		
	for (unsigned i = 0; i < 5; i++)
	{
		if (data[i] >= 110)
		{
			position[i] = 1;
		}
	}
	
	for (POSITION_ p = ROCK; p <= SCISSORS; p++)
	{
		if (Match(position, positions[p], 5))
		{
			return p;
		}
	}
	
	return NONE;
}



///////////////////////////////////////////////////////////////

void Button_Init(void)
{
	GPIOC->AMSEL &= ~0b10000000;
	GPIOC->PCTL &= ~0xF0000000;
	GPIOC->DIR &= ~0b10000000;
	GPIOC->AFSEL &= ~0b10000000;
	GPIOC->PUR |= 0b10000000;
	GPIOC->DEN |= 0b10000000;
}

bool Button_Status(void)
{
	return !!!(GPIOC->DATA & 0b10000000);
}

void setup(void)
{
	SysTick_Init();
	
	PRNG_Seed(12345);
	
	for (int i = 0; i < 5; i++)
 	{
 		PWM_Init(servos[i], 50);
 	}
	
	LCD_Init(LCD0_, UART5_, 9600);
	UART_Init(UART2_, true, false, 9600);
	LCD_ClearScreen(LCD0_);
	
	Button_Init();
}

void Announce(char * string, uint32_t length)
{
	LCD_ClearScreen(LCD0_);
	LCD_PrintString(LCD0_, string);
	SysTick_WaitSeconds(length);
}

void PlayGame(POSITION_ * glove, POSITION_ * hand, RESULT_ * result)
{
	*glove = DeduceGlove();
	*hand = PRNG_RandomNumber(ROCK, SCISSORS);
	*result = Compete(*glove, *hand);
}

void CollectData(byte * frame, byte * data)
{
	UART_ClearFIFO(UART2_);
	Frame_Recieve(frame, 5);
	Frame_Unpack(frame, data, 5);
}

POSITION_ glove;
POSITION_ hand;
RESULT_ result;

void loop_rps(void)
{
	Announce("Rock...", 1);
	Announce("Paper...", 1);
	Announce("Scissors...", 1);
	
	CollectData(frame, data);
	PlayGame(&glove, &hand, &result);
	MoveFingersDiscrete(positions[hand]);
	Announce("Shoot!", 1);
	
	if (glove == NONE)
	{
		Announce("We're not playing lizard-spock!", 3);
		return;
	}
	
	switch (result)
	{
		case DRAW: Announce("It's a draw!\nTry again.", 3);
							 break;
		case LOSS: Announce("I am victorious, puny mortal!", 3);
							 break;
		case WIN:  Announce("I was just going easy on you.", 3);
							 break;
	}
}

void DisplayValues(void)
{
	static unsigned update_screen = 0;
	if (update_screen++ == 50)
	{
		LCD_ClearScreen(LCD0_);
		UpdateDisplay();
		
		update_screen = 0;
	}
}

void loop_im(void)
{
	CollectData(frame, data);
	DisplayValues();
	MoveFingers();
	//SysTick_WaitMilliseconds(500);
}

void MoveFingersDiscreteSeries(bool positions[][5], unsigned count, uint32_t delay)
{
	for (int i = 0; i < count; i++)
	{
		MoveFingersDiscrete(positions[i]);
		SysTick_WaitMilliseconds(delay);
	}
}

void loop_ss(void)
{
	// Scale
	Announce("SCALE\nscreensaver", 0);
	static bool scale[][5] = {
		{ 1, 0, 0, 0, 0 },
		{ 0, 1, 0, 0, 0 },
		{ 0, 0, 1, 0, 0 },
		{ 0, 0, 0, 1, 0 },
		{ 0, 0, 0, 0, 1 },
		{ 0, 0, 0, 1, 0 },
		{ 0, 0, 1, 0, 0 },
		{ 0, 1, 0, 0, 0 }
	};
	//MoveFingersDiscreteSeries(scale, 8, 500);
	
	// Counting
	Announce("COUNTING\nscreensaver", 0);
	static bool counting[][5] = {
		{ 1, 1, 1, 1, 1 },
		{ 1, 0, 1, 1, 1 },
		{ 1, 0, 0, 1, 1 },
		{ 1, 0, 0, 0, 1 },
		{ 1, 0, 0, 0, 0 },
		{ 0, 0, 0, 0, 0 }
	};
	MoveFingersDiscreteSeries(counting, 6, 500);
	
	// The Wave
	Announce("THE WAVE\nscreensaver", 0);
	static bool wave[][5] = {
		{ 1, 0, 0, 0, 0 },
		{ 0, 1, 0, 0, 0 },
		{ 0, 0, 1, 0, 0 },
		{ 0, 0, 0, 1, 0 },
		{ 0, 0, 0, 0, 1 }
	};
	//MoveFingersDiscreteSeries(wave, 5, 40);
	
	// The Wave
	Announce("THE WAVE I\nscreensaver", 0);
	static bool wavei[][5] = {
		{ 0, 1, 1, 1, 1 },
		{ 1, 0, 1, 1, 1 },
		{ 1, 1, 0, 1, 1 },
		{ 1, 1, 1, 0, 1 },
		{ 1, 1, 1, 1, 0 },
		{ 1, 1, 1, 0, 1 },
		{ 1, 1, 0, 1, 1 },
		{ 1, 0, 1, 1, 1 },
		{ 0, 1, 1, 1, 1 }
	};
	//MoveFingersDiscreteSeries(wavei, 9, 100);
}

typedef enum {
	SS,
	IM,
	RPS
} MODE_;

void loop_ult(void)
{
	static bool prev, curr;
	static MODE_ mode;
	
	prev = curr;
	curr = Button_Status();
	
//	if (curr != prev)
//	{
//		int poll = 0;
//		for (int i = 0; i < 1000; i++)
//		{
//			poll += Button_Status();
//		}
//		
//		if (poll > 900)
//		{
//		}
//	}
	
	
	//LCD_ClearScreen(LCD0_);
	
	if (curr)
	{
		if (curr != prev)
		++mode; if (mode > RPS) { mode = SS; }
		//LCD_PrintString(LCD0_, "Yes\n");
	}
	else
	{
		//LCD_PrintString(LCD0_, "No\n");
	}
	switch (mode)
	{
		case SS:  //LCD_PrintString(LCD0_, "SS");
							loop_ss();
							break;
		case IM:  //LCD_PrintString(LCD0_, "IM\n");
							loop_im();
							break;
		case RPS: //LCD_PrintString(LCD0_, "RPS\n");
							loop_rps();
							break;
	}
	//SysTick_WaitMilliseconds(100);
}

#define ult
void loop(void)
{
#ifdef rps
	loop_rps();
#endif
	
#ifdef im
	loop_im();
#endif
	
#ifdef ss
	loop_ss();
#endif
	
#ifdef ult
	loop_ult();
#endif
}
