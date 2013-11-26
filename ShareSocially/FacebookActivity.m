//
//  FacebookActivity.m
//
//  Created by Bob de Graaf on 31-05-12.
//  Copyright (c) 2012 GraafICT. All rights reserved.

#import "FacebookActivity.h"

@interface FacebookActivity ()
{
    
}

@property(nonatomic,strong) NSArray *activityItems;

@end


@implementation FacebookActivity

-(NSString *)activityType
{
    return @"com.mobilepioneers.facebook";
}

-(UIImage *)activityImage
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        return [UIImage imageNamed:@"Activity_Facebook_iPad"];
    }
    else
    {
        return [UIImage imageNamed:@"Activity_Facebook"];
    }
}

-(NSString *)activityTitle
{
    return @"Facebook";
}

-(BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    return TRUE;
}

-(void)performActivity
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kFacebookShareNotification object:self.activityItems];
    [self activityDidFinish:YES];
}

-(void)prepareWithActivityItems:(NSArray *)activityItems
{
    self.activityItems = activityItems;
}

@end






















