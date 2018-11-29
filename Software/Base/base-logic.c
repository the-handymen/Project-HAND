
#include "../Libraries/QEI.h"
#include "../Libraries/PWM.h"
#include "../Libraries/SysTick.h"

#include "../Libraries/UART.h"
#include "../Libraries/LCD.h"

#include <tm4c123gh6pm.h>

typedef uint8_t byte;

byte frame[1 + 5] = {0};
byte data[5] = {0};

PWM_ servos[5] = {M0PWM0_, M0PWM1_, M1PWM4_, M1PWM6_, M0PWM6_0_};

unsigned ByteToPercent(byte b)
{
	return 100.0 / 255.0 * b;
}

void Frame_Recieve(byte * frame, unsigned data_size)
{
	char c;
	do
	{
		c = UART_ReadChar(UART2_);
	}
	while (c != 0xDA);
	frame[0] = c;
	for (int i = 1; i < 1 + data_size; i++)
	{
		frame[i] = UART_ReadChar(UART2_);
	}
}

void Frame_Unpack(byte * frame, byte * data, unsigned data_size)
{
	for (int i = 0; i < data_size; i++)
	{
		data[i] = frame[1 + i];
	}
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


void setup(void)
{
	SysTick_Init();
	
	for (int i = 0; i < 5; i++)
 	{
 		PWM_Init(servos[i], 50);
 	}
	
	LCD_Init(LCD0_, UART5_, 9600);
	UART_Init(UART2_, true, false, 9600);
	LCD_ClearScreen(LCD0_);
}

void loop(void)
{
	Frame_Recieve(frame, 5);
	Frame_Unpack(frame, data, 5);
	LCD_ClearScreen(LCD0_);
	UpdateDisplay();
	for (int i = 0; i < 2; i++)
	{
		PWM_Position(servos[i], 19000.0 - (1000.0/(130-90)*(data[i]-90)));
	}
	for (int i = 2; i < 5; i++)
	{
		PWM_Position(servos[i], 18000.0 + (1000.0/(130-90)*(data[i]-90)));
	}
	//SysTick_WaitMilliseconds(500);
	UART_ClearFIFO(UART2_);
}

// #define Bit(b) ( 1U<<b )
//
// PWM_ servos[5] = {M0PWM0_, M0PWM1_, M1PWM4_, M1PWM6_, M0PWM6_0_};
//
// void setup(void)
// {
// 	SysTick_Init();
// 	for (int i = 0; i < 5; i++)
// 	{
// 		PWM_Init(servos[i], 50);
// 	}
// }
//
// void loop(void)
// {
// 	for (int i =0; i < 5; i++)
// 	{
// 		PWM_Position(servos[i], 18000);
// 		SysTick_WaitSeconds(1);
// 	}
// 	for (int i = 4; i >= 0; i--)
// 	{
// 		PWM_Position(servos[i], 19000);
// 		SysTick_WaitSeconds(1);
// 	}
// }
