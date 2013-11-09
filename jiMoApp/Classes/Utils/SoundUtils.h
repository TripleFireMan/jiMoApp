

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioServices.h>

@interface SoundUtils : NSObject {
}
+ (void)playSound:(NSString *)path;
+ (void)playSoundWithVibrate:(NSString *)path;
+ (void)playVibrate;
@end