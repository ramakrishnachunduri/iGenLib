/*! 
 *  \brief     NSThread+iGenLib.
 *  \details   iGenLib Extensions for NSThread.
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