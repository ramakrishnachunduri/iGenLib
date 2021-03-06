#import "iGenImageScaleController.h"
#import "iGenTools.h"
#define CONTENT_IMAGE_VIEW_TAG 100

@interface iGenImageScaleController ()
@property(nonatomic,readonly) UIView *contentView;
@property(nonatomic,readonly) UIToolbar *bottomToolBar;
@end

@implementation iGenImageScaleController

//synthesize readonly
@synthesize contentView=_contentView,bottomToolBar=_bottomToolBar;

//synthesize assigned
@synthesize delegate=_delegate;

#pragma mark ReadOnly methods

-(UIView*)contentView
{
	if(_contentView==nil) //ensure only one instance is used
	{
		//calculate the position and frame
		CGRect frameToContentView=self.view.frame;
		frameToContentView.origin.y=0;
		frameToContentView.size.height=frameToContentView.size.height-44;

		_contentView=[[UIView alloc] initWithFrame:frameToContentView];
		
		//create instance when no existing instance found
		UIScrollView *contentScrollView=[[UIScrollView alloc] initWithFrame:frameToContentView];
		contentScrollView.delegate=self;
		contentScrollView.scrollEnabled=YES;
		contentScrollView.canCancelContentTouches=TRUE;
		contentScrollView.minimumZoomScale=1.00;
		contentScrollView.maximumZoomScale=100.00;
		contentScrollView.showsHorizontalScrollIndicator=NO;
		contentScrollView.showsVerticalScrollIndicator=NO;
		
		UIImageView *imageview=[[UIImageView alloc] initWithFrame:_contentView.frame];
		imageview.tag=CONTENT_IMAGE_VIEW_TAG;
		imageview.userInteractionEnabled=NO;
		imageview.contentMode=UIViewContentModeScaleAspectFit;
		[contentScrollView addSubview:imageview];
		[imageview release];
		
		[_contentView addSubview:contentScrollView];
		[contentScrollView release];
	}
	return _contentView;
}

-(UIToolbar*)bottomToolBar
{
	if(_bottomToolBar==nil) //ensure only one instance is used
	{
		//calculate the position and frame
		CGRect frameToToolBar=self.view.frame;
		frameToToolBar.origin.y=frameToToolBar.size.height-44;
		frameToToolBar.size.height=44;
		
		//create instance when no existing instance found
		_bottomToolBar=[[UIToolbar alloc] initWithFrame:frameToToolBar];
		
		//add buttons
		UIBarButtonItem *useButton=[[UIBarButtonItem alloc] initWithTitle:@"Use" style:UIBarButtonItemStyleBordered target:self action:@selector(onclickUse)];
		CGSize useButtonSize=[useButton.title sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:12.0f]];
		UIBarButtonItem *cancelButton=[[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(onClickCancel)];
		CGSize cancelButtonSize=[cancelButton.title sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:12.0f]];
		UIBarButtonItem *flexSpace=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
		flexSpace.width=frameToToolBar.size.width-useButtonSize.width-cancelButtonSize.width-60;
		[_bottomToolBar setItems:[NSArray arrayWithObjects:cancelButton,flexSpace,useButton,nil]];
		[flexSpace release];
		[cancelButton release];
		[useButton release];
	}
	return _bottomToolBar;
}

#pragma mark -
#pragma mark initializers

-(void)renderSubViews
{
	//do initialization steps
	[self.view addSubview:self.contentView];
	[self.view addSubview:self.bottomToolBar];
}

-(iGenImageScaleController*)initWithImage:(UIImage*)image delegate:(id<iGenImageScaleControllerDelegate>)delegate;
{
	if(self=[super init])
	{
		self.delegate=delegate;
		
		((UIImageView*)[self.contentView viewWithTag:CONTENT_IMAGE_VIEW_TAG]).image=image;
		
		self.view.backgroundColor=[UIColor colorWithRed:0.23 green:0.25 blue:0.25 alpha:1];
	}
	return self;
}

#pragma mark -
#pragma mark UIViewController Life Cycle Methods

-(void)viewWillAppear:(BOOL)animated
{
	[self renderSubViews];
	
	if([self.delegate respondsToSelector:@selector(imageScalerWillShow:)])
	{
		[self.delegate imageScalerWillShow:self];
	}
	
	[super viewWillAppear:YES];
}

-(void)dealloc
{
	RELEASE_SAFELY(_contentView);
	RELEASE_SAFELY(_bottomToolBar);
	[super dealloc];
}

#pragma mark -
#pragma mark User Interaction Methods

-(void)dismissScalingScreen
{
	if([self.parentViewController isKindOfClass:[UINavigationController class]])
	{
		[self.navigationController popViewControllerAnimated:YES];
	}
	else
	{
		[self dismissModalViewControllerAnimated:YES];
	}
}

-(void)onclickUse
{
	UIImage *snapshot=[self.contentView toImage];
	if([self.delegate respondsToSelector:@selector(imageScaler:didFinishedScalingImage:)])
	{
		[self.delegate imageScaler:self didFinishedScalingImage:snapshot];
	}
	[self dismissScalingScreen];
}

-(void)onClickCancel
{
	if([self.delegate respondsToSelector:@selector(imageScalerDidCancel:)])
	{
		[self.delegate imageScalerDidCancel:self];
	}
	
	[self dismissScalingScreen];
}

#pragma mark -
#pragma mark Scrollview delegate methods

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)aScrollView 
{
	NSLog(@"viewForZoomingInScrollView");
	return [aScrollView viewWithTag:CONTENT_IMAGE_VIEW_TAG];
}

- (void)scrollViewDidEndZooming:(UIScrollView *)aScrollView withView:(UIView *)view atScale:(float)scale 
{
	NSLog(@"scrollViewDidEndZooming");
}

#pragma mark -
@end