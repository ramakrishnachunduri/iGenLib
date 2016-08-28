#import "NSArray+GeneralExtensions.h"
#import "NSString+iGenLib.h"

@implementation NSArray(GeneralExtensions)

#pragma mark String Functionalities
-(NSArray*)alphabeticallySortedArray
{
	return [self sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

-(NSUInteger)indexOfCaseInsensitiveString:(NSString *)aString
{
    NSUInteger index = 0;
    for (NSString *object in self) 
	{
        if([object caseInsensitiveCompare:aString] == NSOrderedSame)
		{
            return index;
        }
        index++;
    }
    return NSNotFound;
} 

-(NSArray*)objectsContainingString:(NSString *)aString
{
	NSMutableArray *newArray=[[NSMutableArray alloc] init];
	for (NSString *obj in self) 
	{
		if([obj containsString:aString])
		{
			[newArray addObject:obj];
		}
	}
	NSArray *returnArray=[NSArray arrayWithArray:newArray];
	[newArray release];
	return returnArray;
}

-(NSArray*)objectsWithPrefix:(NSString *)prefix;
{
	NSMutableArray *newArray=[[NSMutableArray alloc] init];
	for (NSString *obj in self) 
	{
		obj=[obj stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
		if([obj hasPrefix:prefix])
		{
			[newArray addObject:obj];
		}
	}
	NSArray *returnArray=[NSArray arrayWithArray:newArray];
	[newArray release];
	return returnArray;
}

#pragma mark -

-(id)firstObject
{
	if(self!=nil && [self count]>0)
	{
		return [self objectAtIndex:0];
	}
	return nil;
}
@end
