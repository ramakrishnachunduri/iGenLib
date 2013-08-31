//
//  iGenXMLVC.h
//  iLib
//
//  Created by Krish on 08/02/11.
//  Copyright 2011 CSS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iGenCommon.h>
@interface iGenXMLVC : UIViewController<XMLBuilderDelegate> 
{	
	NSString *shrxml;
}
@property(nonatomic,retain) NSString *shrxml;
-(IBAction)startDicToXML;
-(IBAction)startXMLtoDic;
@end

