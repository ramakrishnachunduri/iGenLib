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

@end
