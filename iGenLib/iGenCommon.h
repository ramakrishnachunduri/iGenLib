//
//  iGenCommon.h
//  CodeWorth
//
//  Created by Rama Krishna Chunduri on 11/06/10.
//  Copyright 2010 CodeWorth. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>


#import "iGenLIBExtensions.h"

#import "NSObject+XML+iGenLIB.h"
#import "XMLReader.h"

#pragma mark IOS Version Checks

/* 7.0 and above falls in here */
#define IS_DEVICE_RUNNING_IOS_7_AND_ABOVE()	([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending)

/* 6.0, 6.0.x, 6.1, 6.1.x falls here*/
#define IS_DEVICE_RUNNING_IOS_6_OR_BELOW()	([[[UIDevice currentDevice] systemVersion] compare:@"6.2" options:NSNumericSearch] != NSOrderedDescending)

/* Any version below 6.0 like 5.1,5.0,3.2 etc will fall in here - but since app is targeted for 5 and above, use this method to determine running on ios 5.x */
#define IS_DEVICE_RUNNING_IOS_5_X()			([[[UIDevice currentDevice] systemVersion] compare:@"6.0" options:NSNumericSearch] == NSOrderedAscending)

#pragma mark -

#define RELEASE_SAFELY(__POINTER){[__POINTER release]; __POINTER = nil;}

@interface iGenCommon : NSObject 
{
}
+ (float)ScreenHeight;
+ (float)ScreenWidth;
+(NSData *)getWebData:(NSString *)urlString;
@end