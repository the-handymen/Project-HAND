
#include "UART.h"

#include <tm4c123gh6pm.h>

typedef struct
{
	// Tiva Defined
	UART0_Type * r_uart;
	uint32_t uartbit;
	
	GPIOA_Type * r_gpio;
	uint32_t gpiobit;
	
	uint32_t rx_pin;
	uint32_t rx_pctl;
	uint32_t tx_pin;
	uint32_t tx_pctl;
	
	// User Defined
	uint32_t baud;
} UART_Data_;

UART_Data_ UARTs[] = {
[UART0_] = { .r_uart = UART0, .uartbit = 0b00000001, .r_gpio = GPIOA, .gpiobit = 0b000001, .rx_pin = 0b00000001, .rx_pctl = 0x00000001, .tx_pin = 0b00000010, .tx_pctl = 0x00000010 },
[UART1_] = { .r_uart = UART1, .uartbit = 0b00000010, .r_gpio = GPIOB, .gpiobit = 0b000010, .rx_pin = 0b00000001, .rx_pctl = 0x00000001, .tx_pin = 0b00000010, .tx_pctl = 0x00000010 },
[UART2_] = { .r_uart = UART2, .uartbit = 0b00000100, .r_gpio = GPIOD, .gpiobit = 0b001000, .rx_pin = 0b01000000, .rx_pctl = 0x01000000, .tx_pin = 0b10000000, .tx_pctl = 0x10000000 },
[UART3_] = { .r_uart = UART3, .uartbit = 0b00001000, .r_gpio = GPIOC, .gpiobit = 0b000100, .rx_pin = 0b01000000, .rx_pctl = 0x01000000, .tx_pin = 0b10000000, .tx_pctl = 0x10000000 },
[UART4_] = { .r_uart = UART4, .uartbit = 0b00010000, .r_gpio = GPIOC, .gpiobit = 0b000100, .rx_pin = 0b00010000, .rx_pctl = 0x00010000, .tx_pin = 0b00100000, .tx_pctl = 0x00100000 },
[UART5_] = { .r_uart = UART5, .uartbit = 0b00100000, .r_gpio = GPIOE, .gpiobit = 0b010000, .rx_pin = 0b00010000, .rx_pctl = 0x00010000, .tx_pin = 0b00100000, .tx_pctl = 0x00100000 },
[UART6_] = { .r_uart = UART6, .uartbit = 0b01000000, .r_gpio = GPIOD, .gpiobit = 0b001000, .rx_pin = 0b00010000, .rx_pctl = 0x00010000, .tx_pin = 0b00100000, .tx_pctl = 0x00100000 },
[UART7_] = { .r_uart = UART7, .uartbit = 0b10000000, .r_gpio = GPIOE, .gpiobit = 0b010000, .rx_pin = 0b00000001, .rx_pctl = 0x00000001, .tx_pin = 0b00000010, .tx_pctl = 0x00000010 }
};

void UART_Init(UART_ uart, bool rx, bool tx, uint32_t baud)
{
	UARTs[uart].baud = baud;
	
	SYSCTL->RCC &= ~(0x400000); // Don't divide system clock.
	SYSCTL->RCC |=(0x800);      // Bypass PLL.
	
	SYSCTL->RCGCUART |= UARTs[uart].uartbit;
	while ((SYSCTL->PRUART & UARTs[uart].uartbit) == 0);
	SYSCTL->RCGCGPIO |= UARTs[uart].gpiobit;
	while ((SYSCTL->PRGPIO & UARTs[uart].gpiobit) == 0);
	
	if ((UARTs[uart].r_gpio == GPIOD) && (UARTs[uart].tx_pin == 0b10000000))
	{
		GPIOD->LOCK = 0x4C4F434B;
		GPIOD->CR |= 0xFF;
	}
	
	if (rx)
	{
		UARTs[uart].r_gpio->AMSEL &= ~UARTs[uart].rx_pin;
		UARTs[uart].r_gpio->DIR   &= ~UARTs[uart].rx_pin;
		UARTs[uart].r_gpio->DEN   |= UARTs[uart].rx_pin;
		UARTs[uart].r_gpio->AFSEL |= UARTs[uart].rx_pin;
		UARTs[uart].r_gpio->PCTL  |= UARTs[uart].rx_pctl;
	}
	
	if (tx)
	{
		UARTs[uart].r_gpio->AMSEL &= ~UARTs[uart].tx_pin;
		UARTs[uart].r_gpio->DIR   |= UARTs[uart].tx_pin;
		UARTs[uart].r_gpio->DEN   |= UARTs[uart].tx_pin;
		UARTs[uart].r_gpio->AFSEL |= UARTs[uart].tx_pin;
		UARTs[uart].r_gpio->PCTL  |= UARTs[uart].tx_pctl;
	}
	
	UARTs[uart].r_uart->CTL  &= ~0b1;
	UARTs[uart].r_uart->IBRD  = (int)(16000000.0/(16*UARTs[uart].baud)); // int(clock/(16*baud))
	UARTs[uart].r_uart->FBRD  = (((16000000.0/(16*UARTs[uart].baud)) - (int)(16000000.0/(16*UARTs[uart].baud))))*64 + 0.5;  // int[[clock/(16*baud) - int(clock/(16*baud))]*64 +0.5]
	UARTs[uart].r_uart->LCRH &= ~0xFF;
	UARTs[uart].r_uart->LCRH |= 0b01100000|0b00010000;
	UARTs[uart].r_uart->CC   &= ~0b1111;
	if (rx) { UARTs[uart].r_uart->CTL |= 0x200; }
	if (tx) { UARTs[uart].r_uart->CTL |= 0x100; }
	UARTs[uart].r_uart->CTL  |= 0b1;
}

void UART_WriteChar(UART_ uart, char c)
{
	while ((UARTs[uart].r_uart->FR&0x20) != 0);
	UARTs[uart].r_uart->DR = c;
}

char UART_ReadChar(UART_ uart)
{
	while((UARTs[uart].r_uart->FR&0x10) != 0);
  return((char)(UARTs[uart].r_uart->DR&0xFF));
}
