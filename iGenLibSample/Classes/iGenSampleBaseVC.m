//
//  MenuViewController.m
//  iGenLibSample
//
//  Created by Rama Krishna Chunduri on 4/20/11.
//  Copyright 2011 CodeWorth. All rights reserved.
//

#import "iGenSampleBaseVC.h"

#import <NSObject+GeneralExtensions.m>

@implementation iGenSampleBaseVC

#pragma mark memory management methods

- (void)dealloc
{
	
	[super dealloc];
}

#pragma mark -
#pragma mark View lifecycle

-(void)setEdgesForcontroller:(UIViewController*)vc
{
	if(IS_DEVICE_RUNNING_IOS_7_AND_ABOVE())
	{
		[vc performSelector:@selector(setEdgesForExtendedLayout:) withValues:UIRectEdgeNone,nil];
		[vc performSelector:@selector(setExtendedLayoutIncludesOpaqueBars:) withValues:YES,nil];
		[vc performSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:) withValues:NO,nil];
	}
}

- (void)viewDidLoad
{
	[self setEdgesForcontroller:self];
	
	[super viewDidLoad];
}

#pragma mark -
@end