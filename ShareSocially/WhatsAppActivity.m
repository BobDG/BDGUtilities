//
//  WhatsappActivity.m
//
//  Created by Bob de Graaf on 31-05-12.
//  Copyright (c) 2012 GraafICT. All rights reserved.

#import "WhatsAppActivity.h"

@interface WhatsAppActivity ()

@end


@implementation WhatsAppActivity

-(NSString *)activityType
{
    return @"com.mobilepioneers.whatsapp";
}

-(UIImage *)activityImage
{
    return [UIImage imageNamed:@"Activity_Whatsapp"];
}

-(NSString *)activityTitle
{
    return @"WhatsApp";
}

-(NSString *)stringByEncodingString:(NSString *)string
{
    CFStringRef encodedString = CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)string, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8);
    return CFBridgingRelease(encodedString);
}

-(BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    return TRUE;
}

-(void)prepareWithActivityItems:(NSArray *)activityItems
{
    UIImage *image = nil;
    NSString *text = nil;
    NSString *urlStr = nil;
    for(id activityItem in activityItems)
    {
        NSLog(@"ActivityItem class: %@", [activityItem class]);
        if([activityItem isKindOfClass:[NSString class]])
        {
            text = [self stringByEncodingString:activityItem];
        }
        else if([activityItem isKindOfClass:[NSURL class]])
        {
            urlStr = [activityItem absoluteString];
        }
        else if([activityItem isKindOfClass:[UIImage class]])
        {
            image = activityItem;
        }
    }
    
    NSString *whatsAppURL = @"whatsapp://send?";
    if(text.length>0)
    {
        whatsAppURL = [whatsAppURL stringByAppendingFormat:@"text=%@", text];
    }
    if(urlStr.length>0)
    {
        whatsAppURL = [whatsAppURL stringByAppendingFormat:@" Link:%@", urlStr];
    }
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:whatsAppURL]];
}

@end






















