/*! 
 *  \brief     NSString+iGenLib.
 *  \details   iGenLib Extensions for NSString.
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

@interface NSString (iGenLib)
#pragma mark String Search methods

/**
 * Checks if the reciever string is equal to either of the strings passed.
 * Useful when sending/recieving multiple objects as comma seperated values instead of seperate entities for each of them. ex: when you are remove 2 friends from the app the server returns the names of friend you recently deleted on the website so that you can iterate among local friends list and remove them.
 * @param strings : single string which has the strings as comma seperated values
 * @return Yes if the reciever matches to either of the passed strings or else it returns no
 */
- (BOOL)isAnyOf:(NSString *)strings;
/**
 * Checks if the reciever string contains the passed string.
 * @param string : string which have to be searched for in the reciever string.
 * @return Yes if the reciever contains passed string or else it returns no
 */
-(BOOL)containsString:(NSString *)string;

/**
 * Checks if the reciever string is contains either of the strings passed.
 * Useful when sending/recieving multiple objects as comma seperated values instead of seperate entities for each of them.
 * @param strings : single string which has the strings as comma seperated values
 * @return Yes if the reciever contains either of the passed strings or else it returns no
 */
-(BOOL)containsAnyOf:(NSString *)strings;

/**
 * Checks if the reciever string is either empty (can be '' or '|space|space|')
 * @return Yes if the string is empty or it has only spaces in it
 */
-(BOOL)isEmptyString;

#pragma mark -
#pragma mark String Format methods

/**
 * Ads a double quote in both sides of the strings
 * @return string with double quotes on either side
 */
-(NSString*)doubleQuotedString;

/**
 * Ads a single quote in both sides of the strings
 * @return string with single quotes on either side
 */
-(NSString*)singleQuotedString;

/**
 * creates a string which is tailed with ... after passed length.
 * @return a new (autoreleased) String instance with tailing
 * @return if passed length is greater than reciever strings length trailing will be ommitted and reciever object is returned.
 * @remarks [@"CodeWorth" truncateTails:2] gives "Co.."
 */
-(NSString *)truncateTails:(NSInteger)length;

/**
 * Converts a single lined string to a multi lines paragraph.
 * @param linelength : length of each line in the generated paragraph.
 * @return a new (autoreleased) String instance with multiple lines
 * @remarks Only for view purpose to prevent missing of characters to user while reading.
 * @remarks The paragraph generated doesn't have word wraping and hence a single word might be displayed in 2 lines.
 */
-(NSString *)stringByAddingNewLines:(NSInteger)linelength;

/**
 * splits a single word string to a multi worded scentence.
 * @param wordlength : length of each word in the generated scentence.
 * @return a new (autoreleased) String instance with multiple words
 * @remarks Only for view purpose to prevent missing of characters to user while displaying lengthy passwords which doesn't have any space in them.
 * @remarks please do not assign the returned string to the reciever object's referece because the actual password might be needed further when authenticating.
 */
-(NSString *)stringByAddingSpaces:(NSInteger)wordlength;

#pragma mark -
#pragma mark String Conversion Methods

/**
 * Converts string to date object using the format specified.
 * @param dateFormat : format of the date which the reciever string contains.
 * @return a new (autoreleased) Date instance.
 */
-(NSDate *)dateWithFormat:(NSString*)dateFormat;

/**
 * Converts string to utf-8 characters.
 * Used to convert the string to base 64 before passing to a rest or soap services to allow all characters.
 * @return a new (autoreleased) Data instance which can be further converted to base64 if needed.
 */
- (NSData*)getUTF8DataRepresentation;

#pragma mark -
#pragma mark String Util Methods
/**
 * Splits reciever string into an array based on the passed length.
 * @param length : length in which the reciever string is desired to splitted up.
 * @return a new (autoreleased) array instance which has splitted strings.
 */
-(NSArray*)componentsSeparatedByLength:(NSInteger)length;

/**
 * gives you the actual domain name from the url you have.
 * @return a new (autoreleased) string instance.
 * @remarks [@@"http://www.google.com/search.php?search=codeworth" getDomainFromURL] will give "www.google.com"
 */
-(NSString*)getDomainFromURL;

/**
 * Just an extension that gives you localized string
 * @remarks [@@"test" localizedString]; would just be easier that that of NSLocalizedString(@@"test",@@"this is a test context")
 * @return a new (autoreleased) string that has the localized string correspondent to reciever string
 */
-(NSString*)localizedString;

/**
 * Counts no.of.lines in given string.
 * Helpful when you are creating a label dynamically and assigning numberOfLines property to it.
 * @return a new (autoreleased) string that has the localized string correspondent to reciever string
 */
-(NSInteger)numberOfLinesInString;

#pragma mark -
@end