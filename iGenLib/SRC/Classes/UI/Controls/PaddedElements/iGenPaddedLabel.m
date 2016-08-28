/*!
 * \brief		iGenPaddedLabel
 * \details		A subclass of UILabel that lets you specify padding.\n \n
 * This file is part of iGenLib. iGenLib is comprehensive library that provide a common way to integrate and reuse the components across other iOS apps
 * \author		Rama Krishna Chunduri
 * \date		24th Feb 2014
 * \copyright	CodeWorth 2014, All rights reserved.
 * @ingroup		Padded-UI-Elements
 */

#import "iGenPaddedLabel.h"

@implementation iGenPaddedLabel

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.edgeInsets)];
}

@end