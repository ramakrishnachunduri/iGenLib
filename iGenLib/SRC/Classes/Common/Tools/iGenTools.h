#import <Foundation/Foundation.h>

void extendedLog(NSString* extendedInfo, NSString* format, ...);

/** @defgroup Tools iGenTools
 *  This class holds reusable macros
 *
 *  macros help to create short pre-defined utility functions and
 *	make them reusable across multple class/projects
 *  @{
 */

#pragma mark Device Info

/**
 * Determines if the device is running on iOS v8 and above.
 * \n A macro that helps to decide and do iOS 8 optimizations when app is also targetted for ios below 8
 */
#define IS_DEVICE_RUNNING_IOS_8_AND_ABOVE()	([[[UIDevice currentDevice] systemVersion] compare:@"8.0" options:NSNumericSearch] != NSOrderedAscending)


/**
 * Determines if the device is running on iOS v7 and above.
 * \n A macro that helps to decide and do iOS 7 optimizations when app is also targetted for ios below 7
 */
#define IS_DEVICE_RUNNING_IOS_7_AND_ABOVE()	([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending)

/**
 * Determines if the device is running on iOS v6 or below.
 * \n A macro that helps to decide and do iOS 6 optimizations when app is also targetted for ios below 6
 * \n IOS 6.0, 6.0.x, 6.1, 6.1.x falls here
 */
#define IS_DEVICE_RUNNING_IOS_6_OR_BELOW()	([[[UIDevice currentDevice] systemVersion] compare:@"6.2" options:NSNumericSearch] != NSOrderedDescending)

/**
 * Determines if the device is running on iOS v5 or below.
 * \n A macro that helps to decide and ommit optimizations not targeted for iOS 5 when app is also targetted for ios above 5
 * \n Any version below 6.0 like 5.1,5.0,3.2 etc will fall in here
 */
#define IS_DEVICE_RUNNING_IOS_5_X()			([[[UIDevice currentDevice] systemVersion] compare:@"6.0" options:NSNumericSearch] == NSOrderedAscending)

/**
 * Determines if the device running app is iPhone5 or 5s which has 4 inch display.
 */
#define is4InchDisplay() ( ( ([[UIScreen mainScreen] bounds].size.height == 568) || ([[UIScreen mainScreen] bounds].size.width == 568) )?TRUE:FALSE )

/**
 * Returns the width of the screen of the device in which the current app is running
 */
#define SCREEN_WIDTH  CGRectGetWidth([UIScreen mainScreen].bounds)

/**
 * Returns the width of the screen of the device in which the current app is running
 */
#define SCREEN_HEIGHT  CGRectGetHeight([UIScreen mainScreen].bounds)

/**
 * Returns the maximum of width and height of the screen of the device in which the current app is running
 */
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))

/**
 * Returns the minimum of width and height of the screen of the device in which the current app is running
 */
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

/**
 * Validates if the device is iphone
 */
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#pragma mark -
#pragma mark calculations

/**
 * Computes radians from degrees.
 * \n A method that lets you specify values in radians rather than degrees when using core graphics.
 */
#define DEGREES_TO_RADIANS(x) (M_PI * (x) / 180.0)

#pragma mark -



#pragma mark Logs

/**
 * A debug mode alternative for NSLog.
 * This method must be used instead of NSLog such that once app is released to store the user device is not added up with huge logs
 * Also using this method shall prevent an additional step of removing NSLog statements from project source.
 * @param ... : first argument will be the format and consequitive arguments will follow the values to form string with.
 */
#ifdef DEBUG
	#define DEBUGLog(...) extendedLog( [NSString stringWithFormat:@"%@ (Line %d): ", NSStringFromClass([self class]), __LINE__], __VA_ARGS__ )
#else
	#define DEBUGLog(...)
#endif


/**
 * A debug mode alternative for NSLog that logs begining the current method running in.
 * This method must be used instead of NSLog such that once app is released to store the user device is not added up with huge logs
 * Also using this method shall prevent an additional step of removing NSLog statements from project source.
 * @param x : name of the function to be loged as begun.
 */
#ifdef DEBUG
	#define DEBUGLogBegin(x) extendedLog( [NSString stringWithFormat:@"%@ BEGIN - ", NSStringFromClass([self class])], @#x )
#else
	#define DEBUGLogBegin(x)
#endif


/**
 * A debug mode alternative for NSLog that logs endinf the current method running in.
 * This method must be used instead of NSLog such that once app is released to store the user device is not added up with huge logs
 * Also using this method shall prevent an additional step of removing NSLog statements from project source.
 * @param x : name of the function to be loged as ended.
 */
#ifdef DEBUG
	#define DEBUGLogEnd(x) extendedLog( [NSString stringWithFormat:@"%@ END - ", NSStringFromClass([self class])], @#x )
#else
	#define DEBUGLogEnd(x)
#endif

#pragma mark -


#pragma mark Memory Handling

/**
 * Releases the data and resets passed reference to nil(none).
 * \n Please note that this method is not encouraged in Arc environments as release is prohibited
 */
#define RELEASE_SAFELY(__POINTER){if(__POINTER){ [__POINTER release]; __POINTER = nil;}}

/**
 * Releases the data and resets passed core foundation object reference to NULL.
 * \n Unlike previous method RELEASE_SAFELY this method can be used in arc as even arc dont care memory management on core foundation objects
 */
#define RELEASE_SAFELY_CF(X)  { CFRelease(X); X = NULL; }

#pragma mark -
#pragma mark other constants

/** An Empty string macro */
#define strEmpty				@""

/**  A macro for comma */
#define strComma				@","

/** A macro for space */
#define strSpace				@" "

/** A macro to add anchoring in all directions */
#define UIViewAutoresizingFlexibleAll	(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin)

#pragma mark -

/** @} */

@interface iGenTools : NSObject

@end