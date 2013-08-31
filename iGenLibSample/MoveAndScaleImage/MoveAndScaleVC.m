//
//  MoveAndScaleVC.m
//  iGenLibSample
//
//  Created by Rama Krishna Chunduri on 2/15/11.
//  Copyright 2011 CodeWorth. All rights reserved.
//

#import "MoveAndScaleVC.h"
@implementation MoveAndScaleVC

#pragma mark UIViewController Life Cycle Methods
-(void)viewDidLoad
{
	[super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated
{
	if(((UIImageView*)[self.view viewWithTag:20]).image==nil)
	{
		((UIImageView*)[self.view viewWithTag:20]).image=[UIImage imageNamed:@"apples.jpg"];
	}
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch=[touches anyObject];
	if([touch.view isKindOfClass:[UIImageView class]])
	{
		[self onclickImage:(UIImageView*)touch.view];
	}
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
	[super viewDidUnload];
}

- (void)dealloc
{
	[super dealloc]; 
}


-(void)onclickImage:(UIImageView*)sender
{
	iGenImageScaleController *ripscaler=[[iGenImageScaleController alloc] initWithImage:[UIImage imageNamed:@"apples.jpg"] delegate:self];
	[self presentModalViewController:ripscaler animated:YES];
	[ripscaler release];
}

-(void)imageScalerWillShow:(iGenImageScaleController *)picker
{
	UIToolbar *toolBar=(UIToolbar *)[picker.view.subviews lastObject];
	toolBar.tintColor=[UIColor blackColor];
}

-(void)imageScaler:(iGenImageScaleController *)picker didFinishedScalingImage:(UIImage *)image
{
	((UIImageView*)[self.view viewWithTag:20]).image=image;
}

-(void)imageScalerDidCancel:(iGenImageScaleController *)picker
{
	NSLog(@"scaler is cancelled");
}
@end
