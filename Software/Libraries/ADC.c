
#include "ADC.h"


#include <tm4c123gh6pm.h>

typedef struct
{
	uint32_t * channels;
	int count;
}
ADC_Data_;

ADC_Data_ hardcoded_adc;

void ADC_Init(uint32_t * channels, int count)
{
	hardcoded_adc.channels = channels;
	hardcoded_adc.count = count;
	
	SYSCTL->RCGCADC |= 0x1;              // Activate ADC0.
	while ((SYSCTL->PRADC & 0x1) == 0);
	SYSCTL->RCGCGPIO |= 0x10;            // Activate Port E.
	while ((SYSCTL->PRGPIO & 0x10) == 0);
	SYSCTL->RCGCGPIO |= 0x08;            // Activate Port D.
	while ((SYSCTL->PRGPIO & 0x08) == 0);

	GPIOD->AFSEL |= 0x07;                // Configure PD0-3,PE1 for ADC
	GPIOD->DIR &= ~(0x07);               // "
	GPIOD->DEN &= ~(0x07);               // "
	GPIOD->AMSEL |= 0x07;                // "
	GPIOE->AFSEL |= 0x02;                // "
	GPIOE->DIR &= ~(0x02);               // "
	GPIOE->DEN &= ~(0x02);               // "
	GPIOE->AMSEL |= 0x02;                // "

	ADC0->PC = (ADC0->PC & ~0xF) | 0x01; // 125K Samples per second.
	ADC0->SSPRI = 0x3210;                // Prioritize Sequencer 0.
	ADC0->EMUX &= ~0x000F;             // Software start for Sequencer 0.
	ADC0->PSSI |= 0x1;                   // Initiate conversion on Sequencer 0.
	ADC0->ACTSS &= ~(0x1);               // Disable Sequencer 0 to configure.
	ADC0->SSMUX0 = 0x24567;                    // Hook up ------------- to Sequencer 0.
//	ADC0->SSCTL0 &= ~(0x88);              // Measure pin, not temperature.
//	ADC0->SSCTL0 |= 0x44;                 // So bit is set when measurement is done.
//	ADC0->SSCTL0 &= ~0x02;
//	ADC0->SSCTL0 |= 0x20;
//	ADC0->SSCTL0 &= ~(0x11);              // Don't use differential mode.
	ADC0->SSCTL0 = 0;
	ADC0->SSCTL0 |= 0x20000|0x40000;
	ADC0->ACTSS |= 0x1;                  // Enable Sequencer 0.
}

static void ADC_StartRead(void)
{
	ADC0->PSSI |= 0x1;                // Initiate read.
	while ((ADC0->RIS & 0x1) == 0) {} // Wait for completetion.
}

static uint32_t ADC_ReadOne(void)
{
	return ADC0->SSFIFO0 & 0xFFF; // Mask result.
}

static void ADC_EndRead(void)
{
	ADC0->ISC |= 0x1; // Clear interrupt flag.
}

void ADC_Read()
{
	ADC_StartRead();
	for (int i = 0; i < hardcoded_adc.count; i++)
	{
		hardcoded_adc.channels[i] = ADC_ReadOne();
	}
	ADC_EndRead();
}
