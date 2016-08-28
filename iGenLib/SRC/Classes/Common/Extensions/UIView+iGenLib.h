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

#import <UIKit/UIKit.h>
@interface UIView (iGenLib)
/**
 *  iterate all subviews in reciever view and finds the current first responder
 *  When your view has multiple textfields and wanted to dismiss keyboard without being aware of which field is being edited by user.
 *  @return a UIView or subclass of UIView which is currently being first responder
 */
- (UIView *)findFirstResponder;

/**
 *  Calculate the height of text content about to be placed in UI.
 *  @param content       content to calculate height for
 *  @param contentWidth  desired width for the content (screenwidth in most cases)
 *  @param minimumHeight minimum height incase if text is too small to display in.
 *  @param font          desired font to use in UI to fin
 *
 *  @return calculated height to place content in
 */
+(CGFloat)heightForContent:(NSString *)content inWidth:(CGFloat)contentWidth minimumHeight:(CGFloat)minimumHeight withFont:(UIFont*)font;

/**
 *  Iterate all subviews recursively in reciever view and returns array
 *	This is different from subviews array as it returns only views in sub-hierarchy but not nested heirarchies.
 *
 *  @return Array of views
 */
- (NSMutableArray*)allSubViews;

/**
 *	Convert view to image
 */
- (UIImage*)toImage;

/**
 * Draws view in current context.
 * Ex : draw view in PDF,Graph and sometimes over another image
 */
-(void)drawInCurrentGraphicsContext;
@end