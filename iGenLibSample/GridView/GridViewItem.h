//
//  GridViewItem.h
//  GridView
//
//  Created by jey on 12/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GridViewItem : UIView 
{
	IBOutlet UIImageView *imageView;
	IBOutlet UILabel *label;
}
@property(nonatomic,retain) IBOutlet UIImageView *imageView;
@property(nonatomic,retain) IBOutlet UILabel *label;
@end
