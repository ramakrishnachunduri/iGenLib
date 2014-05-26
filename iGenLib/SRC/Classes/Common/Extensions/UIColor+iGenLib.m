/*! 
 *  \brief     UIColor+iGenLib.
 *  \details   iGenLib Extensions for UIColor.
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

#import "UIColor+iGenLib.h"
#import "NSString+iGenLib.h"

@implementation UIColor (iGenLib)

/**
 * Creates the color from the passed RGB(Red,Green,Blue) pattern
 * @return returns the respective color object to the RGB pattern.
 * @param rgbcolor : RGB color pattern to generate the color from. RGB patterns are listed below
 * \li @@"rgb:(255,255,255,1.0)"
 * \li @@"rgb:255,255,255,1.0"
 */
+(UIColor*)colorFromRGB:(NSString*)rgbcolor
{
	rgbcolor=[rgbcolor lowercaseString];
	NSString *rgbacolor=[rgbcolor stringByReplacingOccurrencesOfString:@"rgb(" withString:@"rgba("];
	rgbacolor=[rgbacolor stringByReplacingOccurrencesOfString:@")" withString:@",1.0)"];
	
	return [UIColor colorFromRGBA:rgbacolor];
}

/**
 * Creates the color from the passed RGBA(Red,Green,Blue,Alpha) pattern
 * @return returns the respective color object to the RGBA pattern.
 * @param rgbacolor : RGBA color pattern to generate the color from. RGBA patterns are listed below
 * \li @@"rgba:(255,255,255,1.0)"
 * \li @@"rgba:255,255,255,1.0"
 */
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

/**
 * Creates the color from the passed hexadecimal pattern
 * @return returns the respective color object to the hexadecimal pattern.
 * @return nil if a wrong hexadecimal pattern is used.
 * @param hexcolor : hexadecimal color pattern to generate the color from. hexadecimal patterns are listed below
 * \li @@"hex:FFCCAA"
 * \li @@"hex(FFCCAA)"
 * \li @@"#FFCCAA"
 * 
 * Supports 3 char hexadecimal colors also as below
 * \li @@"hex:CCD"
 * \li @@"hex(CCD)"
 * \li @@"#CCD"
 */
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

/**
 * Creates the color from the passed pattern
 * @return returns the respective color object to the passed pattern.
 * @return nil if a wrong pattern is used.
 * @param colorPattern : color pattern to generate the color from. Patterns Supported are listed below
 * \li @@"uikit:redColor"
 * \li @@"rgb(255,255,255)" (or) @@"rgb:255,255,255"
 * \li @@"rgba:(255,255,255,1.0)" (or) @@"rgba:255,255,255,1.0"
 * \li @@"hex:FFCCAA" (or) @@"hex(FFCCAA)" (or) @@"#FFCCAA"
 * \li Supports 3 char hexadecimal colors also  @@"hex:CCD" (or) @@"hex(CCD)" (or) @@"#CCD"
 */
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