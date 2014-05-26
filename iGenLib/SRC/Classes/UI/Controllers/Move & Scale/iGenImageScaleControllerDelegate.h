/*! 
 *  \protocol <iGenImageScaleControllerDelegate>
 *  \details   Delegate to be implemented by the VC which shows up image scaling controller
 *  \author    Rama Krishna Chunduri
 *  \date      8/5/11.
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

#import <Foundation/Foundation.h>

@class iGenImageScaleController;

@protocol iGenImageScaleControllerDelegate<NSObject>

@optional
/**
 * Will be called over the delegate object before showing the picker.
 * The method allows the invoker to customize the ui respect to that application before showing scaling controller
 * @param picker : iGenImageScaleController
 */
-(void)imageScalerWillShow:(iGenImageScaleController*)picker;

/**
 * Will be called  over the delegate object once the user is done with scaling and choosen "Use" button
 * @param picker : iGenImageScaleController
 * @param image : the scaled image.
 */
-(void)imageScaler:(iGenImageScaleController*)picker didFinishedScalingImage:(UIImage*)image;

/**
 * Will be called  over the delegate object once the user choosen "Cancel" button
 * If some variables local to particular View/Vc are to be released developer can do it here
 * @param picker : iGenImageScaleController
 */
-(void)imageScalerDidCancel:(iGenImageScaleController*)picker;

@end