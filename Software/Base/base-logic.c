
#include "../Libraries/QEI.h"
#include "../Libraries/PWM.h"

#include <tm4c123gh6pm.h>

#define TEST_PWM

#define Bit(b) ( 1U<<b )

void setup(void)
{
#ifdef TEST_QEI
	QEI_Init(QEI1_, 24, 4);
#endif
	
#ifdef TEST_PWM
	PWM_Init(M1PWM0_, 50);
	PWM_Init(M0PWM2_, 50);
	PWM_Init(M0PWM0_, 50);
	
#endif
}

void loop(void)
{
#ifdef TEST_QEI
	volatile unsigned value = QEI_Position(QEI1_);
#endif
	
#ifdef TEST_PWM
	while(1)
	{
	for(int i = 0; i < 100; i++)
  {
	PWM_Position(M1PWM0_, 18000 + i * 10);
	PWM_Position(M0PWM0_, 18000 + i * 5);
	PWM_Position(M0PWM2_, 18000 + i * 1);
		for(int j = 0; j < 25000; j++); //delay
	}
	for(int k = 0; k < 100; k++)
	{
	PWM_Position(M1PWM0_, 19000 - k * 10);
	PWM_Position(M0PWM0_, 18500 - k * 5);
	PWM_Position(M0PWM2_, 18100 - k * 1);
		for(int j = 0; j < 25000; j++); //delay
	}
 }
#endif
}
