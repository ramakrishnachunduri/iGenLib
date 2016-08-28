/*! 
 *  \brief     UIImage+iGenLib.
 *  \details   iGenLib Extensions for UIImage.
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

#include <UIKit/UIKit.h>
@interface UIImage (iGenLib)

/**
 *  Rotates and draws the reciever image resulting in new image
 *
 *  @param degrees degrees with which rotation to be done
 *  @return a new image instance where reciever image is rotated
 */
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

/**
 *  Creates a resizable image with prefered color. Can be used in following scenarios
 *  - UIButton doesn't allow to set different colors in different states but different background images in different states, so a resizable color image can be setted.
 *
 *  @param color Color to render the image with
 *  @return a resizable image rendered using passed color and generated image is returned.
 */
+ (UIImage *)resizableImageWithColor:(UIColor *)color;

/**
 *  Creates a resizable image with prefered color. Can be used in following scenarios
 *  - UIButton doesn't allow to set different colors in different states but different background images in different states, so a resizable color image can be setted.
 *
 *  @param color Color to render the image with
 *  @param radius corner radius for rounder corners to be rendered
 *  @return a resizable image rendered using passed color and corner radius and generated image is returned.
 */
+ (UIImage *)resizableRoundedCornerImageWithColor:(UIColor *)color andRadius:(CGFloat)radius;

/**
 *  Creates an image with new size while stricting to the same aspect ratio as original one.
 *  @param width desired width the image to scale(/shrink) to.
 *  @return new image which is scaled to desired width
 */
-(UIImage*)imageByScalingProportionallyToWidth:(CGFloat)width;

/**
 * Scales the image to specified size
 * @param sizeToScale : size the image have to be scaled
 * @param isStrech : specify whether the image have to be streched to size.
 * \n if given yes image will be streched strict to the given size.
 * \n if given no image will be scaled along with the aspect ratio
 * @return returns the image instance with the scaled image.
 */
- (UIImage *)scaleToSize:(CGSize)sizeToScale strech:(BOOL)isStrech;

/**
 *To find whether land scape image or portrait
 */
-(BOOL)isLandScape;

/**
 *To find whether image is potrait image or portrait
 */
-(BOOL)isPotrait;
@end