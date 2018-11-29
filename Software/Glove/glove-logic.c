
#include "../Libraries/ADC.h"
#include "../Libraries/SysTick.h"
#include "../Libraries/UART.h"
#include "../Libraries/LCD.h"


typedef uint8_t byte;

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
		UART_WriteChar(UART3_, frame[i]);
	}
}


void setup(void)
{
	ADC_Init(raw, 5);
	SysTick_Init();
	UART_Init(UART3_, false, true, 9600);
}

void loop(void)
{
	ADC_Read();
	Glove_RawToFrameableData(raw, data, 5);
	Frame_Pack(frame, data, 5);
	Frame_Send(frame, 5);
}
