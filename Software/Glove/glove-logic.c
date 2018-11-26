
#include "../Libraries/ADC.h"
#include "../Libraries/SysTick.h"
#include "../Libraries/UART.h"
#include "../Libraries/LCD.h"

//#include <tm4c123gh6pm.h>

#define TIVA_RX

typedef uint8_t byte;

#ifdef TIVA_TX
uint32_t raw[5] = {0};
byte data[5] = {0};
byte frame[1 + 5] = {0};

// Converts raw ADC value into a byte of data.
// In the meantime, this will simply take the upper 2 nibbles of raw data.
void Glove_RawToFrameableData(uint32_t * raw, byte * data, unsigned data_size)
{
	for (unsigned i = 0; i < data_size; i++)
	{
		data[i] = raw[i]>>4;
	}
}

void Frame_Pack(byte * frame, byte * data, unsigned data_size)
{
	frame[0] = 0xDA; // Frame header.
	for (unsigned i = 0; i < data_size; i++)
	{
		frame[1 + i] = data[i];
	}
}

void Frame_Send(byte * frame, unsigned data_size)
{
	for (unsigned i = 0; i < 1 + data_size; i++)
	{
		UART_WriteChar(UART4_, frame[i]);
	}
}
#endif

#ifdef TIVA_RX
byte frame[1 + 5] = {0};
byte data[5] = {0};

unsigned ByteToPercent(byte b)
{
	return 100.0 / 255.0 * b;
}

void Frame_Recieve(byte * frame, unsigned data_size)
{
	char c;
	do
	{
		c = UART_ReadChar(UART4_);
	}
	while (c != 0xDA);
	frame[0] = c;
	for (int i = 1; i < 1 + data_size; i++)
	{
		frame[i] = UART_ReadChar(UART4_);
	}
}

void Frame_Unpack(byte * frame, byte * data, unsigned data_size)
{
	for (int i = 0; i < data_size; i++)
	{
		data[i] = frame[1 + i];
	}
}
#endif

void setup(void)
{
#ifdef TIVA_TX
	ADC_Init(raw, 5);
	SysTick_Init();
	UART_Init(UART4_, false, true, 9600);
#endif

#ifdef TIVA_RX
	SysTick_Init();
	LCD_Init(LCD0_, UART5_, 9600);
	UART_Init(UART4_, true, false, 9600);
	LCD_ClearScreen(LCD0_);
#endif
}

void loop(void)
{
#ifdef TIVA_TX
	
	ADC_Read();
	Glove_RawToFrameableData(raw, data, 5);
	Frame_Pack(frame, data, 5);
	Frame_Send(frame, 5);
//	SysTick_WaitMilliseconds(100);
#endif

#ifdef TIVA_RX
	Frame_Recieve(frame, 5);
	Frame_Unpack(frame, data, 5);
	for (int i = 0; i < 5; i++)
	{
		LCD_PrintChar(LCD0_, i + 'A');
		int n = LCD_PrintNumber(LCD0_, ByteToPercent(data[i]));
		for (int j = 0; j < 5-n; j++)
		{
			LCD_PrintChar(LCD0_, ' ');
		}
	}
	SysTick_WaitMilliseconds(100);
	UART_ClearFIFO(UART4_);
	LCD_ClearScreen(LCD0_);
	
#endif
}
