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

#include <CoreFoundation/CoreFoundation.h>

@interface  NSDate (GeneralExtensions)

/**
 * Converts the date object into string with the given format
 * @param format : format in which the date is converted to.
 * @return a string that has the date converted to specific format
 */
-(NSString*)toStringWithFormat:(NSString*)format;

/**
 * Calculate the number of days between two given dates.
 * Usage : Can be used to get no.of.days in specific month while doing calenders
 * @param fromDate : date object from which the comparision starts.
 * @param toDate : date object where the comparision ends.
 * @return integer with no.of.days, will be negative if the fromDate is later than toDate
 */
+(int) daysBetweenDates:(NSDate*)fromDate ToDate:(NSDate*)toDate;

/**
 * Calculate the number of days,months,years... between two given dates.
 * @param fromDate : date object from which the comparision starts.
 * @param toDate : date object where the comparision ends.
 * @param calenderUnit : units in which the comparision to be calculated. expects one of  NSEraCalendarUnit,NSYearCalendarUnit,NSMonthCalendarUnit,NSDayCalendarUnit,NSHourCalendarUnit, NSMinuteCalendarUnit,NSSecondCalendarUnit,NSWeekCalendarUnit,kCFCalendarUnitWeekday........
 * @return integer with no.of.calenderunits, will be negative if the fromDate is later than toDate
 */
+(int) differenceBetweenDates:(NSDate*)fromDate ToDate:(NSDate*)toDate withCalenderUnit:(NSCalendarUnit*)calenderUnit;

/**
 * Date of the first date in a month
 * @param mnth : month number in which first day is needed.
 * @param yr : year number  in which first day is needed of passed month.
 * @return date object for first date in month
 */
+(NSDate*)firstDayInMonth:(NSInteger)mnth year:(NSInteger)yr;

/**
 * Date of the last date in a month
 * @param mnth : month number in which last day is needed.
 * @param yr : year number  in which first day is needed of passed month.
 * @return date object for last date in month could be 28,29,30 or 31
 */
+(NSDate*)lastDayInMonth:(NSInteger)mnth year:(NSInteger)yr;

/**
 * Date of the first date in a month
 * @param date : any random date in the same month
 * @return date object for first date in month
 */
+(NSDate*)firstDayInMonthWithDate:(NSDate *)date;

/**
 * Date of the last date in a month
 * @param date : any random date in the same month
 * @return date object for last date in month could be 28,29,30 or 31
 */
+(NSDate*)lastDayInMonthWithDate:(NSDate *)date;

/**
 * Date of the last date in current month
 */
+(NSDate*)firstDayInCurrentMonth;

/**
 * Date of the last date in current month
 */
+(NSDate*)lastDayInCurrentMonth;

/**
 * Date of the first date in a week
 * @param date : any random date in the same week
 * @return date object for first date in week
 */
+(NSDate*)firstDayInWeekWithDate:(NSDate *)date;

/**
 * Date of the last date in a week
 * @param date : any random date in the same week
 * @return date object for last date in week
 */
+(NSDate*)lastDayInWeekWithDate:(NSDate *)date;

/**
 * Date of the first date in current week
 */
+(NSDate*)firstDayInCurrentWeek;

/**
 * Date of the last date in current week
 */
+(NSDate*)lastDayInCurrentWeek;

/**
 * Count the days in the month
 * @param date : any random date in the same month
 * @return count of days in month could be 28,29,30 or 31
 */
+(int)daysCountInMonth:(NSDate*)date;

/**
 * Count the days in current month
 * @return count of days in currentmonth could be 28,29,30 or 31
 */
+(int)daysCountInCurrentMonth;

@end