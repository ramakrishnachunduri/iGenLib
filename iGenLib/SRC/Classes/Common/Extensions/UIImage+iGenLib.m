#import "UIImage+iGenLib.h"

@implementation UIImage (iGenLib)

static CGFloat DegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};

- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees
{
	// calculate the size of the rotated view's containing box for our drawing space
	UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.size.width, self.size.height)];
	CGAffineTransform t = CGAffineTransformMakeRotation(DegreesToRadians(degrees));
	rotatedViewBox.transform = t;
	CGSize rotatedSize = rotatedViewBox.frame.size;
	
	// Create the bitmap context
	UIGraphicsBeginImageContext(rotatedSize);
	CGContextRef bitmap = UIGraphicsGetCurrentContext();
	
	// Move the origin to the middle of the image so we will rotate and scale around the center.
	CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
	
	//   // Rotate the image context
	CGContextRotateCTM(bitmap, DegreesToRadians(degrees));
	
	// Now, draw the rotated/scaled image into the context
	CGContextScaleCTM(bitmap, 1.0, -1.0);
	CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);
	
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newImage;
}

+ (UIImage *)resizableImageWithColor:(UIColor *)color
{
	CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
	UIGraphicsBeginImageContext(rect.size);
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(context, [color CGColor]);
	CGContextFillRect(context, rect);
	
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return [image resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
}

+ (UIImage *)resizableRoundedCornerImageWithColor:(UIColor *)color andRadius:(CGFloat)radius
{
	CGRect rect = CGRectMake(0.0f, 0.0f, radius*2, radius*2);
	UIGraphicsBeginImageContext(rect.size);
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(context, [color CGColor]);
	CGContextFillEllipseInRect(context, rect);
	
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return [image resizableImageWithCapInsets:UIEdgeInsetsMake(radius, radius, radius, radius)];
}

-(UIImage*)imageByScalingProportionallyToWidth:(CGFloat)width
{
	float oldWidth = self.size.width;
	float scaleFactor = width / oldWidth;
	float newHeight = self.size.height * scaleFactor;
	float newWidth = oldWidth * scaleFactor;
	
	UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
	[self drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newImage;
}

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