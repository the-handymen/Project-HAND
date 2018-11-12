
#include "PWM.h"

#include <tm4c123gh6pm.h>

typedef struct
{
	// Tiva Defined
	uint32_t rcgcpwm;
	uint32_t rcgcgpio;
	uint32_t pins;
	uint32_t pctl;
	uint32_t gen;
	uint32_t en;
	
	GPIOA_Type *        r_gpio;
	volatile uint32_t * r_gen;
	volatile uint32_t * r_load;
	volatile uint32_t * r_cmp;
	volatile uint32_t * r_ctl;
	volatile uint32_t * r_en;
	
	// User Defined
	uint32_t freq;
}
PWM_Data_;

PWM_Data_ PWMs[20] =
{
	                         /*10*/            /*FEDCBA*/        /*76543210*/        /*76543210*/
[M0PWM0_]   = { .rcgcpwm = 0b01, .rcgcgpio = 0b000010, .pins = 0b01000000, .pctl = 0x04000000, .gen = 0x0000008C, .en = 0b00000001, .r_gpio = GPIOB, .r_gen = &PWM0->_0_GENA, .r_load = &PWM0->_0_LOAD, .r_cmp = &PWM0->_0_CMPA, .r_ctl = &PWM0->_0_CTL, .r_en = &PWM0->ENABLE },
[M0PWM1_]   = { .rcgcpwm = 0b01, .rcgcgpio = 0b000010, .pins = 0b10000000, .pctl = 0x40000000, .gen = 0x0000080C, .en = 0b00000010, .r_gpio = GPIOB, .r_gen = &PWM0->_0_GENB, .r_load = &PWM0->_0_LOAD, .r_cmp = &PWM0->_0_CMPB, .r_ctl = &PWM0->_0_CTL, .r_en = &PWM0->ENABLE },
[M0PWM2_]   = { .rcgcpwm = 0b01, .rcgcgpio = 0b000010, .pins = 0b00010000, .pctl = 0x00040000, .gen = 0x0000008C, .en = 0b00000100, .r_gpio = GPIOB, .r_gen = &PWM0->_1_GENA, .r_load = &PWM0->_1_LOAD, .r_cmp = &PWM0->_1_CMPA, .r_ctl = &PWM0->_1_CTL, .r_en = &PWM0->ENABLE },
[M0PWM3_]   = { .rcgcpwm = 0b01, .rcgcgpio = 0b000010, .pins = 0b00100000, .pctl = 0x00400000, .gen = 0x0000080C, .en = 0b00001000, .r_gpio = GPIOB, .r_gen = &PWM0->_1_GENB, .r_load = &PWM0->_1_LOAD, .r_cmp = &PWM0->_1_CMPB, .r_ctl = &PWM0->_1_CTL, .r_en = &PWM0->ENABLE },
[M0PWM4_]   = { .rcgcpwm = 0b01, .rcgcgpio = 0b010000, .pins = 0b00010000, .pctl = 0x00040000, .gen = 0x0000008C, .en = 0b00010000, .r_gpio = GPIOE, .r_gen = &PWM0->_2_GENA, .r_load = &PWM0->_2_LOAD, .r_cmp = &PWM0->_2_CMPA, .r_ctl = &PWM0->_2_CTL, .r_en = &PWM0->ENABLE },
[M0PWM5_]   = { .rcgcpwm = 0b01, .rcgcgpio = 0b010000, .pins = 0b00100000, .pctl = 0x00400000, .gen = 0x0000080C, .en = 0b00100000, .r_gpio = GPIOE, .r_gen = &PWM0->_2_GENB, .r_load = &PWM0->_2_LOAD, .r_cmp = &PWM0->_2_CMPB, .r_ctl = &PWM0->_2_CTL, .r_en = &PWM0->ENABLE },
[M0PWM6_0_] = { .rcgcpwm = 0b01, .rcgcgpio = 0b000100, .pins = 0b00010000, .pctl = 0x00040000, .gen = 0x0000008C, .en = 0b01000000, .r_gpio = GPIOC, .r_gen = &PWM0->_3_GENA, .r_load = &PWM0->_3_LOAD, .r_cmp = &PWM0->_3_CMPA, .r_ctl = &PWM0->_3_CTL, .r_en = &PWM0->ENABLE },
[M0PWM7_0_] = { .rcgcpwm = 0b01, .rcgcgpio = 0b000100, .pins = 0b00100000, .pctl = 0x00400000, .gen = 0x0000080C, .en = 0b10000000, .r_gpio = GPIOC, .r_gen = &PWM0->_3_GENB, .r_load = &PWM0->_3_LOAD, .r_cmp = &PWM0->_3_CMPB, .r_ctl = &PWM0->_3_CTL, .r_en = &PWM0->ENABLE },
[M0PWM6_1_] = { .rcgcpwm = 0b01, .rcgcgpio = 0b001000, .pins = 0b00000001, .pctl = 0x00000004, .gen = 0x0000008C, .en = 0b01000000, .r_gpio = GPIOD, .r_gen = &PWM0->_3_GENA, .r_load = &PWM0->_3_LOAD, .r_cmp = &PWM0->_3_CMPA, .r_ctl = &PWM0->_3_CTL, .r_en = &PWM0->ENABLE },
[M0PWM7_1_] = { .rcgcpwm = 0b01, .rcgcgpio = 0b001000, .pins = 0b00000010, .pctl = 0x00000040, .gen = 0x0000080C, .en = 0b10000000, .r_gpio = GPIOD, .r_gen = &PWM0->_3_GENB, .r_load = &PWM0->_3_LOAD, .r_cmp = &PWM0->_3_CMPB, .r_ctl = &PWM0->_3_CTL, .r_en = &PWM0->ENABLE },
[M1PWM0_]   = { .rcgcpwm = 0b10, .rcgcgpio = 0b001000, .pins = 0b00000001, .pctl = 0x00000005, .gen = 0x0000008C, .en = 0b00000001, .r_gpio = GPIOD, .r_gen = &PWM1->_0_GENA, .r_load = &PWM1->_0_LOAD, .r_cmp = &PWM1->_0_CMPA, .r_ctl = &PWM1->_0_CTL, .r_en = &PWM1->ENABLE },
[M1PWM1_]   = { .rcgcpwm = 0b10, .rcgcgpio = 0b001000, .pins = 0b00000010, .pctl = 0x00000050, .gen = 0x0000080C, .en = 0b00000010, .r_gpio = GPIOD, .r_gen = &PWM1->_0_GENB, .r_load = &PWM1->_0_LOAD, .r_cmp = &PWM1->_0_CMPB, .r_ctl = &PWM1->_0_CTL, .r_en = &PWM1->ENABLE },
[M1PWM2_0_] = { .rcgcpwm = 0b10, .rcgcgpio = 0b000001, .pins = 0b01000000, .pctl = 0x05000000, .gen = 0x0000008C, .en = 0b00000100, .r_gpio = GPIOA, .r_gen = &PWM1->_1_GENA, .r_load = &PWM1->_1_LOAD, .r_cmp = &PWM1->_1_CMPA, .r_ctl = &PWM1->_1_CTL, .r_en = &PWM1->ENABLE },
[M1PWM3_0_] = { .rcgcpwm = 0b10, .rcgcgpio = 0b000001, .pins = 0b10000000, .pctl = 0x50000000, .gen = 0x0000080C, .en = 0b00001000, .r_gpio = GPIOA, .r_gen = &PWM1->_1_GENB, .r_load = &PWM1->_1_LOAD, .r_cmp = &PWM1->_1_CMPB, .r_ctl = &PWM1->_1_CTL, .r_en = &PWM1->ENABLE },
[M1PWM2_1_] = { .rcgcpwm = 0b10, .rcgcgpio = 0b010000, .pins = 0b00010000, .pctl = 0x00050000, .gen = 0x0000008C, .en = 0b00000100, .r_gpio = GPIOE, .r_gen = &PWM1->_1_GENA, .r_load = &PWM1->_1_LOAD, .r_cmp = &PWM1->_1_CMPA, .r_ctl = &PWM1->_1_CTL, .r_en = &PWM1->ENABLE },
[M1PWM3_1_] = { .rcgcpwm = 0b10, .rcgcgpio = 0b010000, .pins = 0b00100000, .pctl = 0x00500000, .gen = 0x0000080C, .en = 0b00001000, .r_gpio = GPIOE, .r_gen = &PWM1->_1_GENB, .r_load = &PWM1->_1_LOAD, .r_cmp = &PWM1->_1_CMPB, .r_ctl = &PWM1->_1_CTL, .r_en = &PWM1->ENABLE },
[M1PWM4_]   = { .rcgcpwm = 0b10, .rcgcgpio = 0b100000, .pins = 0b00000001, .pctl = 0x00000005, .gen = 0x0000008C, .en = 0b00010000, .r_gpio = GPIOF, .r_gen = &PWM1->_2_GENA, .r_load = &PWM1->_2_LOAD, .r_cmp = &PWM1->_2_CMPA, .r_ctl = &PWM1->_2_CTL, .r_en = &PWM1->ENABLE },
[M1PWM5_]   = { .rcgcpwm = 0b10, .rcgcgpio = 0b100000, .pins = 0b00000010, .pctl = 0x00000050, .gen = 0x0000080C, .en = 0b00100000, .r_gpio = GPIOF, .r_gen = &PWM1->_2_GENB, .r_load = &PWM1->_2_LOAD, .r_cmp = &PWM1->_2_CMPB, .r_ctl = &PWM1->_2_CTL, .r_en = &PWM1->ENABLE },
[M1PWM6_]   = { .rcgcpwm = 0b10, .rcgcgpio = 0b100000, .pins = 0b00000100, .pctl = 0x00000500, .gen = 0x0000008C, .en = 0b01000000, .r_gpio = GPIOF, .r_gen = &PWM1->_3_GENA, .r_load = &PWM1->_3_LOAD, .r_cmp = &PWM1->_3_CMPA, .r_ctl = &PWM1->_3_CTL, .r_en = &PWM1->ENABLE },
[M1PWM7_]   = { .rcgcpwm = 0b10, .rcgcgpio = 0b100000, .pins = 0b00001000, .pctl = 0x00005000, .gen = 0x0000080C, .en = 0b10000000, .r_gpio = GPIOF, .r_gen = &PWM1->_3_GENB, .r_load = &PWM1->_3_LOAD, .r_cmp = &PWM1->_3_CMPB, .r_ctl = &PWM1->_3_CTL, .r_en = &PWM1->ENABLE },
};

