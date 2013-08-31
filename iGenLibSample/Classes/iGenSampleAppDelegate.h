//
//  iGenSampleAppDelegate.h
//  iGenLibSample
//
//  Created by jey on 4/20/11.
//  Copyright 2011 CodeWorth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iGenSampleAppDelegate : NSObject <UIApplicationDelegate,UISplitViewControllerDelegate>
{
    UIWindow *window;
    UINavigationController *navigationController;
	UISplitViewController *splitViewController;
}

@property(nonatomic,retain) IBOutlet UIWindow *window;

@end

