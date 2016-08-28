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

#pragma mark -
@end