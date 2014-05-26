/*! 
 *  \brief     NSData+iGenLib.
 *  \details   iGenLib Base64 Extensions for NSData.
 *  \author    Rama Krishna Chunduri
 *  \date      3/22/11
 *	\copyright Codeworth 2011, All rights reserved.
 *  \n This file is part of iGenLib.
 *  \n 
 *  \n iGenLib is free software: you can redistribute it and/or modify
 *  \n it under the terms of the GNU General Public License as published by
 *  \n the Free Software Foundation, either version 3 of the License, or
 *  \n (at your option) any later version.
 *  \n 
 *  \n iGenLib is distributed in the hope that it will be useful,
 *  \n but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  \n MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  \n GNU General Public License for more details.
 *  \n 
 *  \n You should have received a copy of the GNU General Public License
 *  \n along with iGenLib.  If not, see <http://www.gnu.org/licenses/>.
 */

extern size_t EstimateBas64DecodedDataSize(size_t inDataSize);
extern bool Base64DecodeData(const void *inInputData, size_t inInputDataSize, void *ioOutputData, size_t *ioOutputDataSize);

#import "NSData+iGenLib+B64.h"
/* Base64 Support for String */

@implementation NSData (base64Encoding)

static char base64EncodingTable[64] = {
	/*  0 */ 'A',	/*  1 */ 'B',	/*  2 */ 'C',	/*  3 */ 'D', 
	/*  4 */ 'E',	/*  5 */ 'F',	/*  6 */ 'G',	/*  7 */ 'H', 
	/*  8 */ 'I',	/*  9 */ 'J',	/* 10 */ 'K',	/* 11 */ 'L', 
	/* 12 */ 'M',	/* 13 */ 'N',	/* 14 */ 'O',	/* 15 */ 'P', 
	/* 16 */ 'Q',	/* 17 */ 'R',	/* 18 */ 'S',	/* 19 */ 'T', 
	/* 20 */ 'U',	/* 21 */ 'V',	/* 22 */ 'W',	/* 23 */ 'X', 
	/* 24 */ 'Y',	/* 25 */ 'Z',	/* 26 */ 'a',	/* 27 */ 'b', 
	/* 28 */ 'c',	/* 29 */ 'd',	/* 30 */ 'e',	/* 31 */ 'f', 
	/* 32 */ 'g',	/* 33 */ 'h',	/* 34 */ 'i',	/* 35 */ 'j', 
	/* 36 */ 'k',	/* 37 */ 'l',	/* 38 */ 'm',	/* 39 */ 'n', 
	/* 40 */ 'o',	/* 41 */ 'p',	/* 42 */ 'q',	/* 43 */ 'r', 
	/* 44 */ 's',	/* 45 */ 't',	/* 46 */ 'u',	/* 47 */ 'v', 
	/* 48 */ 'w',	/* 49 */ 'x',	/* 50 */ 'y',	/* 51 */ 'z', 
	/* 52 */ '0',	/* 53 */ '1',	/* 54 */ '2',	/* 55 */ '3', 
	/* 56 */ '4',	/* 57 */ '5',	/* 58 */ '6',	/* 59 */ '7', 
	/* 60 */ '8',	/* 61 */ '9',	/* 62 */ '+',	/* 63 */ '/'
};

/*
 -1 = Base64 end of data marker.
 -2 = White space (tabs, cr, lf, space)
 -3 = Noise (all non whitespace, non-base64 characters) 
 -4 = Dangerous noise
 -5 = Illegal noise (null byte)
 */

