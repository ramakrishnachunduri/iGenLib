/*!
 * \brief		iGenPaddedTextField
 * \details		A subclass of UITextField that lets you specify padding.\n \n
 * This file is part of iGenLib. iGenLib is comprehensive library that provide a common way to integrate and reuse the components across other iOS apps
 * \author		Rama Krishna Chunduri
 * \date		24th Feb 2014
 * \copyright	CodeWorth 2014, All rights reserved.
 * @ingroup		Padded-UI-Elements
 */

#import <UIKit/UIKit.h>

@interface iGenPaddedTextField : UITextField

/**
 *  Assign edge insets comprising of paddding in order top,bottom,right,left respectively.
 *	By default the padding remains 0 on all sides.
 *	Also note asignation must be done before adding reciever to actual UI.
 */
@property (nonatomic, assign) UIEdgeInsets edgeInsets;

@end