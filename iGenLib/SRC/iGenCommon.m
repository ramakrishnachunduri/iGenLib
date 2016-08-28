//
//  iGenCommon.h
//  CodeWorth
//
//  Created by Rama Krishna Chunduri on 11/06/10.
//  Copyright 2010 CodeWorth. All rights reserved.
//

#import "iGenCommon.h"

@implementation iGenCommon

+(NSData *)getWebData:(NSString *)urlString
{
	urlString = [urlString	stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]; 
	NSURL *url=[[NSURL alloc] initWithString:urlString];
	NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
	NSData *urlData;
	NSURLResponse *response;
	NSError *error;
	urlData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
	NSLog(@"error %@",error);
	[url release];
	return urlData;
}
@end







