//
//  SoundPlayer.m
//
//  Created by Bob de Graaf on 12-07-13.
//  Copyright (c) 2013 MobilePioneers. All rights reserved.
//

#import "Constants.h"
#import "SoundPlayer.h"
#import "SoundEngine.h"

@interface SoundPlayer ()
{
}

@property(nonatomic,strong) SoundEngine *soundEngine;

@end

@implementation SoundPlayer

+(id)sharedSoundPlayer
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

#pragma mark Loading

-(void)loadCategory:(NSString *)audioCategory mixWithOthers:(BOOL)mixWithOthers
{
    // Initialize audio session
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    
    // Active your audio session
    [audioSession setActive: NO error: nil];
    
    // Set audio session category
    [audioSession setCategory:audioCategory error:nil];
    
    if(mixWithOthers)
    {
        // Modifying Playback Mixing Behavior, allow playing music in other apps
        OSStatus propertySetError = 0;
        UInt32 allowMixing = true;
        propertySetError = AudioSessionSetProperty(kAudioSessionProperty_OverrideCategoryMixWithOthers, sizeof (allowMixing), &allowMixing);
    }    
    
    // Active your audio session
    [audioSession setActive: YES error: nil];
}

-(void)loadSound:(NSString *)soundFile forID:(NSString *)soundID
{
    [self.soundEngine preloadSound:soundFile withKey:soundID];
}

-(id)init
{
    self = [super init];
    if(self != nil)
    {
        NSLog(@"Initializing sounds player...");
        
        //Init sound engine
        _soundEngine = [[SoundEngine alloc] init];        
    }
    return  self;
}

#pragma mark Playing

-(void)stopSound:(NSString *)soundID
{
    [self.soundEngine stopSound:soundID];
}

-(void)playSound:(NSString *)soundID
{
    if([[NSUserDefaults standardUserDefaults] boolForKey:kSound])
    {
        [self.soundEngine playSound:soundID];
    }
}

-(BOOL)isSoundPlaying:(NSString *)soundID
{
    return [self.soundEngine isSoundPlaying:soundID];
}

-(void)changeGainTo:(float)gain forSound:(NSString *)soundID
{
    [self.soundEngine changeGainTo:gain ForSound:soundID];
}

-(void)setLoop:(BOOL)loop forSound:(NSString *)soundID
{
    [self.soundEngine loop:loop sound:soundID];
}

-(void)changePitchTo:(float)pitch forSound:(NSString *)soundID
{
    [self.soundEngine changePitchTo:pitch ForSound:soundID];
}

@end












































