//
//  SoundManager.m
//  TVGiDS.tv 1.0
//
//  Created by Bob de Graaf on 12-07-13.
//  Copyright (c) 2013 MobilePioneers. All rights reserved.
//

#import "BGUtilities.h"
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

-(void)loadSound:(NSString *)soundFile
{
    [self.soundEngine preloadSound:soundFile withKey:soundFile];
    [soundsArray addObject:soundFile];
}

-(id)init
{
    self = [super init];
    if(self != nil)
    {
        DLog(@"Initializing sounds player...");
        
        //Init sound engine
        _soundEngine = [[SoundEngine alloc] init];
        
        //Init category
        [self loadCategory:AVAudioSessionCategoryPlayback mixWithOthers:TRUE];
        
        //Load sounds
        [self loadSounds];
    }
    return  self;
}

#pragma mark Playing

-(void)playSound:(SoundType)soundType
{
    if([nsprefs boolForKey:kSound] && soundType<soundsArray.count)
    {
        [self.soundEngine playSound:[soundsArray objectAtIndex:soundType]];
    }
}

#pragma mark Methods to edit

-(void)loadSounds
{    
    //Init array
    soundsArray = [[NSMutableArray alloc] init];
    
    //Normal sounds
    [self loadSound:@"Sound_Refresh.caf"];
}

@end












































