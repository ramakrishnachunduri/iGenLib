/*! 
 *  \brief     iGenImageScaleController
 *  \details   A Controller/Component which allows to move and scale an image and further use scaled image.
 *  \author    Rama Krishna Chunduri
 *  \date      2/15/11.
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
#import "iGenImageScaleControllerDelegate.h"

@interface iGenImageScaleController : UIViewController<UIScrollViewDelegate>
{
	/// readonly member to hold content view
	UIView *_contentView;
	
	/// readonly member to hold bottom toolbar
	UIToolbar *_bottomToolBar;
	
	/// member to hold the delegate's instance and notify further upon completion of scaling and image
	id <iGenImageScaleControllerDelegate> _delegate;
}

/// must be a view/vc which implements correspondent delegate
@property(nonatomic,assign) id <iGenImageScaleControllerDelegate> delegate;

/**
 * Initialize scaling controller
 * @param image : image object to be scaled.
 * @param delegate : delegate object - any object which implements iGenImageScaleControllerDelegate
 * @return iGenImageScaleController object
 */
-(iGenImageScaleController*)initWithImage:(UIImage*)image delegate:(id<iGenImageScaleControllerDelegate>)_delegate;

@end