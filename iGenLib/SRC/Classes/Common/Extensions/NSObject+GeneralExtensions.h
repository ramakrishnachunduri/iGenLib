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
@interface NSObject (iGenLib)

/**
 * This is to prevent Unrecognized Selector sent when we are unaware of targetted class.
 * @param aSelector : desired selector to be performed on reciever object
 * @result if selector/method is found it will be invoked, if not it will be left as is.
 */
- (id)performSelectorIfResponds:(SEL)aSelector;

/**
 * This is to prevent Unrecognized Selector sent when we are unaware of targetted class.
 * @param aSelector : desired selector to be performed on reciever object
 * @param anObject	: object which is to be passed to the invoked selector
 * @result if selector/method is found it will be invoked, if not it will be left as is.
 */
- (id)performSelectorIfResponds:(SEL)aSelector withObject:(id)anObject;

/**
 * This is to convert a null or nil object to an empty ot blank string, useful when a gaint array is looped against some string operations to prevent the crashes
 * @return if reciever object is null or nill then an empty string.
 * @return returns the same object when object is neither nil or null.
 */
-(id)nullToBlank;

/**
 * Conventionally you are allowed to perform a selector on main thread with only one object this will let you perform with multiple objects
 * @result if selector/method is found it will be invoked, if not it will throw correspondent exception.
 */
-(void)performSelectorOnMainThread:(SEL)aSelector withObjects:(id)object,... NS_REQUIRES_NIL_TERMINATION;


/**
 * Conventionally you are allowed to perform a selector with a delay passing only one object this will let you perform with multiple objects
 * @result if selector/method is found it will be invoked, if not it will throw correspondent exception.
 */
-(void)performSelector:(SEL)aSelector afterDelay:(NSTimeInterval)delay withObjects:(id)object,... NS_REQUIRES_NIL_TERMINATION;

/**
 * Conventionally you are allowed to perform a selector passing only one object this will let you perform with multiple objects
 * @result if selector/method is found it will be invoked, if not it will throw correspondent exception.
 */
-(void)performSelector:(SEL)aSelector withValues:(id)value,... NS_REQUIRES_NIL_TERMINATION;

@end