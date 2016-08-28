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

@interface iGenCommon : NSObject 
{
}
+(NSData *)getWebData:(NSString *)urlString;
@end