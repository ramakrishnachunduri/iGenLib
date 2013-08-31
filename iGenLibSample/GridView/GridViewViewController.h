//
//  GridViewViewController.h
//  GridView
//
//  Created by jey on 12/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "iGenCommon.h"
#import <iGenGridView.h>
@interface GridViewViewController : UIViewController <iGenGridViewDelegate>
{
	NSMutableArray *titles;
	NSMutableArray *images;
	
	BOOL isPagingEnabled;
	
	iGenGridView *gridView;
}
@property(nonatomic,retain) NSMutableArray *titles;
@property(nonatomic,retain) NSMutableArray *images;
@property(nonatomic,assign) BOOL isPagingEnabled;
@end

