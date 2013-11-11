//
//  NSDateFormatter+Helper.m
//  TVGiDS.tv 1.0
//
//  Created by Bob de Graaf on 10-06-13.
//  Copyright (c) 2013 MobilePioneers. All rights reserved.
//

#import "NSDateFormatter+Helper.h"

@implementation NSDateFormatter (Helper)

+(NSDateFormatter *)currentDateFormatterWithFormat:(NSString*)format
{
    NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
    NSDateFormatter *dateFormatter = [threadDictionary objectForKey:format] ;
    if(dateFormatter == nil)
    {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:format];
        [threadDictionary setObject:dateFormatter forKey:format] ;
    }
    return dateFormatter;
}

@end
