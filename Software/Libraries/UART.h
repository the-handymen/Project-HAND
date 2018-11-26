
#ifndef _UART_H_
#define _UART_H_

#include <stdint.h>
#include <stdbool.h>

typedef enum
{         // Rx   Tx
	UART0_, // PA0  PA1
	UART1_, // PB0  PB1
	UART2_, // PD6  PD7
	UART3_, // PC6  PC7
	UART4_, // PC4  PC5
	UART5_, // PE4  PE5
	UART6_, // PD4  PD5
	UART7_  // PE0  PE1
} UART_;

void UART_Init(UART_ uart, bool rx, bool tx, uint32_t baud);
void UART_WriteChar(UART_ uart, char c);
char UART_ReadChar(UART_ uart);
void UART_ClearFIFO(UART_ uart);

#endif
