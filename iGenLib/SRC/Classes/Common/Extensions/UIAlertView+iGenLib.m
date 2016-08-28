#import "UIAlertView+iGenLib.h"
#import "NSString+iGenLib.h"

@implementation UIAlertView (iGenLib)

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