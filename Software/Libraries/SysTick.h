
#ifndef _SYSTICK_H_
#define _SYSTICK_H_

#include <stdint.h>

void SysTick_Init(void);
void SysTick_WaitCycles(uint32_t cycles);
void SysTick_WaitMicroseconds(uint32_t us);
void SysTick_WaitMilliseconds(uint32_t ms);
void SysTick_WaitSeconds(uint32_t s);

#endif
