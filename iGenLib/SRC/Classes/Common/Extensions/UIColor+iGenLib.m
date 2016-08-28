#import "UIColor+iGenLib.h"
#import "NSString+iGenLib.h"

@implementation UIColor (iGenLib)

+(UIColor*)colorFromRGB:(NSString*)rgbcolor
{
	rgbcolor=[rgbcolor lowercaseString];
	NSString *rgbacolor=[rgbcolor stringByReplacingOccurrencesOfString:@"rgb(" withString:@"rgba("];
	rgbacolor=[rgbacolor stringByReplacingOccurrencesOfString:@")" withString:@",1.0)"];
	
	return [UIColor colorFromRGBA:rgbacolor];
}

+(UIColor*)colorFromRGBA:(NSString*)rgbacolor
{
	rgbacolor=[rgbacolor lowercaseString];
	rgbacolor=[rgbacolor stringByReplacingOccurrencesOfString:@"rgba(" withString:@""];
	rgbacolor=[rgbacolor stringByReplacingOccurrencesOfString:@")" withString:@""];
	rgbacolor=[rgbacolor stringByReplacingOccurrencesOfString:@"rgba:" withString:@""];
	
	CGFloat r=1.0,g=1.0,b=1.0,a=1.0;
	int i=0;
	for(NSString *c in [rgbacolor componentsSeparatedByString:@","])
	{
		if(i==0)
			r=[c intValue];
		else if(i==1)
			g=[c intValue];
		else if(i==2)
			b=[c intValue];
		else
			a=[c floatValue];
		i++;
	}
	return [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.5 alpha:a];
}

+ (UIColor *)colorFromHEX: (NSString *)hexcolor
{
	hexcolor=[hexcolor lowercaseString];
	hexcolor=[hexcolor stringByReplacingOccurrencesOfString:@"hex(" withString:@""];
	hexcolor=[hexcolor stringByReplacingOccurrencesOfString:@")" withString:@""];
	hexcolor=[hexcolor stringByReplacingOccurrencesOfString:@"hex:" withString:@""];
	hexcolor=[hexcolor stringByReplacingOccurrencesOfString:@"#" withString:@""];
	
	hexcolor=[hexcolor uppercaseString];
	
	NSArray *comps=nil;
	
	if(hexcolor.length==3)
	{
		comps=[hexcolor componentsSeparatedByLength:1];
		NSString *hx=@"";
		for(NSString *c in comps)
		{
			hx=[hx stringByAppendingString:c];
			hx=[hx stringByAppendingString:c];
		}
		hexcolor=hx;
		comps=[hexcolor componentsSeparatedByLength:2];
	}
	else if(hexcolor.length==6)
	{
		comps=[hexcolor componentsSeparatedByLength:2];
	}
	else
	{
		return nil;
	}
	
	NSMutableArray *temp=[[[NSMutableArray alloc] init] autorelease];
	for(NSString *cs in comps)
	{
		unsigned int v;
		[[NSScanner scannerWithString:cs] scanHexInt:&v];
		[temp addObject:[NSString stringWithFormat:@"%d",v]];
	}
	NSString *rgbcolor=[NSString pathWithComponents:temp];
	rgbcolor=[rgbcolor stringByReplacingOccurrencesOfString:@"/" withString:@","];
	return [UIColor colorFromRGB:rgbcolor];
}

+(UIColor*)colorFromPattern:(NSString *)colorPattern
{	
	UIColor *colr=nil;
	if([colorPattern containsString:@"uikit:"])
	{
		SEL selector=NSSelectorFromString(colorPattern);
		if([UIColor instancesRespondToSelector:@selector(selector)])
		{
			colr=[UIColor performSelector:selector];
		}
	}
	if([colorPattern containsAnyOf:@"rgb:,rgb("])
	{
		colr=[UIColor colorFromRGB:colorPattern];
	}
	if([colorPattern containsAnyOf:@"rgba:,rgba("])
	{
		colr=[UIColor colorFromRGBA:colorPattern];
	}
	if([colorPattern containsAnyOf:@"hex:,hex(,#"])
	{
		colr=[UIColor colorFromHEX:colorPattern];
	}
	return colr;
}

@end