#import "iGenBaseVC.h"
#import "iGenTools.h"

@interface iGenBaseVC()
{
	UIToolbar	*_keyboardToolbar;
}
@property (nonatomic, readonly) UIToolbar *keyboardToolbar;
@property (nonatomic, strong)	NSDictionary *lastRecievedKeyboardInfo;
@end

@implementation iGenBaseVC

@synthesize keyboardToolbar=_keyboardToolbar,keyBoardToolbarNeeded;

#pragma mark VC Life cycle

-(void)setExclusiveTouchToChildrenOf:(NSArray *)subviews
{
    for (UIView *v in subviews)
	{
		[v setMultipleTouchEnabled:NO];
		
        [self setExclusiveTouchToChildrenOf:v.subviews];
        if ([v isKindOfClass:[UIButton class]])
		{
            UIButton *btn = (UIButton *)v;
            [btn setExclusiveTouch:YES];
        }
    }
}

-(void)disableMultiTouches
{
	[self setExclusiveTouchToChildrenOf:self.view.subviews];
	[self setExclusiveTouchToChildrenOf:self.navigationController.navigationBar.subviews];
}

- (void)viewDidLoad
{
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
	
	[self registerKeyboardNotificationCenter];
	
    [super viewDidLoad];
	
	[self disableMultiTouches];
}

-(void)viewDidUnload
{
	[self unRegisterKeyboardNotificationCenter];
	[super viewDidUnload];
}

-(void)viewWillAppear:(BOOL)animated
{
	self.navigationItem.title=self.title;
	[super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
	self.navigationItem.title=self.title;
	[super viewDidAppear:animated];
	[self disableMultiTouches];
}

#pragma mark -
#pragma mark autorotation handling

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

-(BOOL)shouldAutorotate
{
	// return NO;
	UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
	// Return yes to allow the device to load initially.
	if (orientation == UIDeviceOrientationUnknown) return YES;
	// Pass iOS 6 Request for orientation on to iOS 5 code. (backwards compatible)
	BOOL result = [self shouldRotateToInterfaceOrientation:(UIInterfaceOrientation)orientation];
	return result;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
	
	return UIInterfaceOrientationPortrait;
}

- (BOOL)shouldRotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation==UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return [self shouldRotateToInterfaceOrientation:interfaceOrientation];
}

#pragma mark -
#pragma mark modal animations

-(BOOL)isCustomAnimationsNeededForModals
{
	return NO;
}

-(NSObject<UIViewControllerAnimatedTransitioning>*)animationForPresentingView
{
	return nil;
}

-(NSObject<UIViewControllerAnimatedTransitioning>*)animationForDismissingView
{
	return nil;
}

-(void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion
{
	if([NSStringFromClass([viewControllerToPresent class]) isEqualToString:@"MFMailComposeViewController"])
	{
		//ignore for email
	}
	else
	{
		if([self isCustomAnimationsNeededForModals])
		{
			viewControllerToPresent.transitioningDelegate=self;
			viewControllerToPresent.modalPresentationStyle=UIModalPresentationCustom;
		}
	}
	
	[super presentViewController:viewControllerToPresent animated:flag completion:completion];
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [self animationForPresentingView];
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
	return [self animationForDismissingView];
}

#pragma mark -
#pragma mark Alerts

-(void)presentAlertMessage:(NSString*)message
{
    [self presentAlertMessage:message withTag:GENERAL_ALERT_TAG];
}

-(void)presentAlertMessage:(NSString*)message withTag:(NSInteger)tag
{
    NSString *prodName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
	[self presentAlertMessage:message withTitle:prodName andTag:tag];
}

-(void)presentAlertMessage:(NSString*)message withTitle:(NSString*)alertTitle andTag:(NSInteger)tag
{
	UIAlertView *alert=[[UIAlertView alloc] initWithTitle:alertTitle message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    alert.tag=tag;
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
}

#pragma mark -
#pragma mark Keyboard

-(BOOL)isKeyBoardListeningActive
{
	return YES;
}

-(void)triggerKeyboardShown
{
	if(self.lastRecievedKeyboardInfo)
	{
		[[NSNotificationCenter defaultCenter] postNotificationName:UIKeyboardWillShowNotification object:nil userInfo:self.lastRecievedKeyboardInfo];
	}
}

-(UIToolbar*)keyboardToolbar
{
	if(_keyboardToolbar==nil)
	{
		CGRect screenRct=[UIScreen mainScreen].bounds;
		_keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenRct.size.height,screenRct.size.width,44)];
		//keyboardToolbar.barStyle = UIBarStyleBlackTranslucent;
		_keyboardToolbar.tintColor = [UIColor blackColor];
		_keyboardToolbar.barTintColor = [UIColor colorWithRed:198.0f/255.0f green:210.0f/255.0f blue:217.0f/255.0f alpha:1.0f];
		
		_keyboardToolbar.autoresizingMask=UIViewAutoresizingFlexibleTopMargin;
		
		UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
		UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissKeyboard:)];
		UIBarButtonItem *fix = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
		fix.width=10;
		NSArray *items = [[NSArray alloc] initWithObjects: flex, done, fix, nil];
		[_keyboardToolbar setItems:items];
		[items release];
		[flex release];
		[fix release];
	}
	
	return _keyboardToolbar;
}

-(NSArray*)leftButtonsInKeyBoard
{
	return nil;
}

