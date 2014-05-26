/*! 
 *  \brief     UIView+iGenLib.
 *  \details   iGenLib Extensions for UIView.
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

#import "UIView+iGenLib.h"
@implementation UIView (iGenLib)
- (UIView *)findFirstResponder
{
	if ([self isFirstResponder]) {
		return self;
	}
	
	for (UIView *subview in [self subviews]) {
		UIView *firstResponder = [subview findFirstResponder];
		if (nil != firstResponder) {
			return firstResponder;
		}
	}
	
	return nil;
}

- (NSMutableArray*)allSubViews
{
	NSMutableArray *arr=[[[NSMutableArray alloc] init] autorelease];
	[arr addObject:self];
	for (UIView *subview in self.subviews)
    {
	    [arr addObjectsFromArray:(NSArray*)[subview allSubViews]];
    }
	return arr;
}

- (UIImage*)toImage
{
	UIGraphicsBeginImageContext(self.frame.size);
	[self.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return outputImage;
}
@end