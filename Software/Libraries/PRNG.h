
#ifndef _PRNG_H_
#define _PRNG_H_

#include <stdint.h>

void PRNG_Seed(uint32_t seed);
uint32_t PRNG_RandomNumber(uint32_t low, uint32_t high);

#endif
