/*! 
 *  \brief     NSString+iGenLib.
 *  \details   iGenLib Extensions for NSString.
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

#import "NSString+iGenLib.h"
#import "NSArray+GeneralExtensions.h"
#import "NSBundle+GeneralExtensions.h"

@implementation NSString (iGenLib)

#pragma mark String Search methods

/**
 * Checks if the reciever string is equal to either of the strings passed.
 * Useful when sending/recieving multiple objects as comma seperated values instead of seperate entities for each of them. ex: when you are remove 2 friends from the app the server returns the names of friend you recently deleted on the website so that you can iterate among local friends list and remove them.
 * @param strings : single string which has the strings as comma seperated values
 * @return Yes if the reciever matches to either of the passed strings or else it returns no
 */
- (BOOL)isAnyOf:(NSString *)strings
{
	for(NSString *str in [strings componentsSeparatedByString:@","])
	{
		if([self isEqualToString:str])
			return YES;
	}
	return NO;
}

/**
 * Checks if the reciever string contains the passed string.
 * @param string : string which have to be searched for in the reciever string.
 * @return Yes if the reciever contains passed string or else it returns no
 */
-(BOOL)containsString:(NSString *)string
{
	//Returns whether targeted string contains a selected string
	NSRange textRange =[[self lowercaseString] rangeOfString:[string lowercaseString]];
	return (textRange.location != NSNotFound);
}

/**
 * Checks if the reciever string is contains either of the strings passed.
 * Useful when sending/recieving multiple objects as comma seperated values instead of seperate entities for each of them.
 * @param strings : single string which has the strings as comma seperated values
 * @return Yes if the reciever contains either of the passed strings or else it returns no
 */
-(BOOL)containsAnyOf:(NSString *)strings
{
	for(NSString *str in [strings componentsSeparatedByString:@","])
	{
		if([self containsString:str])
			return YES;
	}
	return NO;
}

/**
 * Checks if the reciever string is either empty (can be '' or '|space|space|')
 * @return Yes if the string is empty or it has only spaces in it
 */
-(BOOL)isEmptyString
{
	return [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""];
}

#pragma mark -
#pragma mark String Format methods

/**
 * Ads a double quote in both sides of the strings
 * @return string with double quotes on either side
 */
-(NSString*)doubleQuotedString
{
	return [NSString stringWithFormat:@"%@%@%@",@"\"",self,@"\""];
}

/**
 * Ads a single quote in both sides of the strings
 * @return string with single quotes on either side
 */
-(NSString*)singleQuotedString
{
	return [NSString stringWithFormat:@"%@%@%@",@"'",self,@"'"];
}

/**
 * creates a string which is tailed with ... after passed length.
 * @return a new (autoreleased) String instance with tailing
 * @return if passed length is greater than reciever strings length trailing will be ommitted and reciever object is returned.
 * @remarks [@"CodeWorth" truncateTails:2] gives "Co.."
 */
-(NSString *)truncateTails:(NSInteger)length
{
	if([self length]>length)
	{
		return [[self substringToIndex:length-3] stringByAppendingString:@".."];
	}
	
	return self;
}

/**
 * Converts a single lined string to a multi lines paragraph.
 * @param linelength : length of each line in the generated paragraph.
 * @return a new (autoreleased) String instance with multiple lines
 * @remarks Only for view purpose to prevent missing of characters to user while reading.
 * @remarks The paragraph generated doesn't have word wraping and hence a single word might be displayed in 2 lines.
 */
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

/**
 * splits a single word string to a multi worded scentence.
 * @param wordlength : length of each word in the generated scentence.
 * @return a new (autoreleased) String instance with multiple words
 * @remarks Only for view purpose to prevent missing of characters to user while displaying lengthy passwords which doesn't have any space in them.
 * @remarks please do not assign the returned string to the reciever object's referece because the actual password might be needed further when authenticating.
 */
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

/**
 * Converts string to date object using the format specified.
 * @param dateFormat : format of the date which the reciever string contains.
 * @return a new (autoreleased) Date instance.
 */
-(NSDate *)dateWithFormat:(NSString*)dateFormat
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:dateFormat];
	NSDate *retDate=[dateFormatter dateFromString:self];
	[dateFormatter release];
	return retDate;
}

/**
 * Converts string to utf-8 characters.
 * Used to convert the string to base 64 before passing to a rest or soap services to allow all characters.
 * @return a new (autoreleased) Data instance which can be further converted to base64 if needed.
 */
- (NSData*)getUTF8DataRepresentation
{
	NSData* data=[self dataUsingEncoding:NSUTF8StringEncoding];
	return data;
}

#pragma mark -
#pragma mark String Util Methods
/**
 * Splits reciever string into an array based on the passed length.
 * @param length : length in which the reciever string is desired to splitted up.
 * @return a new (autoreleased) array instance which has splitted strings.
 */
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

/**
 * gives you the actual domain name from the url you have.
 * @return a new (autoreleased) string instance.
 * @remarks [@@"http://www.google.com/search.php?search=codeworth" getDomainFromURL] will give "www.google.com"
 */
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

/**
 * Just an extension that gives you localized string
 * @remarks [@@"test" localizedString]; would just be easier that that of NSLocalizedString(@@"test",@@"this is a test context")
 * @return a new (autoreleased) string that has the localized string correspondent to reciever string
 */
-(NSString*)localizedString
{
	return NSLocalizedString(self,@"");
}

/**
 * Counts no.of.lines in given string.
 * Helpful when you are creating a label dynamically and assigning numberOfLines property to it.
 * @return a new (autoreleased) string that has the localized string correspondent to reciever string
 */
-(NSInteger)numberOfLinesInString
{
	//returns how many lines does targeted string has.
	return [[self componentsSeparatedByString:@"\n"] count];
}

#pragma mark -
@end