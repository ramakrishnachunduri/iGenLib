/*! 
 *  \brief     NSObject+iGenLib.
 *  \details   iGenLib Extensions for NSObject.
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


#import "NSObject+GeneralExtensions.h"
#import "NSInvocation+iGenLib.h"

@implementation NSObject (iGenLib)

/**
 * This is to prevent Unrecognized Selector sent when we are unaware of targetted class.
 * @param aSelector : desired selector to be performed on reciever object
 * @result if selector/method is found it will be invoked, if not it will be left as is.
 */
- (id)performSelectorIfResponds:(SEL)aSelector
{
    if([self respondsToSelector:aSelector])
	{
        return [self performSelector:aSelector];
    }
    return NULL;
}

/**
 * This is to prevent Unrecognized Selector sent when we are unaware of targetted class.
 * @param aSelector : desired selector to be performed on reciever object
 * @param anObject	: object which is to be passed to the invoked selector
 * @result if selector/method is found it will be invoked, if not it will be left as is.
 */
- (id)performSelectorIfResponds:(SEL)aSelector withObject:(id)anObject
{
    if ( [self respondsToSelector:aSelector] ) {
        return [self performSelector:aSelector withObject:anObject];
    }
    return NULL;
}

/**
 * This is to convert a null or nil object to an empty ot blank string, useful when a gaint array is looped against some string operations to prevent the crashes
 * @return if reciever object is null or nill then an empty string.
 * @return returns the same object when object is neither nil or null.
 */
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

@end

@implementation NSObject(MultiObjects)

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

@end