
#include "../Libraries/ADC.h"
#include "../Libraries/SysTick.h"
#include "../Libraries/UART.h"

//#include <tm4c123gh6pm.h>

#define lcd

#ifdef adc
typedef uint8_t byte;

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

uint32_t fingers_raw[5] = {0};
byte fingers_frame[1 + 5] = {0};
#endif

void setup(void)
{
#ifdef adc
	ADC_Init(fingers_raw, 5);
#endif

#ifdef uart
	SysTick_Init();
	UART_Init();
#endif

#ifdef lcd
	SysTick_Init();
	UART_Init();
#endif
}

void loop(void)
{
#ifdef adc
	ADC_Read();
	Glove_Frame(fingers_frame, fingers_raw, 5);
#endif

#ifdef uart
	for (char c = 'A'; c <= 'Z'; c++)
	{
		SysTick_WaitSeconds(1);
		UART_WriteChar(c);
	}
#endif

#ifdef lcd
	
#endif
}
