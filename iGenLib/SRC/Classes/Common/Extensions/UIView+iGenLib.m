#import "UIView+iGenLib.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (iGenLib)
- (UIView *)findFirstResponder
{
	if ([self isFirstResponder])
	{
		return self;
	}
	
	for (UIView *subview in [self subviews])
	{
		UIView *firstResponder = [subview findFirstResponder];
		if (nil != firstResponder) { return firstResponder; }
	}
	
	return nil;
}

+(CGFloat)heightForContent:(NSString *)content inWidth:(CGFloat)contentWidth minimumHeight:(CGFloat)minimumHeight withFont:(UIFont*)font
{
	/*UITextView *t=[[UITextView alloc] initWithFrame:CGRectMake(0, 0, contentWidth, minimumHeight)];
	 t.text=content;
	 t.font=font;
	 t.contentInset = UIEdgeInsetsMake(-4,-8,0,0);
	 [t setContentMode:UIViewContentModeCenter];
	 [t sizeToFit];
	 
	 if (IS_DEVICE_RUNNING_IOS_7_AND_ABOVE()) {
		return (t.frame.size.height>minimumHeight)?t.frame.size.height:minimumHeight;
	 }
	 return (t.contentSize.height>minimumHeight)?t.contentSize.height:minimumHeight;
	 */
	
	NSStringDrawingOptions opt= NSStringDrawingUsesLineFragmentOrigin |
	NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading;
	NSDictionary *fontDict = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
	CGRect textSize = [content boundingRectWithSize:CGSizeMake(contentWidth, MAXFLOAT) options:opt
										 attributes:fontDict context:nil];
	CGFloat ht=ceil(textSize.size.height);
	return (ht>minimumHeight)?ht:minimumHeight;
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

-(void)drawInCurrentGraphicsContext
{
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);
	CGContextTranslateCTM(context, [self center].x, [self center].y);
	CGContextConcatCTM(context, [self transform]);
	CGContextTranslateCTM(context, -[self bounds].size.width * [[self layer] anchorPoint].x,
						  -[self bounds].size.height * [[self layer] anchorPoint].y);
	[[self layer] renderInContext:context];
	CGContextRestoreGState(context);
}
@end