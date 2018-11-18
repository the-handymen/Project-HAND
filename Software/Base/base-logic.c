
#include "../Libraries/QEI.h"
#include "../Libraries/PWM.h"

#include <tm4c123gh6pm.h>

#define TEST_PWM

#define Bit(b) ( 1U<<b )

void outchar(char c)
{
	while ((UART5->FR & 0x00000020) != 0);
	UART5->DR = c;
}

PWM_ servos[5] = {M0PWM0_, M0PWM1_, M1PWM4_, M1PWM6_, M0PWM6_0_};

void setup(void)
{
#ifdef TEST_QEI
	QEI_Init(QEI1_, 24, 4);
#endif
	
#ifdef TEST_PWM
//	PWM_Init(M1PWM0_, 50);
//	PWM_Init(M0PWM2_, 50);
	
	
	
	for (int i = 0; i < 5; i++)
	{
		PWM_Init(servos[i], 50);
	}
#endif
	
#ifdef TEST_UART
// PE5, UTx5
	SYSCTL->RCC &= ~(0x400000); // Don't divide system clock.

	SYSCTL->RCGCUART |= Bit(5);
	SYSCTL->RCGCGPIO |= Bit(4);
	while((SYSCTL->PRGPIO&0x01) == 0){}
	GPIOE->AMSEL &= ~0b00110000;
	GPIOE->AFSEL |= 0b00110000;
	GPIOE->PCTL |= (GPIOE->PCTL&0xFF00FFFF)+0x00220000;
	GPIOE->DEN |= 0b00110000;
	
	UART5->CTL &= ~Bit(0);

	UART5->IBRD = 104;
	UART5->FBRD = 11;

	UART5->LCRH = 0b01110000; // FIFO enable, 8-bit data
//	UART5->CC = 0b0000;       // Use normal clock.
	UART5->CTL |= 0x301;
	
#endif
}

void loop(void)
{
#ifdef TEST_QEI
	volatile unsigned value = QEI_Position(QEI1_);
#endif
	
#ifdef TEST_PWM
//	for(int i = 0; i < 100; i++)
//  {
//	PWM_Position(M1PWM0_, 18000 + i * 10);
//	PWM_Position(M0PWM0_, 18000 + i * 5);
//	PWM_Position(M0PWM2_, 18000 + i * 1);
//		for(int j = 0; j < 25000; j++); //delay
//	}
//	for(int k = 0; k < 100; k++)
//	{
//	PWM_Position(M1PWM0_, 19000 - k * 10);
//	PWM_Position(M0PWM0_, 18500 - k * 5);
//	PWM_Position(M0PWM2_, 18100 - k * 1);
//		for(int j = 0; j < 25000; j++); //delay
//	}
	
	for (int i =0; i < 5; i++)
	{
		PWM_Position(servos[i], 18000);
		for (int j = 0; j < 1600000; j++);
	}
	for (int i = 4; i >= 0; i--)
	{
		PWM_Position(servos[i], 19000);
		for (int j = 0; j < 1600000; j++);
	}
#endif
 
#ifdef TEST_UART
outchar('J');
#endif
}
