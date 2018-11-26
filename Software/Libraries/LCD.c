
#include "LCD.h"

#include "UART.h"

typedef struct
{
	// User Defined.
	UART_ uart;
} LCD_Data_;

#define LCD_ENTER_SETTINGS           0x7C
#define LCD_CONTRAST_SETTING         0x18
#define LCD_CLEAR_SETTING            0x2D
#define LCD_POSITION_ENTER           254
#define LCD_POSITION_OFFSET          128
#define LCD_POSITION_LINE_MULTIPLIER 64

LCD_Data_ LCDs[] = {
[LCD0_] = { }
};

void LCD_Init(LCD_ lcd, UART_ uart, uint32_t baud)
{
	LCDs[lcd].uart = uart;
	UART_Init(LCDs[lcd].uart, false, true, baud);
}

void LCD_PrintChar(LCD_ lcd, char c)
{
	UART_WriteChar(LCDs[lcd].uart, c);
}

unsigned LCD_PrintString(LCD_ lcd, char * s)
{
	unsigned i = 0;
	for (; s[i] != '\0'; i++)
	{
		switch (s[i])
		{
			case '\n': LCD_NextLine(lcd);
								 break;
			default:   LCD_PrintChar(lcd, s[i]);
		}
	}
	return i;
}

unsigned LCD_PrintNumber(LCD_ lcd, uint32_t number)
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
    LCD_PrintChar(lcd, digit + '0');
  }
	
	return digits;
}

void LCD_ChangePosition(LCD_ lcd, uint8_t row, uint8_t col)
{
	UART_WriteChar(LCDs[lcd].uart, LCD_POSITION_ENTER);
	UART_WriteChar(LCDs[lcd].uart, LCD_POSITION_OFFSET + col + row*LCD_POSITION_LINE_MULTIPLIER);
}

void LCD_ClearScreen(LCD_ lcd)
{
	UART_WriteChar(LCDs[lcd].uart, LCD_ENTER_SETTINGS);
	UART_WriteChar(LCDs[lcd].uart, LCD_CLEAR_SETTING);
}

void LCD_NextLine(LCD_ lcd)
{
	LCD_PrintChar(lcd, '\r');
}

static uint8_t SettingsColor_PercentageToData(float p)
{
	return 29 * p / 100;
}

void LCD_SettingsColor(LCD_ lcd, float r, float g, float b)
{
	UART_WriteChar(LCDs[lcd].uart, LCD_ENTER_SETTINGS);
	UART_WriteChar(LCDs[lcd].uart, 128 + SettingsColor_PercentageToData(r));
	UART_WriteChar(LCDs[lcd].uart, LCD_ENTER_SETTINGS);
	UART_WriteChar(LCDs[lcd].uart, 158 + SettingsColor_PercentageToData(g));
	UART_WriteChar(LCDs[lcd].uart, LCD_ENTER_SETTINGS);
	UART_WriteChar(LCDs[lcd].uart, 188 + SettingsColor_PercentageToData(b));
}

static uint8_t SettingsContrast_PercentageToData(float p)
{
	return 255 * p / 100;
}

void LCD_SettingsContrast(LCD_ lcd, uint8_t c)
{
	UART_WriteChar(LCDs[lcd].uart, LCD_ENTER_SETTINGS);
	UART_WriteChar(LCDs[lcd].uart, LCD_CONTRAST_SETTING);
	UART_WriteChar(LCDs[lcd].uart, SettingsContrast_PercentageToData(c));
}
