
#include "../Libraries/QEI.h"
#include "../Libraries/PWM.h"
#include "../Libraries/SysTick.h"

#include <tm4c123gh6pm.h>

#define TEST_PWM

#define Bit(b) ( 1U<<b )


PWM_ servos[5] = {M0PWM0_, M0PWM1_, M1PWM4_, M1PWM6_, M0PWM6_0_};

void setup(void)
{
#ifdef TEST_QEI
	QEI_Init(QEI1_, 24, 4);
#endif
	
#ifdef TEST_PWM
	SysTick_Init();
	for (int i = 0; i < 5; i++)
	{
		PWM_Init(servos[i], 50);
	}
#endif
	
#ifdef TEST_ADC
#endif
}

void loop(void)
{
#ifdef TEST_QEI
	volatile unsigned value = QEI_Position(QEI1_);
#endif
	
#ifdef TEST_PWM
	for (int i =0; i < 5; i++)
	{
		PWM_Position(servos[i], 18000);
		SysTick_WaitSeconds(1);
	}
	for (int i = 4; i >= 0; i--)
	{
		PWM_Position(servos[i], 19000);
		SysTick_WaitSeconds(1);
	}
#endif
 
#ifdef TEST_ADC
#endif
}
