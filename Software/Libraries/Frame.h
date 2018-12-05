
#ifndef _FRAME_H_
#define _FRAME_H_

#include <stdint.h>

typedef uint8_t byte;

void Frame_Recieve(byte * frame, unsigned data_size);
void Frame_Unpack(byte * frame, byte * data, unsigned data_size);

#endif
