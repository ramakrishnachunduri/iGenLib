/*!
 * \brief		iGenPaddedTextField
 * \details		A subclass of UITextField that lets you specify padding.\n \n
 * This file is part of iGenLib. iGenLib is comprehensive library that provide a common way to integrate and reuse the components across other iOS apps
 * \author		Rama Krishna Chunduri
 * \date		24th Feb 2014
 * \copyright	CodeWorth 2014, All rights reserved.
 * @ingroup		Padded-UI-Elements
 */

#import "iGenPaddedTextField.h"

@implementation iGenPaddedTextField

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        self.edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return [super textRectForBounds:UIEdgeInsetsInsetRect(bounds, self.edgeInsets)];
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [super editingRectForBounds:UIEdgeInsetsInsetRect(bounds, self.edgeInsets)];
}

@end