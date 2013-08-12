//
//  SoundPlayer.h
//  TVGiDS.tv 1.0
//
//  Created by Bob de Graaf on 12-07-13.
//  Copyright (c) 2013 GraafICT. All rights reserved.
//

#import <Foundation/Foundation.h>

//Enum to edit
typedef enum
{
    kSoundRefresh=0,
} SoundType;

@interface SoundPlayer : NSObject
{
    NSMutableArray *soundsArray;
}

+(SoundPlayer *)sharedSoundPlayer;

-(void)playSound:(SoundType)soundType;

@end
