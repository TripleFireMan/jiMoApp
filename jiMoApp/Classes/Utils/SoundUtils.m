

#import "SoundUtils.h"

@implementation SoundUtils


+ (void)playSound:(NSString *)path
{
	if (path) {
		NSURL *aFileURL = [NSURL fileURLWithPath:path isDirectory:NO];
        SystemSoundID aSoundID;
        OSStatus error = AudioServicesCreateSystemSoundID((CFURLRef)aFileURL, &aSoundID);
        if (error == kAudioServicesNoError) {
            AudioServicesPlaySystemSound(aSoundID);
        }
	}
}

+ (void)playSoundWithVibrate:(NSString *)path
{
	if (path) {
		NSURL *aFileURL = [NSURL fileURLWithPath:path isDirectory:NO];
        SystemSoundID aSoundID;
        OSStatus error = AudioServicesCreateSystemSoundID((CFURLRef)aFileURL, &aSoundID);
        if (error == kAudioServicesNoError) {
            AudioServicesPlaySystemSound(aSoundID);
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        }
	}
}

+ (void)playVibrate
{
	AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}
@end