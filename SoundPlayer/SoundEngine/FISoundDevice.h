#import <OpenAL/al.h>
#import <OpenAL/alc.h>

@interface FISoundDevice : NSObject

@property(assign, readonly) ALCdevice *handle;

+ (id) defaultSoundDevice;

@end
