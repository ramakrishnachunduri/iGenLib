#import "NSDate+GeneralExtensions.h"

@implementation NSDate(GeneralExtensions)
-(NSString*) toStringWithFormat:(NSString*)format
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:format];
	NSString *stringDate=[dateFormatter stringFromDate:self];
	[dateFormatter release];
	return stringDate;
}

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

+(NSDate*)firstDayInMonth:(NSInteger)mnth year:(NSInteger)yr
{
	NSCalendarUnit unit=NSCalendarUnitYear | NSMonthCalendarUnit | NSDayCalendarUnit;
	
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *components = [gregorian components:unit fromDate:[NSDate date]];
	[components setYear:yr];
	[components setMonth:mnth];
	[components setDay:1];
	[components setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
	NSDate *firstDate=[gregorian dateFromComponents:components];
	return firstDate;
}

+(NSDate*)lastDayInMonth:(NSInteger)mnth year:(NSInteger)yr
{
	NSCalendarUnit unit=NSCalendarUnitYear | NSMonthCalendarUnit | NSDayCalendarUnit;
	
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *components = [gregorian components:unit fromDate:[NSDate date]];
	[components setYear:yr];
	[components setMonth:mnth];
	[components setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
	
	//last date
	NSInteger dayVal=31;
	for(int i=0;i<5;i++)
	{
		[components setDay:dayVal];
		NSDate *day=[gregorian dateFromComponents:components];
		NSDateComponents *comps = [gregorian components:unit fromDate:day];
		if(comps.month==mnth)
		{
			return day;
		}
		dayVal--;
	}
	return nil;
}

+(NSDate*)firstDayInMonthWithDate:(NSDate *)date
{
	NSCalendarUnit unit=NSCalendarUnitYear | NSMonthCalendarUnit | NSDayCalendarUnit;
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *comps=[gregorian components:unit fromDate:date];
	return [NSDate firstDayInMonth:comps.month year:comps.year];
}

+(NSDate*)lastDayInMonthWithDate:(NSDate *)date
{
	NSCalendarUnit unit=NSCalendarUnitYear | NSMonthCalendarUnit | NSDayCalendarUnit;
	
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *comps=[gregorian components:unit fromDate:date];
	return [NSDate lastDayInMonth:comps.month year:comps.year];
}

+(NSDate*)firstDayInCurrentMonth
{
	return [NSDate firstDayInMonthWithDate:[NSDate date]];
}

+(NSDate*)lastDayInCurrentMonth
{
	return [NSDate lastDayInMonthWithDate:[NSDate date]];
}

+(NSDate*)firstDayInWeekWithDate:(NSDate *)date
{
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *weekdayComponents = [gregorian components:NSWeekdayCalendarUnit fromDate:date];
	NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];
	[componentsToSubtract setDay: - ((([weekdayComponents weekday] - [gregorian firstWeekday])
									  + 7 ) % 7)];
	NSDate *beginningOfWeek = [gregorian dateByAddingComponents:componentsToSubtract toDate:date options:0];
	NSDateComponents *components = [gregorian components: (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
												fromDate: beginningOfWeek];
	beginningOfWeek = [gregorian dateFromComponents: components];
	beginningOfWeek=[beginningOfWeek dateByAddingTimeInterval:24*60*60];
	return beginningOfWeek;
}

+(NSDate*)lastDayInWeekWithDate:(NSDate *)date
{
	NSDate *datex=[NSDate firstDayInWeekWithDate:date];
	datex=[datex dateByAddingTimeInterval:(24*60*60)*6];
	return datex;
}

+(NSDate*)firstDayInCurrentWeek
{
	return [NSDate firstDayInWeekWithDate:[NSDate date]];
}

+(NSDate*)lastDayInCurrentWeek
{
	return [NSDate lastDayInWeekWithDate:[NSDate date]];
}

+(int)daysCountInMonth:(NSDate*)date
{
	NSCalendar *c = [NSCalendar currentCalendar];
	NSRange days = [c rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
	return (int)days.length;
}

+(int)daysCountInCurrentMonth
{
	return [NSDate daysCountInMonth:[NSDate date]];
}

@end
