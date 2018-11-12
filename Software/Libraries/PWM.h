
#ifndef _PWM_H_
#define _PWM_H_

#include <stdint.h>

typedef enum
{
	M0PWM0_,   // PB6
	M0PWM1_,   // PB7
	M0PWM2_,   // PB4
	M0PWM3_,   // PB5
	M0PWM4_,   // PE4
	M0PWM5_,   // PE5
	M0PWM6_0_, // PC4
	M0PWM7_0_, // PC5
	M0PWM6_1_, // PD0
	M0PWM7_1_, // PD1
	M1PWM0_,   // PD0
	M1PWM1_,   // PD1
	M1PWM2_0_, // PA6
	M1PWM3_0_, // PA7
	M1PWM2_1_, // PE4
	M1PWM3_1_, // PE5
	M1PWM4_,   // PF0
	M1PWM5_,   // PF1
	M1PWM6_,   // PF2
	M1PWM7_,   // PF3
} PWM_;

void PWM_Init(PWM_ pwm, uint32_t freq);
void PWM_Position(PWM_ pwm, uint32_t value);


#endif
