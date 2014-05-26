/*! 
 *  \brief     NSMutableArray+GeneralExtensions.
 *  \details   General Extensions for NSMutableArray.
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

#import "NSMutableArray+GeneralExtensions.h"
#import "NSString+iGenLib.h"
#import "NSArray+GeneralExtensions.h"

@implementation NSMutableArray(GeneralExtensions)
#pragma mark String Functionalities

/**
 * Removes objects from the array which contains specified string
 * @param aString : string to search in reciever array's individual items
 */
-(void)removeObjectsContainingString:(NSString *)aString
{
	[self removeObjectsInArray:[self objectsContainingString:aString]];
}

/**
 * Removes objects from the array which starts with specified string
 * @param aString : string to check if an individual item in reciever array's is starting with
 */
-(void)removeObjectsWithPrefix:(NSString *)aString
{
	[self removeObjectsInArray:[self objectsWithPrefix:aString]];
}

#pragma mark -
@end