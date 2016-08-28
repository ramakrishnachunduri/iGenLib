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

#define RELEASE_SAFELY(__POINTER){[__POINTER release]; __POINTER = nil;}

@interface iGenCommon : NSObject 
{
}
+(NSData *)getWebData:(NSString *)urlString;
@end