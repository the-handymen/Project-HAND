
#ifndef _ADC_H_
#define _ADC_H_

#include <stdint.h>

void ADC_Init(uint32_t * channels, int count);
void ADC_Read(void);

#endif
