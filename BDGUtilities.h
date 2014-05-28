//
//  BDGUtilities.h
//
//  Created by Bob de Graaf on 23-09-12.
//  Copyright (c) 2012 GraafICT. All rights reserved.
//

#import "SoundPlayer.h"

//Singletons
#define BGIAStore       [InAppStore sharedInAppStore]
#define BGsPlayer       [SoundPlayer sharedSoundPlayer]
#define BGIAPurchase    [InAppPurchase sharedInAppPurchase]
#define BGLocGetter     [LocationGetter sharedLocationGetter]

//NSPrefs keys
#define kSound          @"kSound"
