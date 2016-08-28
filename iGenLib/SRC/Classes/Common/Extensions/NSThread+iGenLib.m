#import "NSThread+iGenLib.h"
#import "NSInvocation+iGenLib.h"

@implementation NSThread (MultiObjects)

+ (void)detachNewThreadSelector:(SEL)aSelector toTarget:(id)aTarget withObjects:(id)object,... 
{
	NSInvocation *invocation;
	va_list args;
    va_start(args, object);
	invocation=[NSInvocation invocationWithSelector:aSelector toTarget:aTarget andArgument:object otherArgs:args];
	va_end(args);
	
	[self detachNewThreadSelector:@selector(invoke) toTarget:invocation withObject:nil];
}

@end