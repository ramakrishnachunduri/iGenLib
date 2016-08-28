#import "NSObject+GeneralExtensions.h"
#import "NSInvocation+iGenLib.h"

@implementation NSObject (iGenLib)

- (id)performSelectorIfResponds:(SEL)aSelector
{
    if([self respondsToSelector:aSelector])
	{
        return [self performSelector:aSelector];
    }
    return NULL;
}

- (id)performSelectorIfResponds:(SEL)aSelector withObject:(id)anObject
{
    if ( [self respondsToSelector:aSelector] ) {
        return [self performSelector:aSelector withObject:anObject];
    }
    return NULL;
}

-(id)nullToBlank
{
	if((self==nil)||[self isEqual:[NSNull null]])
	{
		return @"";
	}
	else
	{
		return self;
	}
}

#pragma mark multi objects

-(void)performSelectorOnMainThread:(SEL)aSelector withObjects:(id)object,...
{
	NSInvocation *invocation;
	va_list args;
    va_start(args, object);
	invocation=[NSInvocation invocationWithSelector:aSelector toTarget:self andArgument:object otherArgs:args];
	va_end(args);
	
	[invocation performSelectorOnMainThread:@selector(invoke) withObject:nil waitUntilDone:NO];
}

-(void)performSelector:(SEL)aSelector afterDelay:(NSTimeInterval)delay withObjects:(id)object,...
{
	NSInvocation *invocation;
	va_list args;
    va_start(args, object);
	invocation=[NSInvocation invocationWithSelector:aSelector toTarget:self andArgument:object otherArgs:args];
	va_end(args);
	
	[invocation performSelector:@selector(invoke) withObject:nil afterDelay:delay];
}

-(void)performSelector:(SEL)aSelector withValues:(id)value,...
{
	NSInvocation *invocation;
	va_list args;
    va_start(args, value);
	invocation=[NSInvocation invocationWithSelector:aSelector toTarget:self andArgument:value otherArgs:args];
	va_end(args);
	
	[invocation performSelector:@selector(invoke) withObject:nil];
}

#pragma mark multi objects -

@end