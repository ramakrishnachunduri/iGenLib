/*! 
 *  \brief     UIColor+iGenLib.
 *  \details   iGenLib Extensions for UIColor.
 *  \author    Rama Krishna Chunduri
 *  \date      3/22/11
 *	\copyright Codeworth 2011, All rights reserved.
 *  \n This file is part of iGenLib.
 *  \n 
 *  \n iGenLib is free software: you can redistribute it and/or modify
 *  \n it under the terms of the GNU General Public License as published by
 *  \n the Free Software Foundation, either version 3 of the License, or
 *  \n (at your option) any later version.
 *  \n 
 *  \n iGenLib is distributed in the hope that it will be useful,
 *  \n but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  \n MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  \n GNU General Public License for more details.
 *  \n 
 *  \n You should have received a copy of the GNU General Public License
 *  \n along with iGenLib.  If not, see <http://www.gnu.org/licenses/>.
 */

#import <UIKit/UIKit.h>
@interface UIColor (iGenLib)
/**
 * Creates the color from the passed RGB(Red,Green,Blue) pattern
 * @return returns the respective color object to the RGB pattern.
 * @param rgbcolor : RGB color pattern to generate the color from. RGB patterns are listed below
 * \li @@"rgb:(255,255,255,1.0)"
 * \li @@"rgb:255,255,255,1.0"
 */
+(UIColor*)colorFromRGB:(NSString*)rgbcolor;

/**
 * Creates the color from the passed RGBA(Red,Green,Blue,Alpha) pattern
 * @return returns the respective color object to the RGBA pattern.
 * @param rgbacolor : RGBA color pattern to generate the color from. RGBA patterns are listed below
 * \li @@"rgba:(255,255,255,1.0)"
 * \li @@"rgba:255,255,255,1.0"
 */
+(UIColor*)colorFromRGBA:(NSString*)rgbacolor;

/**
 * Creates the color from the passed hexadecimal pattern
 * @return returns the respective color object to the hexadecimal pattern.
 * @return nil if a wrong hexadecimal pattern is used.
 * @param hexcolor : hexadecimal color pattern to generate the color from. hexadecimal patterns are listed below
 * \li @@"hex:FFCCAA"
 * \li @@"hex(FFCCAA)"
 * \li @@"#FFCCAA"
 * 
 * Supports 3 char hexadecimal colors also as below
 * \li @@"hex:CCD"
 * \li @@"hex(CCD)"
 * \li @@"#CCD"
 */
+(UIColor*)colorFromHEX:(NSString *)hexcolor;

/**
 * Creates the color from the passed pattern
 * @return returns the respective color object to the passed pattern.
 * @return nil if a wrong pattern is used.
 * @param colorPattern : color pattern to generate the color from. Patterns Supported are listed below
 * \li @@"uikit:redColor"
 * \li @@"rgb(255,255,255)" (or) @@"rgb:255,255,255"
 * \li @@"rgba:(255,255,255,1.0)" (or) @@"rgba:255,255,255,1.0"
 * \li @@"hex:FFCCAA" (or) @@"hex(FFCCAA)" (or) @@"#FFCCAA"
 * \li Supports 3 char hexadecimal colors also  @@"hex:CCD" (or) @@"hex(CCD)" (or) @@"#CCD"
 */
+(UIColor*)colorFromPattern:(NSString *)colorPattern;

@end