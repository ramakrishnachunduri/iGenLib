#import "UITableView+iGenLib.h"
#import "NSObject+GeneralExtensions.h"
@implementation UITableView (iGenLib)
-(void)removeBackground
{
	self.backgroundColor=[UIColor clearColor];
	[self performSelectorIfResponds:@selector(setBackgroundView:) withObject:nil];
}
@end