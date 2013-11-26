//
//  MPSoundEngine.m
//  Weather Cube
//
//  Created by Arno Klarenbeek on 7/17/12.
//  Copyright (c) 2012 Mobile Pioneers. All rights reserved.
//

#import "FISound.h"
#import "SoundEngine.h"
#import "FISoundEngine.h"

@interface SoundEngine ()
@property(strong) FISoundEngine *soundEngine;
@end

@implementation SoundEngine
@synthesize soundEngine;

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(id)init
{
    self = [super init];
    if(self)
    {        
        
        [self setSoundEngine:[FISoundEngine sharedEngine]];
        soundsDictionary = [[NSMutableDictionary alloc] init];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(willResignActive)
                                                     name:UIApplicationWillResignActiveNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didBecomeActive)
                                                     name:UIApplicationDidBecomeActiveNotification
                                                   object:nil];
    }
    return self;
}

-(void)willResignActive
{
    [self setSuspended:TRUE];
}

-(void)didBecomeActive
{
    [self setSuspended:FALSE];
}

-(void)setSuspended:(BOOL)suspended
{
    NSLog(@"Will suspend: %d", suspended);
    self.soundEngine.suspended = suspended;
}

#pragma mark - Public sound methods

-(void)preloadSound:(NSString *)filename withKey:(NSString *)key
{
    FISound *sound = [self.soundEngine soundNamed:filename maxPolyphony:4 error:NULL];
    if(sound != nil)
    {
        [soundsDictionary setObject:sound forKey:key];
    }
}

-(void)playSound:(NSString *)soundName
{
    FISound *sound = [soundsDictionary objectForKey:soundName];
    if (sound != nil)
    {
        [sound play];
    }
}

-(void)stopSound:(NSString *)soundName
{
    FISound *sound = [soundsDictionary objectForKey:soundName];
    if (sound != nil)
    {
        [sound stop];
    }
}

-(void)loop:(BOOL)loopBool sound:(NSString *)soundName
{
    FISound *sound = [soundsDictionary objectForKey:soundName];    
    if (sound != nil)
    {
        sound.loop = loopBool;
    }
}

-(BOOL)isSoundPlaying:(NSString *)soundName
{
    FISound *sound = [soundsDictionary objectForKey:soundName];    
    if(sound != nil)
    {
        if (sound.isPlaying)
        {
            return YES;
        }
    }    
    return NO;
}

#pragma mark - Sound altering

-(void)changePitchTo:(float)pitch ForSound:(NSString *)soundName
{
    FISound *sound = [soundsDictionary objectForKey:soundName];    
    if (sound != nil)
    {
        sound.pitch = pitch;
    }
}

-(void)changeGainTo:(float)gain ForSound:(NSString *)soundName
{
    FISound *sound = [soundsDictionary objectForKey:soundName];    
    if (sound != nil)
    {
        sound.gain = gain;
    }
}

@end




















