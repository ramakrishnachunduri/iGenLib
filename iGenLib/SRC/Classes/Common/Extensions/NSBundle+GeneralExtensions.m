#import "NSBundle+GeneralExtensions.h"
@implementation NSBundle (GeneralExtensions)

-(NSString *)localizedPathForResource:(NSString *)name ofType:(NSString *)ext
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
	NSString *currentLanguage = [languages objectAtIndex:0];
	NSString *currentLocalizedFolder=[currentLanguage stringByAppendingString:@".lproj"];
	
	if([self pathForResource:name ofType:ext inDirectory:currentLocalizedFolder]==nil)
	{
		currentLocalizedFolder=@"en.lproj";
	}
	return [self pathForResource:name ofType:ext inDirectory:currentLocalizedFolder];
}

@end