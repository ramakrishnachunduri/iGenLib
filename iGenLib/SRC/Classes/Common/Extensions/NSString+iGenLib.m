#import "NSString+iGenLib.h"
#import "NSArray+GeneralExtensions.h"
#import "NSBundle+GeneralExtensions.h"

@implementation NSString (iGenLib)

#pragma mark String Search methods

- (BOOL)isAnyOf:(NSString *)strings
{
	for(NSString *str in [strings componentsSeparatedByString:@","])
	{
		if([self isEqualToString:str])
			return YES;
	}
	return NO;
}

-(BOOL)containsString:(NSString *)string
{
	//Returns whether targeted string contains a selected string
	NSRange textRange =[[self lowercaseString] rangeOfString:[string lowercaseString]];
	return (textRange.location != NSNotFound);
}

-(BOOL)containsAnyOf:(NSString *)strings
{
	for(NSString *str in [strings componentsSeparatedByString:@","])
	{
		if([self containsString:str])
			return YES;
	}
	return NO;
}

-(BOOL)isEmptyString
{
	return [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""];
}

-(NSString*)replaceOccurencesOfKeysWithObjects:(NSDictionary*)dictionary
{
	NSMutableString *str=[NSMutableString stringWithString:self];
	for(NSString *key in [dictionary allKeys])
	{
		NSString *obj=[dictionary objectForKey:key];
		[str replaceOccurrencesOfString:key withString:obj options:NSLiteralSearch
								  range:NSMakeRange(0, str.length)];
	}
	return [NSString stringWithString:str];
}

#pragma mark -
#pragma mark String Format methods

-(NSString*)doubleQuotedString
{
	return [NSString stringWithFormat:@"%@%@%@",@"\"",self,@"\""];
}

-(NSString*)singleQuotedString
{
	return [NSString stringWithFormat:@"%@%@%@",@"'",self,@"'"];
}

-(NSString *)truncateTails:(NSInteger)length
{
	if([self length]>length)
	{
		return [[self substringToIndex:length-3] stringByAppendingString:@".."];
	}
	
	return self;
}

-(NSString *)stringByAddingNewLines:(NSInteger)linelength
{
	NSMutableString *st=[NSMutableString stringWithString:self];
	int c=linelength;
	int ind=0;
	int inc=0;
	for (c=linelength; c<[self length]; c+=linelength)
	{
		ind+=2;
		inc++;
		@try {
			[st insertString:@"\n" atIndex:(linelength*inc)+ind];
		}
		@catch (NSException * e){
			return st ;
		}
	}
	
	return st;
}

-(NSString *)stringByAddingSpaces:(NSInteger)wordlength
{
	NSMutableArray *characters =[[NSMutableArray alloc] initWithCapacity:[self length]];
	for (int i=0; i < [self length]; i++)
	{
		NSString *ichar  =[NSString stringWithFormat:@"%c", [self characterAtIndex:i]];
		if(i%wordlength==0)
		{
			[characters addObject:@" "];
		}
		[characters addObject:ichar];
	}
	NSString *retString=[characters componentsJoinedByString:@""];
	
	[characters release];
	
	return retString;
}

-(NSString *)stringByAddingHTMLBreaks:(NSInteger)linelength
{
	NSMutableString *st=[NSMutableString stringWithString:self];
	NSInteger c=linelength;
	int ind=0;
	int inc=0;
	for (c=linelength; c<[self length]; c+=linelength)
	{
		ind+=2;
		inc++;
		@try {
			[st insertString:@"<br/>" atIndex:(linelength*inc)+ind];
		}
		@catch (NSException * e){
			return st ;
		}
	}
	
	return st;
}

#pragma mark -
#pragma mark String Conversion Methods

-(NSDate *)dateWithFormat:(NSString*)dateFormat
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:dateFormat];
	NSDate *retDate=[dateFormatter dateFromString:self];
	[dateFormatter release];
	return retDate;
}

