/** @defgroup Custom-UI-Elements iGenCustomUIElements
 *  As by defaults the UIKit ui elements doesn't support adding padding, These classes can be used to achieve padding wherever necessary
 */

/*!
 * \brief		iGenDropDownList.h
 * \details		A subclass of UIView that lets you mimic conventional dropdown list instead of using ActionSheet in iPhone and PopOver in iPad\n \n
 * 	This file is part of iGenLib. iGenLib is comprehensive library that provide a common way to integrate and reuse the components across other iOS apps
 * \author		Rama Krishna Chunduri
 * \date		24th December 2014
 * \copyright	CodeWorth 2014, All rights reserved.
 * @ingroup		Custom-UI-Elements
 */

#import <UIKit/UIKit.h>
@interface iGenDropDownList : UIView
/**
 *  Assign place holder text to display before picking a value.
 */
@property(nonatomic,retain) NSString *placeHolder;

/**
 *  Assign values to show in dropdown list. Use Comma seperated string like @"Value 1,Value 2,Value 3".
 *  (or) Use 2 Commas in case if values are allowed to have Comma like @"Rupees 1,000 to 5,000,,Rupees 6,000 to 9,000"
 */
@property(nonatomic,retain) NSString *dropDownValues;

/**
 *  Assign Default Value. if default value is there, ignore setting placeholder
 */
@property(nonatomic,retain) NSString *value;

/**
 *  Assign block to execute before displaying dropdown.
 */
@property(nonatomic,strong) void(^willOpen)();

/**
 *  Assign block to execute after picking one of the dropdown values.
 */
@property(nonatomic,strong) void(^didChange)(NSString *value);

/**
 *  Assign edge insets comprising of paddding in order top,bottom,right,left respectively.
 *	By default the padding remains 0 on all sides.
 *	Also note asignation must be done before adding reciever to actual UI.
 */
@property (nonatomic, assign) UIEdgeInsets edgeInsets;

/**
 *  Assign font to use for the dropdown list.
 */
@property(nonatomic,retain) UIFont *font;

/**
 *  Assign text color to use in dropdown list.
 */
@property(nonatomic,retain) UIColor *textColor;

/**
 *  Assign text color to use for dropdown options when active.
 */
@property(nonatomic,retain) UIColor *listTextColor;

/**
 *  Assign background color to use for dropdown options when active.
 */
@property(nonatomic,retain) UIColor *listBackgroundColor;

@end