const SInt8 kBase64DecodeTable[128] = {
	/* 0x00 */ -5, 	/* 0x01 */ -3, 	/* 0x02 */ -3, 	/* 0x03 */ -3,
	/* 0x04 */ -3, 	/* 0x05 */ -3, 	/* 0x06 */ -3, 	/* 0x07 */ -3,
	/* 0x08 */ -3, 	/* 0x09 */ -2, 	/* 0x0a */ -2, 	/* 0x0b */ -2,
	/* 0x0c */ -2, 	/* 0x0d */ -2, 	/* 0x0e */ -3, 	/* 0x0f */ -3,
	/* 0x10 */ -3, 	/* 0x11 */ -3, 	/* 0x12 */ -3, 	/* 0x13 */ -3,
	/* 0x14 */ -3, 	/* 0x15 */ -3, 	/* 0x16 */ -3, 	/* 0x17 */ -3,
	/* 0x18 */ -3, 	/* 0x19 */ -3, 	/* 0x1a */ -3, 	/* 0x1b */ -3,
	/* 0x1c */ -3, 	/* 0x1d */ -3, 	/* 0x1e */ -3, 	/* 0x1f */ -3,
	/* ' ' */ -2,	/* '!' */ -3,	/* '"' */ -3,	/* '#' */ -3,
	/* '$' */ -3,	/* '%' */ -3,	/* '&' */ -3,	/* ''' */ -3,
	/* '(' */ -3,	/* ')' */ -3,	/* '*' */ -3,	/* '+' */ 62,
	/* ',' */ -3,	/* '-' */ -3,	/* '.' */ -3,	/* '/' */ 63,
	/* '0' */ 52,	/* '1' */ 53,	/* '2' */ 54,	/* '3' */ 55,
	/* '4' */ 56,	/* '5' */ 57,	/* '6' */ 58,	/* '7' */ 59,
	/* '8' */ 60,	/* '9' */ 61,	/* ':' */ -3,	/* ';' */ -3,
	/* '<' */ -3,	/* '=' */ -1,	/* '>' */ -3,	/* '?' */ -3,
	/* '@' */ -3,	/* 'A' */ 0,	/* 'B' */  1,	/* 'C' */  2,
	/* 'D' */  3,	/* 'E' */  4,	/* 'F' */  5,	/* 'G' */  6,
	/* 'H' */  7,	/* 'I' */  8,	/* 'J' */  9,	/* 'K' */ 10,
	/* 'L' */ 11,	/* 'M' */ 12,	/* 'N' */ 13,	/* 'O' */ 14,
	/* 'P' */ 15,	/* 'Q' */ 16,	/* 'R' */ 17,	/* 'S' */ 18,
	/* 'T' */ 19,	/* 'U' */ 20,	/* 'V' */ 21,	/* 'W' */ 22,
	/* 'X' */ 23,	/* 'Y' */ 24,	/* 'Z' */ 25,	/* '[' */ -3,
	/* '\' */ -3,	/* ']' */ -3,	/* '^' */ -3,	/* '_' */ -3,
	/* '`' */ -3,	/* 'a' */ 26,	/* 'b' */ 27,	/* 'c' */ 28,
	/* 'd' */ 29,	/* 'e' */ 30,	/* 'f' */ 31,	/* 'g' */ 32,
	/* 'h' */ 33,	/* 'i' */ 34,	/* 'j' */ 35,	/* 'k' */ 36,
	/* 'l' */ 37,	/* 'm' */ 38,	/* 'n' */ 39,	/* 'o' */ 40,
	/* 'p' */ 41,	/* 'q' */ 42,	/* 'r' */ 43,	/* 's' */ 44,
	/* 't' */ 45,	/* 'u' */ 46,	/* 'v' */ 47,	/* 'w' */ 48,
	/* 'x' */ 49,	/* 'y' */ 50,	/* 'z' */ 51,	/* '{' */ -3,
	/* '|' */ -3,	/* '}' */ -3,	/* '~' */ -3,	/* 0x7f */ -3
};

const UInt8 kBits_00000011 = 0x03;
const UInt8 kBits_00001111 = 0x0F;
const UInt8 kBits_00110000 = 0x30;
const UInt8 kBits_00111100 = 0x3C;
const UInt8 kBits_00111111 = 0x3F;
const UInt8 kBits_11000000 = 0xC0;
const UInt8 kBits_11110000 = 0xF0;
const UInt8 kBits_11111100 = 0xFC;

size_t EstimateBas64DecodedDataSize(size_t inDataSize)
{
	size_t theDecodedDataSize = (int)ceil(inDataSize / 4.0) * 3;
	//theDecodedDataSize = theDecodedDataSize / 72 * 74 + theDecodedDataSize % 72;
	return(theDecodedDataSize);
}