- (NSData*)getUTF8DataRepresentation
{
	NSData* data=[self dataUsingEncoding:NSUTF8StringEncoding];
	return data;
}

#pragma mark -
#pragma mark String Util Methods

-(NSArray*)componentsSeparatedByLength:(NSInteger)length
{
	NSRange range;
	range.location=0;
	range.length=length;
	
	NSMutableArray *splittedarray=[[[NSMutableArray alloc] init] autorelease];
	
	while (range.location!=[self length])
	{
		[splittedarray addObject:[self substringWithRange:range]];
		range.location=range.location+range.length;
	}
	return splittedarray;
}

-(NSString*)getDomainFromURL
{
	if (![self isEqualToString:@""])
	{
		NSString* tempUrlString;
		tempUrlString= self;
		tempUrlString = [tempUrlString stringByReplacingOccurrencesOfString:@"http://" withString:@""];
		tempUrlString = [tempUrlString stringByReplacingOccurrencesOfString:@"http:/" withString:@""];
		tempUrlString=[tempUrlString stringByReplacingOccurrencesOfString:@"http:" withString:@""];
		tempUrlString = [tempUrlString stringByReplacingOccurrencesOfString:@"https://" withString:@""];
		tempUrlString = [tempUrlString stringByReplacingOccurrencesOfString:@"https:/" withString:@""];
		tempUrlString = [tempUrlString stringByReplacingOccurrencesOfString:@"https:" withString:@""];
		
		NSArray* domainArray = [tempUrlString componentsSeparatedByString:@"/"];
		domainArray=[(NSString*)[domainArray objectAtIndex:0] componentsSeparatedByString:@"?"];
		
		tempUrlString=[NSString stringWithFormat:@"%@",[domainArray objectAtIndex:0]];
		
		return tempUrlString;
	}
	return self;
}

-(NSString*)localizedString
{
	return NSLocalizedString(self,@"");
}

-(NSInteger)numberOfLinesInString
{
	//returns how many lines does targeted string has.
	return [[self componentsSeparatedByString:@"\n"] count];
}

-(NSComparisonResult)compareVersionWith:(NSString *)otherVersion
{
	NSScanner *firstScanner = [[NSScanner alloc] initWithString:self];
	NSScanner *secondScanner = [[NSScanner alloc] initWithString:otherVersion];
	NSCharacterSet *charactersToBeSkipped = [[NSCharacterSet
											  characterSetWithCharactersInString:@"1234567890."] invertedSet];
	firstScanner.charactersToBeSkipped = charactersToBeSkipped;
	secondScanner.charactersToBeSkipped = charactersToBeSkipped;
	NSString *firstBuffer, *secondBuffer;
	NSInteger firstValue, secondValue;
	BOOL firstIsAtEnd = [firstScanner isAtEnd];
	BOOL secondIsAtEnd = [secondScanner isAtEnd];
	while (!firstIsAtEnd || !secondIsAtEnd) {
		if (firstIsAtEnd) {
			firstValue = 0;
		}
		else {
			[firstScanner scanUpToString:@"." intoString:&firstBuffer];
			firstValue = firstBuffer.integerValue;
			// Skip the period.
			[firstScanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet]
										 intoString:nil];
		}
		if (secondIsAtEnd) {
			secondValue = 0;
		}
		else {
			[secondScanner scanUpToString:@"." intoString:&secondBuffer];
			secondValue = secondBuffer.integerValue;
			// Skip the full stop.
			[secondScanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet]
										  intoString:nil];
		}
		if (firstValue > secondValue) {
			return NSOrderedDescending;
		}
		else if (firstValue < secondValue) {
			return NSOrderedAscending;
		}
		firstIsAtEnd = [firstScanner isAtEnd];
		secondIsAtEnd = [secondScanner isAtEnd];
	}
	return NSOrderedSame;
}

#pragma mark -
@end