//
//  MPSoundEngine.h
//  Weather Cube
//
//  Created by Arno Klarenbeek on 7/17/12.
//  Copyright (c) 2012 Mobile Pioneers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface SoundEngine : NSObject
{
    NSMutableDictionary *soundsDictionary;
}

-(void)preloadSound:(NSString *)filename withKey:(NSString *)key;
-(void)playSound:(NSString *)soundName;
-(void)stopSound:(NSString *)soundName;
-(void)loop:(BOOL)loopBool sound:(NSString *)soundName;
-(BOOL)isSoundPlaying:(NSString *)soundName;
-(void)changePitchTo:(float)pitch ForSound:(NSString *)soundName;
-(void)changeGainTo:(float)gain ForSound:(NSString *)soundName;

@end
