//
//  iGenCustomFontLabel.h
//  iGenLib
//
//  Created by jey on 3/24/11.
//  Copyright 2011 CodeWorth. All rights reserved.
//
#import <UIKit/UIKit.h>
@interface iGenCustomFontLabel : UILabel
{
	NSString *fontName;
}
@property(nonatomic,retain) NSString *fontName;
+(iGenCustomFontLabel*) labelWithFontName:(NSString*)fontName;
@end
