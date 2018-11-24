
#include "../Libraries/ADC.h"

uint32_t fingers[5] = {};

void setup(void)
{
	ADC_Init(fingers, 5);
}

void loop(void)
{
	ADC_Read();
}
