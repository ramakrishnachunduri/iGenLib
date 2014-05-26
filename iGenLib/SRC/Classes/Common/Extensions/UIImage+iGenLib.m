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

#import "UIImage+iGenLib.h"

@implementation UIImage (iGenLib)

/**
 * Scales the image to specified size
 * @param sizeToScale : size the image have to be scaled
 * @param isStrech : specify whether the image have to be streched to size.
 * \n if given yes image will be streched strict to the given size.
 * \n if given no image will be scaled along with the aspect ratio
 * @return returns the image instance with the scaled image.
 */
- (UIImage *)scaleToSize:(CGSize)sizeToScale strech:(BOOL)isStrech
{
	if(isStrech)
	{
		BOOL isScalingNeeded=YES;
	
		isScalingNeeded=((self.size.width>sizeToScale.width)||(self.size.height>sizeToScale.height));
	
		if(!isScalingNeeded)
			return self;
	
		if([self isLandScape])
		{
			NSLog(@"LandScape");
			sizeToScale=CGSizeMake(sizeToScale.width,(sizeToScale.width*self.size.height)/self.size.width);
		}
		else
		{
			NSLog(@"Potrait");
			sizeToScale=CGSizeMake((sizeToScale.height*self.size.width)/self.size.height,sizeToScale.height);
		}
	}
	
	// Scalling selected image to targeted size
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef context = CGBitmapContextCreate(NULL, sizeToScale.width, sizeToScale.height, 8, 0, colorSpace, kCGImageAlphaPremultipliedLast);
	CGContextClearRect(context, CGRectMake(0, 0, sizeToScale.width, sizeToScale.height));
	
	if(self.imageOrientation == UIImageOrientationRight)
	{
		CGContextRotateCTM(context, -M_PI_2);
		CGContextTranslateCTM(context, -sizeToScale.height, 0.0f);
		CGContextDrawImage(context, CGRectMake(0, 0, sizeToScale.height, sizeToScale.width), self.CGImage);
	}
	else
		CGContextDrawImage(context, CGRectMake(0, 0, sizeToScale.width, sizeToScale.height), self.CGImage);
	
	CGImageRef scaledImage=CGBitmapContextCreateImage(context);
	
	CGColorSpaceRelease(colorSpace);
	CGContextRelease(context);
	
	UIImage *image = [UIImage imageWithCGImage: scaledImage];
	
	CGImageRelease(scaledImage);
	
	return image;
}

/*
 *To find whether image is land scape image
 */
-(BOOL) isLandScape
{
	CGFloat ratio = self.size.width/self.size.height;
	return (ratio>1);
}

/*
 *To find whether image is potrait image or portrait
 */
-(BOOL) isPotrait
{
	CGFloat ratio = self.size.width/self.size.height;
	return !(ratio>1);
}

@end