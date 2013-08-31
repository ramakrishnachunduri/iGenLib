//
//  iGenCustomFontLabel.m
//  iGenLib
//
//  Created by jey on 3/24/11.
//  Copyright 2011 CodeWorth. All rights reserved.
//

#import "iGenCustomFontLabel.h"

@implementation iGenCustomFontLabel
@synthesize fontName;
+(iGenCustomFontLabel*) labelWithFontName:(NSString*)fontName
{
	iGenCustomFontLabel *lbl=[[[iGenCustomFontLabel alloc] init] autorelease];
	lbl.fontName=fontName;
	return lbl;
}

-(void)drawRect:(CGRect)rect
{
	//[super drawRect:rect];
	NSString *fontPath = [[NSBundle mainBundle] pathForResource:self.fontName ofType:@"ttf"];
	//create a dataprovider from file name
	CGDataProviderRef fontDataProvider = CGDataProviderCreateWithFilename([fontPath UTF8String]);
	CGFontRef customFont=CGFontCreateWithDataProvider(fontDataProvider);
	CGDataProviderRelease(fontDataProvider);
	CGContextRef context = UIGraphicsGetCurrentContext();
	//CGContextClearRect(context, rect)
	// Set how the context draws the font, what color, how big.
	CGContextSetTextDrawingMode(context, kCGTextFillStroke);
	CGContextSetFillColorWithColor(context, self.textColor.CGColor); 
	CGContextSetStrokeColorWithColor(context, self.textColor.CGColor);
	CGContextSetFontSize(context, self.font.pointSize);
	// Create an array of Glyph's the size of text that will be drawn.
	
	//NSLog(@"%d",CGFontGetNumberOfGlyphs(customFont));
	// Loop through the entire length of the text.
	for (int i = 0; i < [self.text length]; ++i) 
	{ 
		if([self.text characterAtIndex:i]+3-32<CGFontGetNumberOfGlyphs(customFont))
		{
			CGGlyph textToPrint[1];
			textToPrint[0]=[self.text characterAtIndex:i]+3-32;
			CGContextSetFont(context, customFont);
			CGAffineTransform textTransform = CGAffineTransformMake(1.0, 0.0, 0.0, -1.0, 0.0, 0.0);
			CGContextSetTextMatrix(context, textTransform);
			CGContextShowGlyphsAtPoint(context, i*(self.font.pointSize), self.font.pointSize*3/2, textToPrint, 1);
		}
		else
		{
			/*
			CGGlyph textToPrint[1];
			textToPrint[0]=[self.text characterAtIndex:i]+3-32;
			NSLog(@"%d",CGFontGetNumberOfGlyphs(customFont));
			CGFontRef cgFont = CGFontCreateWithFontName((CFStringRef)@"Helvetica");
			CGContextSetFont(context, cgFont);
			CGAffineTransform textTransform = CGAffineTransformMake(1.0, 0.0, 0.0, -1.0, 0.0, 0.0);
			CGContextSetTextMatrix(context, textTransform);
			CGContextShowGlyphsAtPoint(context, i*(self.font.pointSize), self.font.pointSize*3/2, textToPrint, 1);
			CGFontRelease(cgFont);
			*/
		}

	}
	
	/*CGGlyph textToPrint[[self.text length]];
	// Loop through the entire length of the text.
	for (int i = 0; i < [self.text length]; ++i) 
	{ 
		// Store each letter in a Glyph and subtract the MagicNumber to get appropriate value.
		//textToPrint[i] = [[self.text uppercaseString] characterAtIndex:i] + 3 - 32;
		textToPrint[i]=[self.text characterAtIndex:i]+3-32;
		//NSLog(@"%d",textToPrint[i]);
	}
	CGAffineTransform textTransform = CGAffineTransformMake(1.0, 0.0, 0.0, -1.0, 0.0, 0.0);
	CGContextSetTextMatrix(context, textTransform);
	CGContextShowGlyphsAtPoint(context, 0, self.font.pointSize*3/2, textToPrint, [self.text length]);*/
	
	CGFontRelease(customFont);
}

@end
