//
//  NSDateHelper.m
//
//  Created by Bob de Graaf on 22-02-11.
//  Copyright 2011 GraafICT. All rights reserved.
//

#import "NSDate+Helper.h"

@implementation NSDate (helper)

+(BOOL)checkDateIsToday:(NSDate *)date
{
	NSDateComponents *otherDay = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
	NSDateComponents *today = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:[NSDate date]];
	if([today day] == [otherDay day] && [today month] == [otherDay month] && [today year] == [otherDay year]) 
	{
		return true;
	}
	return false;
}

+(BOOL)checkDateValid:(NSDate *)date
{
    //first check simply if the today is earlier
    NSDate *today = [NSDate date];
    
    if([today compare:date] == NSOrderedAscending)
    {
        //earlier!        
        return TRUE;
    }
    else
    {
        //later
        NSDateComponents *otherDay = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
        NSDateComponents *today = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:[NSDate date]];
        if([today day] == [otherDay day] && [today month] == [otherDay month] && [today year] == [otherDay year]) 
        {
            //NSLog(@"Still valid, only seconds matter!");
            return true;
        }        
    }    
    return FALSE;
}

+(BOOL)checkDateTenMinutesLater:(NSDate *)date
{       
    double now = [[NSDate date] timeIntervalSince1970];
    double prev = [date timeIntervalSince1970];    
    if((now-prev)>600)
    {
        return true;
    }
    return false;    
}

+(BOOL)checkDateTwelveHoursLater:(NSDate *)date
{       
    double now = [[NSDate date] timeIntervalSince1970];
    double prev = [date timeIntervalSince1970];    
    if((now-prev)>43200)
    {
        return true;
    }    
    return false;    
}

+(BOOL)checkDateLaterThan:(int)seconds withDate:(NSDate *)date
{
    int now = [[NSDate date] timeIntervalSince1970];
    int prev = [date timeIntervalSince1970];
    if((now-prev)>seconds)
    {        
        return true;
    }    
    return false;
}

@end
