
#include "SysTick.h"

#include <tm4c123gh6pm.h>

#define Bit(b) ( 1U<<b )

#define TICKS_PER_S (16000000)
#define TICKS_PER_MS (TICKS_PER_S / 1000)
#define TICKS_PER_US (TICKS_PER_S / 1000000)

void SysTick_Init(void)
{
	SYSCTL->RCC &= ~(0x400000); // Don't divide system clock.

	SysTick->CTRL &= ~(Bit(16)|Bit(1)|Bit(0));
	SysTick->CTRL |= Bit(2);
}

// Max 16,777,215.
void SysTick_WaitCycles(uint32_t cycles)
{
	SysTick->CTRL &= ~(Bit(16)|Bit(0));
	SysTick->LOAD = cycles - 1;
	SysTick->VAL = 0;
	SysTick->CTRL |= Bit(0);
	while ((SysTick->CTRL & Bit(16)) == 0);
}

// Use for times less than a second.
void SysTick_WaitMicroseconds(uint32_t us)
{
	SysTick_WaitCycles(us * TICKS_PER_US);
}

// Use for times less than a second.
void SysTick_WaitMilliseconds(uint32_t ms)
{
	SysTick_WaitCycles(ms * TICKS_PER_MS);
}

void SysTick_WaitSeconds(uint32_t s)
{
	for (int i = 0; i < s; i++)
	{
		SysTick_WaitCycles(16000000);
	}
}