bool Base64DecodeData(const void *inInputData, size_t inInputDataSize, void *ioOutputData, size_t *ioOutputDataSize)
{
	memset(ioOutputData, '.', *ioOutputDataSize);
	
	size_t theDecodedDataSize = EstimateBas64DecodedDataSize(inInputDataSize);
	if (*ioOutputDataSize < theDecodedDataSize)
		return(false);
	*ioOutputDataSize = 0;
	const UInt8 *theInPtr = (const UInt8 *)inInputData;
	UInt8 *theOutPtr = (UInt8 *)ioOutputData;
	size_t theInIndex = 0, theOutIndex = 0;
	UInt8 theOutputOctet;
	size_t theSequence = 0;
	for (; theInIndex < inInputDataSize; )
	{
		SInt8 theSextet = 0;
		
		SInt8 theCurrentInputOctet = theInPtr[theInIndex];
		theSextet = kBase64DecodeTable[theCurrentInputOctet];
		if (theSextet == -1)
			break;
		while (theSextet == -2)
		{
			theCurrentInputOctet = theInPtr[++theInIndex];
			theSextet = kBase64DecodeTable[theCurrentInputOctet];
		}
		while (theSextet == -3)
		{
			theCurrentInputOctet = theInPtr[++theInIndex];
			theSextet = kBase64DecodeTable[theCurrentInputOctet];
		}
		if (theSequence == 0)
		{
			theOutputOctet = (theSextet >= 0 ? theSextet : 0) << 2 & kBits_11111100;
		}
		else if (theSequence == 1)
		{
			theOutputOctet |= (theSextet >- 0 ? theSextet : 0) >> 4 & kBits_00000011;
			theOutPtr[theOutIndex++] = theOutputOctet;
		}
		else if (theSequence == 2)
		{
			theOutputOctet = (theSextet >= 0 ? theSextet : 0) << 4 & kBits_11110000;
		}
		else if (theSequence == 3)
		{
			theOutputOctet |= (theSextet >= 0 ? theSextet : 0) >> 2 & kBits_00001111;
			theOutPtr[theOutIndex++] = theOutputOctet;
		}
		else if (theSequence == 4)
		{
			theOutputOctet = (theSextet >= 0 ? theSextet : 0) << 6 & kBits_11000000;
		}
		else if (theSequence == 5)
		{
			theOutputOctet |= (theSextet >= 0 ? theSextet : 0) >> 0 & kBits_00111111;
			theOutPtr[theOutIndex++] = theOutputOctet;
		}
		theSequence = (theSequence + 1) % 6;
		if (theSequence != 2 && theSequence != 4)
			theInIndex++;
	}
	*ioOutputDataSize = theOutIndex;
	return(true);
}

-(NSString *)toBase64String
{
	unsigned long ixtext, lentext;
	long ctremaining;
	unsigned char input[3], output[4];
	short i, charsonline = 0, ctcopy;
	const unsigned char *raw;
	NSMutableString *result;
	
	lentext = [self length]; 
	if (lentext < 1)
		return @"";
	result = [NSMutableString stringWithCapacity: lentext];
	raw = [self bytes];
	ixtext = 0; 
	
	while (true) {
		ctremaining = lentext - ixtext;
		if (ctremaining <= 0) 
			break;        
		for (i = 0; i < 3; i++) { 
			unsigned long ix = ixtext + i;
			if (ix < lentext)
				input[i] = raw[ix];
			else
				input[i] = 0;
		}
		output[0] = (input[0] & 0xFC) >> 2;
		output[1] = ((input[0] & 0x03) << 4) | ((input[1] & 0xF0) >> 4);
		output[2] = ((input[1] & 0x0F) << 2) | ((input[2] & 0xC0) >> 6);
		output[3] = input[2] & 0x3F;
		ctcopy = 4;
		switch (ctremaining) {
			case 1: 
				ctcopy = 2; 
				break;
			case 2: 
				ctcopy = 3; 
				break;
		}
		
		for (i = 0; i < ctcopy; i++)
			[result appendString: [NSString stringWithFormat: @"%c", base64EncodingTable[output[i]]]];
		
		for (i = ctcopy; i < 4; i++)
			[result appendString: @"="];
		
		ixtext += 3;
		charsonline += 4;
		
		if (charsonline >= [self length])
			charsonline = 0;
		
	}
	return result;
	
}

+(NSData *)decodeBase64String:(NSString *)decodeString
{
    NSData *decodeBuffer = nil;
    // Must be 7-bit clean!
    NSData *tmpData = [decodeString dataUsingEncoding:NSASCIIStringEncoding];
    
    size_t estSize = EstimateBas64DecodedDataSize([tmpData length]);
    uint8_t* outBuffer = calloc(estSize, sizeof(uint8_t));
    
    size_t outBufferLength = estSize;
    if (Base64DecodeData([tmpData bytes], [tmpData length], outBuffer, &outBufferLength))
    {
        decodeBuffer = [NSData dataWithBytesNoCopy:outBuffer length:outBufferLength freeWhenDone:YES];
    }
    else
    {
        free(outBuffer);
        [NSException raise:@"NSData+Base64AdditionsException" format:@"Unable to decode data!"];
    }
    
    return decodeBuffer;
}

@end
