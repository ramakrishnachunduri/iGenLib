#import "UIView+iGenLib.h"
#import <QuartzCore/QuartzCore.h>

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