
#ifndef _QEI_H_
#define _QEI_H_

#include <stdint.h>

typedef enum
{
	QEI0_0_ = 0,
	QEI0_1_ = 1,
	QEI1_   = 2
} QEI_;

void QEI_Init(QEI_ qei, uint32_t ticks_per_rev, uint32_t grays_per_tick);
uint32_t QEI_Position(QEI_ qei);

#endif
