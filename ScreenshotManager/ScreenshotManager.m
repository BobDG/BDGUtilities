//
//  ScreenshotManager.m
//  Weather Cube
//
//  Created by Bob de Graaf on 31-05-12.
//  Copyright (c) 2012 Mobile Pioneers. All rights reserved.
//

#import "ScreenshotManager.h"

@implementation ScreenshotManager

+(UIImage *)getScreenshotFromView:(UIView *)v
{
    CGFloat scale = 1.0;
    if([[UIScreen mainScreen]respondsToSelector:@selector(scale)])
    {        
        CGFloat tmp = [[UIScreen mainScreen]scale];
        if (tmp > 1.5)
        {
            scale = 2.0;    
        }
    }      
    if(scale > 1.5)
    {
        UIGraphicsBeginImageContextWithOptions(v.frame.size, NO, scale);
    } 
    else
    {
        UIGraphicsBeginImageContext(v.frame.size);
    }    
    
    [v.layer renderInContext:UIGraphicsGetCurrentContext()];    
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenshot;
}

+(UIImage *)getScreenshotFromView:(UIView *)v side:(ScreenshotType)sType
{
    CGFloat scale = 1.0;
    if([[UIScreen mainScreen]respondsToSelector:@selector(scale)])
    {        
        CGFloat tmp = [[UIScreen mainScreen]scale];
        if (tmp > 1.5)
        {
            scale = 2.0;    
        }
    }      
    if(scale > 1.5)
    {
        UIGraphicsBeginImageContextWithOptions(v.frame.size, NO, scale);
    } 
    else
    {
        UIGraphicsBeginImageContext(v.frame.size);
    }    
    
    [v.layer renderInContext:UIGraphicsGetCurrentContext()];    
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();    
    
    CGRect specRect = CGRectZero;
    UIImage *result = nil;
    if(sType == kScreenshotUp)
    {
        specRect = CGRectMake(0, 0, v.frame.size.width*scale, (v.frame.size.height/2)*scale);   
    }
    else if(sType == kScreenshotDown)
    {
        specRect = CGRectMake(0, (v.frame.size.height/2)*scale, v.frame.size.width*scale, (v.frame.size.height/2)*scale);      
    }    
    else if(sType == kScreenshotLeft)
    {
        specRect = CGRectMake(0, 0, (v.frame.size.width/2)*scale, v.frame.size.height*scale);        
    }
    else if(sType == kScreenshotRight)
    {
        specRect = CGRectMake(0, 0, (v.frame.size.width/2)*scale, v.frame.size.height*scale);        
    }
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([screenshot CGImage], specRect);
    result = [UIImage imageWithCGImage:imageRef];        
    CGImageRelease(imageRef);
    
    return result;
}

+(NSArray *)getScreenshotVerticalsFromView:(UIView *)v
{
    CGFloat scale = 1.0;
    if([[UIScreen mainScreen]respondsToSelector:@selector(scale)])
    {        
        CGFloat tmp = [[UIScreen mainScreen]scale];
        if (tmp > 1.5)
        {
            scale = 2.0;    
        }
    }      
    if(scale > 1.5)
    {
        UIGraphicsBeginImageContextWithOptions(v.frame.size, NO, scale);
    } 
    else
    {
        UIGraphicsBeginImageContext(v.frame.size);
    }    
    
    [v.layer renderInContext:UIGraphicsGetCurrentContext()];    
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext(); 
    
    UIImage *resultUp = nil;
    {
        CGRect upRect = CGRectMake(0, 0, v.frame.size.width*scale, (v.frame.size.height/2)*scale);
        CGImageRef imageRefUp = CGImageCreateWithImageInRect([screenshot CGImage], upRect);        
        resultUp = [UIImage imageWithCGImage:imageRefUp];           
        CGImageRelease(imageRefUp);
    }
    UIImage *resultDown = nil;
    {
        CGRect downRect = CGRectMake(0, (v.frame.size.height/2)*scale, v.frame.size.width*scale, (v.frame.size.height/2)*scale);
        CGImageRef imageRefDown = CGImageCreateWithImageInRect([screenshot CGImage], downRect);
        resultDown = [UIImage imageWithCGImage:imageRefDown];        
        CGImageRelease(imageRefDown);
    }    
    
    NSArray *results = [NSArray arrayWithObjects:resultUp, resultDown, nil];
    return results;
}

+(NSArray *)getScreenshotHorizontalsFromView:(UIView *)v
{
    CGFloat scale = 1.0;
    if([[UIScreen mainScreen]respondsToSelector:@selector(scale)])
    {        
        CGFloat tmp = [[UIScreen mainScreen]scale];
        if (tmp > 1.5)
        {
            scale = 2.0;    
        }
    }      
    if(scale > 1.5)
    {
        UIGraphicsBeginImageContextWithOptions(v.frame.size, NO, scale);
    } 
    else
    {
        UIGraphicsBeginImageContext(v.frame.size);
    }    
    
    [v.layer renderInContext:UIGraphicsGetCurrentContext()];    
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext(); 

    UIImage *resultLeft = nil;
    {
        CGRect leftRect = CGRectMake(0, 0, (v.frame.size.width/2)*scale, v.frame.size.height*scale); 
        CGImageRef imageRef = CGImageCreateWithImageInRect([screenshot CGImage], leftRect);        
        resultLeft = [UIImage imageWithCGImage:imageRef];           
        CGImageRelease(imageRef);
    }
    UIImage *resultRight = nil;
    {
        CGRect rightRect = CGRectMake((v.frame.size.width/2)*scale, 0, (v.frame.size.width/2)*scale, v.frame.size.height*scale);
        CGImageRef imageRef = CGImageCreateWithImageInRect([screenshot CGImage], rightRect);
        resultRight = [UIImage imageWithCGImage:imageRef];        
        CGImageRelease(imageRef);
    }    
    
    NSArray *results = [NSArray arrayWithObjects:resultLeft, resultRight, nil];
    return results;
}

+(NSArray *)getVerticalsFromImage:(UIImage *)img
{
    CGFloat scale = 1.0;
    if([[UIScreen mainScreen]respondsToSelector:@selector(scale)])
    {        
        CGFloat tmp = [[UIScreen mainScreen]scale];
        if (tmp > 1.5)
        {
            scale = 2.0;    
        }
    } 
    
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
    
    NSArray *results = [NSArray arrayWithObjects:resultUp, resultDown, nil];
    return results;
}

+(NSArray *)getHorizontalsFromImage:(UIImage *)img
{
    CGFloat scale = 1.0;
    if([[UIScreen mainScreen]respondsToSelector:@selector(scale)])
    {        
        CGFloat tmp = [[UIScreen mainScreen]scale];
        if (tmp > 1.5)
        {
            scale = 2.0;    
        }
    } 
    
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
    
    NSArray *results = [NSArray arrayWithObjects:resultLeft, resultRight, nil];
    return results;
}

@end


































