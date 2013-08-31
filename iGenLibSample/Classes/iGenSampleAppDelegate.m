//
//  iGenSampleAppDelegate.m
//  iGenLibSample
//
//  Created by jey on 4/20/11.
//  Copyright 2011 CodeWorth. All rights reserved.
//

#import "iGenSampleAppDelegate.h"
#import "MenuViewController.h"

@interface iGenSampleAppDelegate()
@property(nonatomic,retain) UINavigationController *navigationController;
@property(nonatomic,retain) UISplitViewController *splitViewController;
@end

@implementation iGenSampleAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize splitViewController;

#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{    
	// Override point for customization after application launch.
	
	    MenuViewController *masterViewController = [[[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil] autorelease];
		masterViewController.title=@"iGenLib & Samples";
	    navigationController = [[UINavigationController alloc] initWithRootViewController:masterViewController];
		self.navigationController.navigationBar.tintColor=[UIColor blackColor];
	    [self.window addSubview:navigationController.view];
	
	/*
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
	{
	}
	else
	{
	    MenuViewController *masterViewController = [[[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil] autorelease];
		masterViewController.title=@"iGenLib Menu";
	    UINavigationController *masterNavigationController = [[[UINavigationController alloc] initWithRootViewController:masterViewController] autorelease];
	    masterNavigationController.navigationBar.tintColor=[UIColor blackColor];
		
	    UIViewController *detailViewController = [[[UIViewController alloc] init] autorelease];
		detailViewController.title=@"Samples";
	    UINavigationController *detailNavigationController = [[[UINavigationController alloc] initWithRootViewController:detailViewController] autorelease];
		detailNavigationController.navigationBar.tintColor=[UIColor blackColor];
		
	    splitViewController = [[[UISplitViewController alloc] init] autorelease];
		splitViewController.delegate=self;
	    self.splitViewController.viewControllers = [NSArray arrayWithObjects:masterNavigationController, detailNavigationController, nil];
	    
		[self.window addSubview:splitViewController.view];
	}
	*/
    
	[self.window makeKeyAndVisible];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

