
#include "../Libraries/ADC.h"
#include "../Libraries/SysTick.h"
#include "../Libraries/UART.h"
#include "../Libraries/LCD.h"

//#include <tm4c123gh6pm.h>

typedef uint8_t byte;

unsigned ByteToPercent(byte b)
{
	return 100.0 / 255.0 * b;
}

// Converts raw ADC value into a byte of data.
// In the meantime, this will simply take the upper 2 nibbles of raw data.
byte Glove_RawToByte(uint32_t raw)
{
	return raw>>4;
}

void Glove_Frame(byte * frame, uint32_t * raw, int count)
{
	frame[0] = 0xDA; // Frame header.
	for (int i = 0; i < count; i++)
	{
		frame[1 + i] = Glove_RawToByte(raw[i]);
	}
}

uint32_t raw[5] = {0};
byte frame[1 + 5] = {0};

void setup(void)
{
	ADC_Init(raw, 5);
	SysTick_Init();
	LCD_Init(LCD0_, UART2_, 9600);
	
	LCD_SettingsContrast(LCD0_, 0);
	LCD_SettingsColor(LCD0_, 100,17,86);
	LCD_ClearScreen(LCD0_);
}

void loop(void)
{
	ADC_Read();
	Glove_Frame(frame, raw, 5);

	for (int i = 0; i < 5; i++)
	{
		LCD_PrintChar(LCD0_, i + 'A');
		int n = LCD_PrintNumber(LCD0_, ByteToPercent(frame[1 + i]));
		for (int j = 0; j < 5-n; j++)
		{
			LCD_PrintChar(LCD0_, ' ');
		}
	}
	SysTick_WaitSeconds(1);
	LCD_ClearScreen(LCD0_);
}
