/*! 
 *  \brief     NSInvocation+iGenLib.
 *  \details   iGenLib Extensions for NSInvocation.
 *  \author    Rama Krishna Chunduri
 *  \date      4/09/13
 *	\copyright Codeworth 2013, All rights reserved.
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

#import "NSInvocation+iGenLib.h"

@implementation NSInvocation (MultiObjects)

+ (NSInvocation*)invocationWithSelector:(SEL)aSelector toTarget:(id)aTarget andArgument:(id)object otherArgs:(va_list)otherArgs
{
	NSMethodSignature *signature = [aTarget methodSignatureForSelector:aSelector];
    if (!signature) { return nil; }
	
    NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:aTarget];
    [invocation setSelector:aSelector];
	int index=2;
	[invocation setArgument:&object atIndex:index];
	
	id argument;
	while((argument = va_arg(otherArgs, id)))
	{
		index++;
		[invocation setArgument:&argument atIndex:index];
	}
	
	[invocation retainArguments];
	
	return invocation;
}

+ (NSInvocation*)invocationWithSelector:(SEL)aSelector toTarget:(id)aTarget andArguments:(id)object,...;
{
	NSInvocation *invocation;
	
	va_list argumentList;
	va_start(argumentList, object);
	invocation=[NSInvocation invocationWithSelector:aSelector toTarget:aTarget andArgument:object otherArgs:argumentList];
	va_end(argumentList);
	
	return invocation;
}

@end