void PWM_Init(PWM_ pwm, uint32_t freq)
{
	PWMs[pwm].freq = freq;
	
	SYSCTL->RCC &= ~(0x400000);                       // Don't divide system clock.
  SYSCTL->RCC |= (1<<20);                           // Divide PWM clock.
	SYSCTL->RCC &= ~(0xE0000);                        // Clear PWMDIV (for next step).
	SYSCTL->RCC |= (0x60000);                         // Divde PWM clock by 16.
	SYSCTL->RCC |=(0x800);                            // Bypass PLL.

	SYSCTL->RCGCPWM |= PWMs[pwm].rcgcpwm;             // Enable PWM clock.
	SYSCTL->RCGCGPIO |= PWMs[pwm].rcgcgpio;           // Enable GPIO clock.
	for (int i = 0; i < 100; i++);
	PWMs[pwm].r_gpio->AMSEL &= ~(PWMs[pwm].pins);     // Not analog.
	PWMs[pwm].r_gpio->AFSEL |= PWMs[pwm].pins;        // Alternate function.
	PWMs[pwm].r_gpio->DEN |= PWMs[pwm].pins;          // Digital enable.
	PWMs[pwm].r_gpio->PCTL |= PWMs[pwm].pctl;         // GPIO as PWM.
	*PWMs[pwm].r_ctl = 0x0;                           // Clear control.
	*PWMs[pwm].r_gen |= PWMs[pwm].gen;                // Set generator.
	*PWMs[pwm].r_load = (1000000/PWMs[pwm].freq) - 1; // Set load value (assumes 16MHz clock divided by 16).
	*PWMs[pwm].r_ctl |= 0x1;                          // Set control.
	*PWMs[pwm].r_en |= PWMs[pwm].en;                  // Enable PWM.
}

void PWM_Position(PWM_ pwm, uint32_t value)
{
	*PWMs[pwm].r_cmp = value;
}
