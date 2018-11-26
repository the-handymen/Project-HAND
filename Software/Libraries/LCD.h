#ifndef _LCD_H_
#define _LCD_H_

#include <stdbool.h>
#include <stdint.h>

#include "UART.h"

typedef enum
{
	LCD0_
} LCD_;

void LCD_Init(LCD_ lcd, UART_ uart, uint32_t baud);
void LCD_PrintChar(LCD_ lcd, char c);
unsigned LCD_PrintString(LCD_ lcd, char * s);
unsigned LCD_PrintNumber(LCD_ lcd, uint32_t number);
void LCD_ChangePosition(LCD_ lcd, uint8_t row, uint8_t col);
void LCD_ClearScreen(LCD_ lcd);
void LCD_NextLine(LCD_ lcd);
void LCD_SettingsColor(LCD_ lcd, float r, float g, float b);
void LCD_SettingsContrast(LCD_ lcd, uint8_t c);

#endif
