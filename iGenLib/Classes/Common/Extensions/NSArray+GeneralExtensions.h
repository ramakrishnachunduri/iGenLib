/*! 
 *  \brief     NSArray+GeneralExtensions.
 *  \details   General Extensions for NSArray.
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

@interface NSArray(GeneralExtensions)

#pragma mark String Functionalities

/**
 * Sorts the items of the reciever array alphabetically
 */
-(NSArray *)alphabeticallySortedArray;

/**
 * Search for particular string case insensitively in the items of the reciever array
 * @param aString : string to search in reciever array
 * @return if string is found then returns a number greater than -1
 * @return NSNotFound if the string is not found.
 */
-(NSUInteger)indexOfCaseInsensitiveString:(NSString *)aString;

/**
 * Search for particular substring in the items of the reciever array
 * @param aString : substring to search in reciever array
 * @return if substring is found then returns an array with those items
 * @return if not found returns an empty array
 */
-(NSArray*)objectsContainingString:(NSString *)aString;

/**
 * Search for items of the reciever array which start with particular substring/prefix 
 * @param prefix : prefix to search in reciever array
 * @return if has prefix then returns an array with those items
 * @return if not then returns an empty array
 */
-(NSArray*)objectsWithPrefix:(NSString *)prefix;

#pragma mark -

/**
 * find the first object in the reciever array
 * @return if array has first object i.e., count>0 then returns first object
 * @return if array is not having items then returns nil
 */
-(id)firstObject;
@end