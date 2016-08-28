#import "UIImage+iGenLib.h"

@implementation UIImage (iGenLib)

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

-(BOOL) isLandScape
{
	CGFloat ratio = self.size.width/self.size.height;
	return (ratio>1);
}

-(BOOL) isPotrait
{
	CGFloat ratio = self.size.width/self.size.height;
	return !(ratio>1);
}

@end