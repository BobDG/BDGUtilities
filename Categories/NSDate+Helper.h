//
//  NSDateHelper.h
//
//  Created by Bob de Graaf on 22-02-11.
//  Copyright 2011 GraafICT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (helper)

+(BOOL)checkDateValid:(NSDate *)date;
+(BOOL)checkDateIsToday:(NSDate *)date;
+(BOOL)checkDateTenMinutesLater:(NSDate *)date;
+(BOOL)checkDateTwelveHoursLater:(NSDate *)date;
+(BOOL)checkDateLaterThan:(int)seconds withDate:(NSDate *)date;

@end
