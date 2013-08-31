/*! 
 *  \brief     UIScreen+iGenLib.
 *  \details   iGenLib Extensions for UIScreen.
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

#import "UIScreen+iGenLib.h"
@implementation UIScreen (iGenLib)
/*
 * get current screen size in pixel ( that will NOT handle retina size )
 */
+ (CGSize) getScreenSizeInPixel
{
	return [UIScreen mainScreen].bounds.size;
}


/*
 * get current device window size in pixel ( that will handle retina size )
 */
+ (CGSize) getDeviceWindowSizeInPixel
{
	//- return mainScreen current mode size information
	return [[[UIScreen mainScreen] currentMode] size];
}
@end