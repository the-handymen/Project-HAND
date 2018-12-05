
#include "Frame.h"

#include "UART.h"

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
	
	///////////////////////////////////////////////////////////////////////////////
	data[4] = data[3];
}