-(void)keyboardDidAppearedAtTop:(CGFloat)keyTop
{
	if([self leftButtonsInKeyBoard]!=nil)
	{
		NSMutableArray *oldButtons=[NSMutableArray array];
		NSInteger idx=0;
		for(UIBarButtonItem *bt in [self.keyboardToolbar.items reverseObjectEnumerator])
		{
			idx++;
			[oldButtons addObject:bt];
			if(idx==3)
			{
				break;
			}
		}
		NSArray *oldBtns=[[oldButtons reverseObjectEnumerator] allObjects];
		NSMutableArray *newButtons=[NSMutableArray array];
		[newButtons addObjectsFromArray:[self leftButtonsInKeyBoard]];
		[newButtons addObjectsFromArray:oldBtns];
		self.keyboardToolbar.items=newButtons;
	}
}

-(void)keyboardDidDisappeared
{
	
}

-(void)activeKeyboardFieldChanged
{
	
}

-(void)registerKeyboardNotificationCenter
{
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)unRegisterKeyboardNotificationCenter
{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

-(void)dismissKeyboard:(id)sender
{
	[[self.view findFirstResponder] resignFirstResponder];
}

- (void)keyboardDidShow:(NSNotification *)notification
{
	DEBUGLogBegin(keyboardDidShow:);
	if([self isKeyBoardListeningActive])
	{
		
	}
}

- (void)keyboardWillShow:(NSNotification *)notification
{
	if([self isKeyBoardListeningActive])
	{
		DEBUGLogBegin(keyboardWillShow:);
		
		[self activeKeyboardFieldChanged];
		
		self.lastRecievedKeyboardInfo=[notification userInfo];
		
		NSTimeInterval animationDuration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
		CGPoint beginCentre = [[[notification userInfo] valueForKey:@"UIKeyboardCenterBeginUserInfoKey"] CGPointValue];
		//CGPoint endCentre = [[[notification userInfo] valueForKey:@"UIKeyboardCenterEndUserInfoKey"] CGPointValue];
		CGRect keyboardBounds = [[[notification userInfo] valueForKey:@"UIKeyboardBoundsUserInfoKey"] CGRectValue];
		UIViewAnimationCurve animationCurve	= [[[notification userInfo] valueForKey:@"UIKeyboardAnimationCurveUserInfoKey"] intValue];
		
		if(self.isKeyBoardToolbarNeeded)
		{
			UIWindow *mainWindow=[UIApplication sharedApplication].keyWindow;
			[mainWindow addSubview:self.keyboardToolbar];
			
			self.keyboardToolbar.hidden=NO;
			
			CGRect keyToolBarFrame=self.keyboardToolbar.frame;
			keyToolBarFrame.origin.y=beginCentre.y - (keyboardBounds.size.height/2) - self.keyboardToolbar.frame.size.height;
			self.keyboardToolbar.alpha = 0.0;
			
			[UIView beginAnimations:@"RS_showKeyboardAnimation" context:nil];
			[UIView setAnimationCurve:animationCurve];
			[UIView setAnimationDuration:animationDuration];
			
			[UIView setAnimationDelegate:self];
			
			CGFloat keyToolTop=self.view.frame.size.height - (keyboardBounds.size.height+self.keyboardToolbar.frame.size.height);
			keyToolTop+=(self.view.frame.origin.y)*2;
			keyToolBarFrame.origin.y=keyToolTop;
			self.keyboardToolbar.frame = keyToolBarFrame;
			self.keyboardToolbar.alpha = 1.0;
			
			[self keyboardDidAppearedAtTop:keyToolTop];
			
			[UIView commitAnimations];
		}
		else
		{
			if(_keyboardToolbar!=nil) { self.keyboardToolbar.hidden=YES; };
			
			[UIView beginAnimations:@"RS_showKeyboardAnimation" context:nil];
			[UIView setAnimationCurve:animationCurve];
			[UIView setAnimationDuration:animationDuration];
			
			CGFloat keyToolTop=self.view.frame.size.height - keyboardBounds.size.height;
			keyToolTop+=(self.view.frame.origin.y)*2;
			[self keyboardDidAppearedAtTop:keyToolTop];
			
			[UIView commitAnimations];
		}
	}
}

- (void)keyboardWillHide:(NSNotification *)notification
{
	if([self isKeyBoardListeningActive])
	{
		self.lastRecievedKeyboardInfo=nil;
		if(self.isKeyBoardToolbarNeeded)
		{
			NSTimeInterval animationDuration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
			
			UIViewAnimationCurve animationCurve	= [[[notification userInfo] valueForKey:@"UIKeyboardAnimationCurveUserInfoKey"] intValue];
			
			[UIView beginAnimations:@"RS_hideKeyboardAnimation" context:nil];
			[UIView setAnimationCurve:animationCurve];
			[UIView setAnimationDuration:animationDuration];
			CGRect keyToolBarFrame=self.keyboardToolbar.frame;
			CGRect screenRct=[UIScreen mainScreen].bounds;
			keyToolBarFrame.origin.y=screenRct.size.height;
			self.keyboardToolbar.frame = keyToolBarFrame;
			self.keyboardToolbar.alpha = 0.0;
			
			[self keyboardDidDisappeared];
			
			[UIView commitAnimations];
		}
		else
		{
			[self keyboardDidDisappeared];
		}
	}
}

#pragma mark -

@end