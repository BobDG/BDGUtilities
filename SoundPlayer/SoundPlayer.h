//
//  SoundPlayer.h
//
//  Created by Bob de Graaf on 12-07-13.
//  Copyright (c) 2013 GraafICT. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BGUtilities.h"

//How to use this class?
//Load category first: [soundPlayer loadCategory:AVAudioSessionCategoryPlayback mixWithOthers:TRUE];
//Then load sounds like this: [soundPlayer loadSound:@"stringA.caf" forID:kTurnSoundA];

@interface SoundPlayer : NSObject
{
    
}

+(SoundPlayer *)sharedSoundPlayer;

-(void)stopSound:(NSString *)soundID;
-(void)playSound:(NSString *)soundID;
-(BOOL)isSoundPlaying:(NSString *)soundID;
-(void)setLoop:(BOOL)loop forSound:(NSString *)soundID;
-(void)changeGainTo:(float)gain forSound:(NSString *)soundID;
-(void)changePitchTo:(float)pitch forSound:(NSString *)soundID;
-(void)loadSound:(NSString *)soundFile forID:(NSString *)soundID;
-(void)loadCategory:(NSString *)audioCategory mixWithOthers:(BOOL)mixWithOthers;

@end
