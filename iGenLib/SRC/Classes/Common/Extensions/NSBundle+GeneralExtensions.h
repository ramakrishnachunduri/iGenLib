/*! 
 *  \brief     NSBundle+GeneralExtensions.
 *  \details   General Extensions for NSBundle.
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

@interface NSBundle (GeneralExtensions)

/**
 * get the path of the resource file in the bundle respective to current locale
 * @param name : name of the file resource
 * @param ext : extension or type of the file resource
 * @return String that has the path of the file in the current locale directory
 * @return String that has the path of the file correspondent to english locale if active locale directory is not found
 */
-(NSString *)localizedPathForResource:(NSString *)name ofType:(NSString *)ext;

@end