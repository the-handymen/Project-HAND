
#include "QEI.h"

#include <tm4c123gh6pm.h>

typedef struct
{
	// Tiva Defined
	uint32_t rcgcqei;
	uint32_t rcgcgpio;
	uint32_t pins;
	uint32_t pctl;
	// User Defined
	uint32_t ticks_per_rev;
	uint32_t grays_per_tick;
}
QEI_Data_;

QEI_Data_ QEIs[] =
{                                            /*FEDCBA*/
/* QEI0_0_ */ { .rcgcqei = 0b01, .rcgcgpio = 0b001000, .pins = 0b11000000, .pctl = 0x66000000 },
/* QEI0_1_ */ { .rcgcqei = 0b01, .rcgcgpio = 0b100000, .pins = 0b00000011, .pctl = 0x00000066 },
/* QEI1_   */ { .rcgcqei = 0b10, .rcgcgpio = 0b000100, .pins = 0b01100000, .pctl = 0x06600000 },
};

void QEI_Init(QEI_ qei, uint32_t ticks_per_rev, uint32_t grays_per_tick)
{
	QEIs[qei].ticks_per_rev = ticks_per_rev;
	QEIs[qei].grays_per_tick = grays_per_tick;
	
	SYSCTL->RCGCQEI  |= QEIs[qei].rcgcqei;                   /*clock gating control on QEI module 1 (set bit 1)*/
	SYSCTL->RCGCGPIO |= QEIs[qei].rcgcgpio;                  /*clock gating control on PortC (set bit 2)*/
	// TODO: Wait for RCGCGPIO to set.
	// TODO: Un-hardcode useage og GPIOC and QEI1 to enable use of other modules.
	GPIOC->AMSEL     &= ~QEIs[qei].pins;                     /*disable analog functions on PC5-6 (clear bits 5-6)*/
	GPIOC->AFSEL     |= QEIs[qei].pins;                      /*enable alternate functions on PC5-6 (set bits 5-6)*/
	GPIOC->PCTL      |= QEIs[qei].pctl;                      /*select PhA1 and PhB1 functions on PC5 and PC6 respectively (write value of 6 to PMC5-6)*/
	GPIOC->DEN 			 |= QEIs[qei].pins;                      /*enable digital functions on PC5-6 (set bits 5-6)*/
	QEI1->CTL        |= 0x8;                                 /*set CAPMODE bit of QEICTL register for quadrature encoding (set bit 3)*/
	QEI1->MAXPOS     = ticks_per_rev * grays_per_tick - 1;   /*set MAXPOS value to 24*4-1, for 4 edges per 24 lines*/
	QEI1->CTL        |= 1;                                   /*enable QEI 1 module (set bit 1)*/
}

uint32_t QEI_Position(QEI_ qei)
{
	return QEI1->POS / QEIs[qei].grays_per_tick;
}
