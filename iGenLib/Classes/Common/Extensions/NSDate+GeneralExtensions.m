/*! 
 *  \brief     NSDate+GeneralExtensions.
 *  \details   General Extensions for NSDate.
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

#import "NSDate+GeneralExtensions.h"

@implementation NSDate(GeneralExtensions)

/**
 * Converts the date object into string with the given format
 * @param format : format in which the date is converted to.
 * @return a string that has the date converted to specific format
 */
-(NSString*) toStringWithFormat:(NSString*)format
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:format];
	NSString *stringDate=[dateFormatter stringFromDate:self];
	[dateFormatter release];
	return stringDate;
}

/**
 * Calculate the number of days between two given dates.
 * Usage : Can be used to get no.of.days in specific month while doing calenders
 * @param fromDate : date object from which the comparision starts.
 * @param toDate : date object where the comparision ends.
 * @return integer with no.of.days, will be negative if the fromDate is later than toDate
 */
+(int) daysBetweenDates:(NSDate*)fromDate ToDate:(NSDate*)toDate
{
    //dates have to represent only yyyy-mm-dd format for getting difference between two dates.
    unsigned int unitFlags = NSDayCalendarUnit;
    NSCalendar *gregorianCalender = [[NSCalendar alloc]	initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [gregorianCalender components:unitFlags fromDate:fromDate  toDate:toDate options:0];
    int days = [comps day];
    [gregorianCalender release];
    return days;
}

/**
 * Calculate the number of days,months,years... between two given dates.
 * @param fromDate : date object from which the comparision starts.
 * @param toDate : date object where the comparision ends.
 * @param calenderUnit : units in which the comparision to be calculated. expects one of  NSEraCalendarUnit,NSYearCalendarUnit,NSMonthCalendarUnit,NSDayCalendarUnit,NSHourCalendarUnit, NSMinuteCalendarUnit,NSSecondCalendarUnit,NSWeekCalendarUnit,kCFCalendarUnitWeekday........
 * @return integer with no.of.calenderunits, will be negative if the fromDate is later than toDate
 */
+(int) differenceBetweenDates:(NSDate*)fromDate ToDate:(NSDate*)toDate withCalenderUnit:(NSCalendarUnit*)calenderUnit
{
	NSUInteger unitFlags=(NSUInteger)calenderUnit;
	NSCalendar *gregorianCalender = [[NSCalendar alloc]	initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [gregorianCalender components:unitFlags fromDate:fromDate  toDate:toDate options:0];
    int returnVal=0;
	switch (unitFlags) 
	{
		case NSEraCalendarUnit:
			returnVal=[comps era];
			break;
		case NSYearCalendarUnit:
			returnVal=[comps year];
			break;
		case NSMonthCalendarUnit:
			returnVal=[comps month];
			break;
		case NSDayCalendarUnit:
			returnVal=[comps day];
			break;
		case NSHourCalendarUnit:
			returnVal=[comps hour];
			break;
		case NSMinuteCalendarUnit:
			returnVal=[comps minute];
			break;
		case NSSecondCalendarUnit:
			returnVal=[comps second];
			break;
		case NSWeekCalendarUnit:
			returnVal=[comps week];
			break;
		case NSWeekdayCalendarUnit:
			returnVal=[comps weekday];
			break;
		case NSWeekdayOrdinalCalendarUnit:
			returnVal=[comps weekdayOrdinal];
			break;
		case NSQuarterCalendarUnit:
			returnVal=[comps quarter];
			break;
		default:
			break;
	}
    [gregorianCalender release];
    return returnVal;
}

@end
