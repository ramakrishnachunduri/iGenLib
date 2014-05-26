/*! 
 *  \brief     NSDate+UIAlertView.
 *  \details   iGenLib Extensions for UIAlertView.
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

#import "UIAlertView+iGenLib.h"
#import "NSString+iGenLib.h"

@implementation UIAlertView (iGenLib)

/**
 * Shows an alert instance with the contents localized on it.
 * Prevents manual calling of NSLocalizedString(string,context) method for title,message and all buttons.
 * @return void or nothing
 */
-(void)showLocalizedMessage
{
	self.message=[self.message localizedString];
	self.title=[self.title localizedString];
	[self show];

	for (UIView *x in self.subviews)
	{	
		if([[x description] containsString:@"UIThreePartButton"])
		{
			[x setValue:[[x valueForKey:@"title"] localizedString] forKey:@"title"];
		}
	}
}

/**
 * Shows an alert instance with the message contents aligned to left.
 * @param isLocalized: optional argument to call showLocalizedMessage and prevent manual calling of NSLocalizedString(string,context) method for title,message and all buttons.
 * @return void or nothing
 */
-(void)showLeftAlignedMessageLocalized:(BOOL)isLocalized
{
	if(isLocalized)
	{
		[self showLocalizedMessage];
	}
	else
	{
		[self show];
	}
	
	for (UIView *x in self.subviews)
	{
		if([x isKindOfClass:[UILabel class]])
		{
			if([((UILabel *)x).text isEqualToString:self.message])
				((UILabel *)x).textAlignment=UITextAlignmentLeft;
		}
	}
}

@end