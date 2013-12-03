//
//  MenuViewController.h
//  iGenLibSample
//
//  Created by Rama Krishna Chunduri on 4/20/11.
//  Copyright 2011 CodeWorth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iGenSampleBaseVC.h"

@interface MenuViewController : iGenSampleBaseVC <UITableViewDataSource,UITableViewDelegate>
{
	NSObject *menuItems;
	IBOutlet UITableView *myTableView;
}
@property(nonatomic,retain) NSObject *menuItems;
@property(nonatomic,retain) IBOutlet UITableView *myTableView;
@end