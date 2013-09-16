//
//  ScreenshotManager.h
//  Weather Cube
//
//  Created by Bob de Graaf on 31-05-12.
//  Copyright (c) 2012 Mobile Pioneers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

typedef enum {
    kScreenshotUp = 1,
    kScreenshotDown = 2,
    kScreenshotLeft = 3,
    kScreenshotRight = 4
} ScreenshotType;

@interface ScreenshotManager : NSObject

/* Take screenshot of different types */
+(UIImage *)getScreenshotFromView:(UIView *)v;
+(UIImage *)getScreenshotFromView:(UIView *)v side:(ScreenshotType)sType;

/* Take screenshot and get halfs of the screenshot back in a NSArray */
+(NSArray *)getScreenshotVerticalsFromView:(UIView *)v;
+(NSArray *)getScreenshotHorizontalsFromView:(UIView *)v;

/* Simply divide the given image into halfs */
+(NSArray *)getVerticalsFromImage:(UIImage *)img;
+(NSArray *)getHorizontalsFromImage:(UIImage *)img;

@end