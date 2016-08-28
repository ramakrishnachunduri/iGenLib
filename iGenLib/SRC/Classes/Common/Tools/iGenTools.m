#import "iGenTools.h"

@implementation iGenTools

#pragma mark Logs

/*
 * add extended information on a classical NSLog command
 */
void extendedLog(NSString* extendedInfo, NSString* format, ...)
{
	va_list argumentList;
	va_start(argumentList, format);
	
	NSLogv([extendedInfo stringByAppendingString:format], argumentList);
	
	va_end(argumentList);
}

#pragma mark -
@end