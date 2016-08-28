#import "UIScreen+iGenLib.h"
@implementation UIScreen (iGenLib)
+ (CGSize) getScreenSizeInPixel
{
	return [UIScreen mainScreen].bounds.size;
}

+ (CGSize) getDeviceWindowSizeInPixel
{
	//- return mainScreen current mode size information
	return [[[UIScreen mainScreen] currentMode] size];
}
@end