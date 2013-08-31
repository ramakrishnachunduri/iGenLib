//
//  MoveAndScaleVC.h
//  iGenLibSample
//
//  Created by Rama Krishna Chunduri on 2/15/11.
//  Copyright 2011 CodeWorth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iGenImageScaleController.h"

@interface MoveAndScaleVC : UIViewController<UIScrollViewDelegate,iGenImageScaleControllerDelegate>
{
	
}
-(void)onclickImage:(UIImageView*)sender;
@end
