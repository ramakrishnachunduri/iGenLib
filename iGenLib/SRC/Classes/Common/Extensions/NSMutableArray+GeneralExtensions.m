#import "NSMutableArray+GeneralExtensions.h"
#import "NSString+iGenLib.h"
#import "NSArray+GeneralExtensions.h"

@implementation NSMutableArray(GeneralExtensions)
#pragma mark String Functionalities

-(void)removeObjectsContainingString:(NSString *)aString
{
	[self removeObjectsInArray:[self objectsContainingString:aString]];
}

-(void)removeObjectsWithPrefix:(NSString *)aString
{
	[self removeObjectsInArray:[self objectsWithPrefix:aString]];
}

#pragma mark -
@end