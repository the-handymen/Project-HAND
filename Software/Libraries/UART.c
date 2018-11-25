
#include "UART.h"

#include <tm4c123gh6pm.h>

void UART_Init(void)
{
	SYSCTL->RCC &= ~(0x400000); // Don't divide system clock.
	SYSCTL->RCC |=(0x800);      // Bypass PLL.
	
	SYSCTL->RCGCUART |= 0b00100000;
	while ((SYSCTL->PRUART & 0b00100000) == 0);
	SYSCTL->RCGCGPIO |= 0b00010000;
	while ((SYSCTL->PRGPIO & 0b00010000) == 0);
	
	GPIOE->AMSEL &= ~0b00100000;
	GPIOE->DIR |= 0b00100000;
	GPIOE->DEN |= 0b00100000;
	GPIOE->AFSEL |= 0b00100000;
	GPIOE->PCTL |= 0x00100000;
	
	UART5->CTL &= ~0b1;
	UART5->IBRD = 104; // int(clock/(16*baud))
	UART5->FBRD = 11;  // int[[clock/(16*baud) - int(clock/(16*baud))]*64 +0.5]
	UART5->LCRH &= ~0xFF;
	UART5->LCRH |= 0b01100000|0b00010000;
	UART5->CC &= ~0b1111; 
	UART5->CTL |= 0x100;
	UART5->CTL |= 0b1;
}

void UART_WriteChar(char c)
{
	while ((UART5->FR&0x20) != 0);
	UART5->DR = c;
}
