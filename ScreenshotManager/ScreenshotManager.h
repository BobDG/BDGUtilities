//
//  ScreenshotManager.h
//
//  Created by Bob de Graaf on 31-05-12.
//  Copyright (c) 2014 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

typedef enum {
    kScreenshotUp = 1,
    kScreenshotDown = 2,
    kScreenshotLeft = 3,
    kScreenshotRight = 4
} ScreenshotType;

@interface ScreenshotManager : NSObject

/* Take screenshot of all windows (including keyboard) */
+(UIImage *)getScreenshotFromAllWindows;

/* Take screenshot of different types */
+(UIImage *)getScreenshotFromView:(UIView *)v;
+(UIImage *)getScreenshotFromView:(UIView *)v side:(ScreenshotType)sType;
+(UIImage *)getScreenshotFromView:(UIView *)v renderInContext:(BOOL)renderInContext;
+(UIImage *)getScreenshotFromView:(UIView *)v afterScreenUpdates:(BOOL)afterScreenUpdates;
+(UIImage *)getScreenshotFromView:(UIView *)v renderInContext:(BOOL)renderInContext afterScreenUpdates:(BOOL)afterScreenUpdates;

/* Take screenshot and get halfs of the screenshot back in a NSArray */
+(NSArray *)getScreenshotVerticalsFromView:(UIView *)v;
+(NSArray *)getScreenshotHorizontalsFromView:(UIView *)v;

/* Simply divide the given image into halfs */
+(NSArray *)getVerticalsFromImage:(UIImage *)img;
+(NSArray *)getHorizontalsFromImage:(UIImage *)img;

@end