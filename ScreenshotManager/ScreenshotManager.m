//
//  ScreenshotManager.m
//
//  Created by Bob de Graaf on 31-05-12.
//  Copyright (c) 2014 GraafICT. All rights reserved.
//

#import "ScreenshotManager.h"

@implementation ScreenshotManager

+(UIImage *)getScreenshotFromAllWindows
{
    CGRect screenCaptureRect = [UIScreen mainScreen].bounds;
    UIGraphicsBeginImageContextWithOptions(screenCaptureRect.size, NO, 0.0f);
    for(UIWindow *window in [UIApplication sharedApplication].windows) {
        [window drawViewHierarchyInRect:screenCaptureRect afterScreenUpdates:NO];
    }
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenshot;
}

+(UIImage *)getScreenshotFromView:(UIView *)v
{
    return [self getScreenshotFromView:v renderInContext:TRUE afterScreenUpdates:FALSE];
}

+(UIImage *)getScreenshotFromView:(UIView *)v afterScreenUpdates:(BOOL)afterScreenUpdates
{
    return [self getScreenshotFromView:v renderInContext:FALSE afterScreenUpdates:afterScreenUpdates];
}

+(UIImage *)getScreenshotFromView:(UIView *)v renderInContext:(BOOL)renderInContext
{
    return [self getScreenshotFromView:v renderInContext:renderInContext afterScreenUpdates:FALSE];
}

+(UIImage *)getScreenshotFromView:(UIView *)v renderInContext:(BOOL)renderInContext afterScreenUpdates:(BOOL)afterScreenUpdates
{
    UIGraphicsBeginImageContextWithOptions(v.frame.size, NO, 0.0f);
    if(renderInContext) {
        [v.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    else {
        [v drawViewHierarchyInRect:v.bounds afterScreenUpdates:afterScreenUpdates];
    }
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenshot;
}

+(UIImage *)getScreenshotFromView:(UIView *)v side:(ScreenshotType)sType
{
    CGFloat scale = [UIScreen mainScreen].scale;
    UIImage *screenshot = [self getScreenshotFromView:v];
    CGRect specRect = CGRectZero;
    UIImage *result = nil;
    if(sType == kScreenshotUp) {
        specRect = CGRectMake(0, 0, v.frame.size.width*scale, (v.frame.size.height/2)*scale);
    }
    else if(sType == kScreenshotDown) {
        specRect = CGRectMake(0, (v.frame.size.height/2)*scale, v.frame.size.width*scale, (v.frame.size.height/2)*scale);
    }
    else if(sType == kScreenshotLeft) {
        specRect = CGRectMake(0, 0, (v.frame.size.width/2)*scale, v.frame.size.height*scale);
    }
    else if(sType == kScreenshotRight) {
        specRect = CGRectMake(0, 0, (v.frame.size.width/2)*scale, v.frame.size.height*scale);
    }
    CGImageRef imageRef = CGImageCreateWithImageInRect([screenshot CGImage], specRect);
    result = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return result;
}

+(NSArray *)getScreenshotVerticalsFromView:(UIView *)v
{
    UIImage *screenshot = [self getScreenshotFromView:v];
    return [self getVerticalsFromImage:screenshot];
}

+(NSArray *)getScreenshotHorizontalsFromView:(UIView *)v
{
    UIImage *screenshot = [self getScreenshotFromView:v];
    return [self getHorizontalsFromImage:screenshot];
}

+(NSArray *)getVerticalsFromImage:(UIImage *)img
{
    CGFloat scale = [[UIScreen mainScreen]scale];
    UIImage *resultUp = nil;
    {
        CGRect upRect = CGRectMake(0, 0, img.size.width*scale, (img.size.height/2)*scale);
        CGImageRef imageRefUp = CGImageCreateWithImageInRect([img CGImage], upRect);
        resultUp = [UIImage imageWithCGImage:imageRefUp];
        CGImageRelease(imageRefUp);
    }
    UIImage *resultDown = nil;
    {
        CGRect downRect = CGRectMake(0, (img.size.height/2)*scale, img.size.width*scale, (img.size.height/2)*scale);
        CGImageRef imageRefDown = CGImageCreateWithImageInRect([img CGImage], downRect);
        resultDown = [UIImage imageWithCGImage:imageRefDown];
        CGImageRelease(imageRefDown);
    }
    return @[resultUp, resultDown];
}

+(NSArray *)getHorizontalsFromImage:(UIImage *)img
{
    CGFloat scale = [UIScreen mainScreen].scale;
    UIImage *resultLeft = nil;
    {
        CGRect leftRect = CGRectMake(0, 0, (img.size.width/2)*scale, img.size.height*scale);
        CGImageRef imageRef = CGImageCreateWithImageInRect([img CGImage], leftRect);
        resultLeft = [UIImage imageWithCGImage:imageRef];
        CGImageRelease(imageRef);
    }
    UIImage *resultRight = nil;
    {
        CGRect rightRect = CGRectMake((img.size.width/2)*scale, 0, (img.size.width/2)*scale, img.size.height*scale);
        CGImageRef imageRef = CGImageCreateWithImageInRect([img CGImage], rightRect);
        resultRight = [UIImage imageWithCGImage:imageRef];
        CGImageRelease(imageRef);
    }
    return @[resultLeft, resultRight];
}

@end


































