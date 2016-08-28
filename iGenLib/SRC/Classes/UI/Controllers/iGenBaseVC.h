/** @defgroup UI-Controllers iGenBaseViewControllers
 *  These are View Controller subclasses lets you perform common tasks across multiple projects
 */

#import <UIKit/UIKit.h>
#define  GENERAL_ALERT_TAG 100
#import "UIView+iGenLib.h"

/*!
 * \brief		iGenBaseVC
 * \details		A subclass of UIViewController which can be further subclassed to eradicate lots of re-work being done in VC Level.\n \n
 * 	This file is part of iGenLib. iGenLib is comprehensive library that provide a common way to integrate and reuse the components across other iOS apps
 * \n
 * \n			This class does following stuff
 *				- Orientation and AutoRotation handling.
 *				- ModalView Presentation and Transition handling
 *				- Easier AlertView access methods
 *				- Keyboard Handling
 *					- Tool bar which can be shown when showing numeric keypads (as they dont have done)
 *					- Essential overridable methods allows to resize interface accordingly when keyboard is shown/hidden
 *
 *
 * \author		Rama Krishna Chunduri
 * \date		24th December 2014
 * \copyright	CodeWorth 2014, All rights reserved.
 * \n
 * @ingroup		UI-Controllers
 */
@interface iGenBaseVC : UIViewController<UIAlertViewDelegate,UIViewControllerTransitioningDelegate>
{
	
}
/**
 *  A property that lets subclasses decide if keyboard toolbar is needed
 *  override isKeyBoardToolbarNeeded and return boolean accordingly to handle it.
 */
@property(nonatomic,assign,getter = isKeyBoardToolbarNeeded) BOOL keyBoardToolbarNeeded;

#pragma mark orientation

/**
 *  Overridable method by which subclass can specify orientations to be used without messing with iOS6/iOS7 methods
 *  @param interfaceOrientation orientation view is about to rotate
 *  @return decision making bookean lets View respont to orientation changes
 */
- (BOOL)shouldRotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;

#pragma mark -
#pragma mark modal animations

/**
 *  A method to decide if UI presentation layer uses custom transition when presenting modal views
 *  By default this stays NO and no transitions/animations will be used
 *  Note that the transitions wont be applied for email composer as it is prohibited
 *  @return Boolean stating animation necessity
 */
-(BOOL)isCustomAnimationsNeededForModals;

/**
 *  Must be overriden when isCustomAnimationsNeededForModals is YES
 *  @return UIViewControllerAnimatedTransitioning object to be used when presenting with animation
 */
-(NSObject<UIViewControllerAnimatedTransitioning>*)animationForPresentingView;

/**
 *  Must be overriden when isCustomAnimationsNeededForModals is YES
 *  @return UIViewControllerAnimatedTransitioning object to be used when dismissing modal after it is presented with animation
 */
-(NSObject<UIViewControllerAnimatedTransitioning>*)animationForDismissingView;

#pragma mark -
#pragma mark Alerts

/**
 *  Presents an alert message whose delegate is subclass itself
 *  A handy method that helps preventing writing few lines of code everytime alert is to be shown
 *  @param message Message to display
 */
-(void)presentAlertMessage:(NSString*)message;

/**
 *  Presents an alert message whose delegate is subclass itself
 *  A handy method that helps preventing writing few lines of code everytime alert is to be shown
 *  @param message Message to display
 *  @param tag     a unique number to uniquely identify alerts being shown
 */
-(void)presentAlertMessage:(NSString*)message withTag:(NSInteger)tag;

/**
 *  Presents an alert message whose delegate is subclass itself
 *  A handy method that helps preventing writing few lines of code everytime alert is to be shown
 *  @param message    Message to display
 *  @param alertTitle title for alert message
 *  @param tag        a unique number to uniquely identify alerts being shown
 */
-(void)presentAlertMessage:(NSString*)message withTitle:(NSString*)alertTitle andTag:(NSInteger)tag;

#pragma mark -
#pragma mark Keyboard

/**
 *  Decides if keyboard listener should be active on the VC
 *  When the view controller doesn't involve any textboxes it is optional to return No for it
 *  @return Boolean that ommits/activates keyboard listener
 */
-(BOOL)isKeyBoardListeningActive;

/**
 *  Triggers keyboard shown explicitly
 */
-(void)triggerKeyboardShown;

/**
 * Array of left buttons in toolbar of keyboard.
 */
-(NSArray*)leftButtonsInKeyBoard;

/**
 *  A notifying method that is triggered when keyboard is shown
 *  This method can be overriden by subclasses allowing them to resize the ui respectively to utilize available spave on screen
 *  @param keyTop the position of keyboard where it is started from, would vary based on keyboard toolbar visibility
 */
-(void)keyboardDidAppearedAtTop:(CGFloat)keyTop;

/**
 *  A notifying method triggered when keyboard is hidden
 *  This method cab be overriden by subclasses allowing to resize ui to utilize full space on screen
 */
-(void)keyboardDidDisappeared;

/**
 *  Notifies that keyboard field is changed while keyboard is still displayed
 */
-(void)activeKeyboardFieldChanged;

#pragma mark -

@end