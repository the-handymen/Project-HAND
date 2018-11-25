#ifndef _LCD_H_
#define _LCD_H_

#include <stdbool.h>
#include <stdint.h>

void LCD_Init(void);
void LCD_PrintChar(char c);
unsigned LCD_PrintString(char * s);
unsigned LCD_PrintNumber(uint32_t number);
void LCD_ChangePosition(uint8_t row, uint8_t col);
void LCD_ClearScreen(void);
void LCD_NextLine(void);
void LCD_SettingsColor(float r, float g, float b);
void LCD_SettingsContrast(uint8_t c);

#endif
