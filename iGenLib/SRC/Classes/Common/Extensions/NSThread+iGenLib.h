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

#import <Foundation/Foundation.h>

@interface NSThread (MultiObjects)

/**
 * Conventionally you are allowed to start athread passing only one object this will let you perform with multiple objects
 * @result if selector/method is found it will be invoked, if not it will throw correspondent exception.
 */
+ (void)detachNewThreadSelector:(SEL)aSelector toTarget:(id)aTarget withObjects:(id)object,... NS_REQUIRES_NIL_TERMINATION;

@end