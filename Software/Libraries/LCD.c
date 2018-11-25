
#include "LCD.h"

#include "UART.h"

#define LCD_ENTER_SETTINGS           0x7C
#define LCD_CONTRAST_SETTING         0x18
#define LCD_CLEAR_SETTING            0x2D
#define LCD_POSITION_ENTER           254
#define LCD_POSITION_OFFSET          128
#define LCD_POSITION_LINE_MULTIPLIER 64

void LCD_Init(void)
{
	UART_Init();
}

void LCD_PrintChar(char c)
{
	UART_WriteChar(c);
}

unsigned LCD_PrintString(char * s)
{
	unsigned i = 0;
	for (; s[i] != '\0'; i++)
	{
		switch (s[i])
		{
			case '\n': LCD_NextLine();
								 break;
			default:   LCD_PrintChar(s[i]);
		}
	}
	return i;
}

unsigned LCD_PrintNumber(uint32_t number)
{
	unsigned digits = 1;
	uint32_t magnitude = 1;

	// Calculate magnitude. (i.e. value of largest digit's place).
  while (number / magnitude >= 10)
  {
		++digits;
    magnitude *= 10;
  }

  // Print each digit in given base.
  for (; magnitude > 0; magnitude /= 10)
  {
    uint32_t digit = number / magnitude;
    number -= digit * magnitude;
    LCD_PrintChar(digit + '0');
  }
	
	return digits;
}

void LCD_ChangePosition(uint8_t row, uint8_t col)
{
	UART_WriteChar(LCD_POSITION_ENTER);
	UART_WriteChar(LCD_POSITION_OFFSET + col + row*LCD_POSITION_LINE_MULTIPLIER);
}

void LCD_ClearScreen(void)
{
	UART_WriteChar(LCD_ENTER_SETTINGS);
	UART_WriteChar(LCD_CLEAR_SETTING);
}

void LCD_NextLine(void)
{
	LCD_PrintChar('\r');
}

static uint8_t SettingsColor_PercentageToData(float p)
{
	return 29 * p / 100;
}

void LCD_SettingsColor(float r, float g, float b)
{
	UART_WriteChar(LCD_ENTER_SETTINGS);
	UART_WriteChar(128 + SettingsColor_PercentageToData(r));
	UART_WriteChar(LCD_ENTER_SETTINGS);
	UART_WriteChar(158 + SettingsColor_PercentageToData(g));
	UART_WriteChar(LCD_ENTER_SETTINGS);
	UART_WriteChar(188 + SettingsColor_PercentageToData(b));
}

static uint8_t SettingsContrast_PercentageToData(float p)
{
	return 255 * p / 100;
}

void LCD_SettingsContrast(uint8_t c)
{
	UART_WriteChar(LCD_ENTER_SETTINGS);
	UART_WriteChar(LCD_CONTRAST_SETTING);
	UART_WriteChar(SettingsContrast_PercentageToData(c));
}
