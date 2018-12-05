
#include "PRNG.h"

static uint32_t state;
static void seed_xorshift32(uint32_t seed)
{
	state = seed;
}
static uint32_t xorshift32()
{
	/* Algorithm "xor" from p. 4 of Marsaglia, "Xorshift RNGs" */
	uint32_t x = state;
	x ^= x << 13;
	x ^= x >> 17;
	x ^= x << 5;
	state = x;
	return x;
}

void PRNG_Seed(uint32_t seed)
{
	seed_xorshift32(seed);
}

uint32_t PRNG_RandomNumber(uint32_t low, uint32_t high)
{
	uint32_t random = xorshift32();
	random %= high - low + 1;
	random += low;
	return random;
}
