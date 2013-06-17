#import <AVFoundation/AVFoundation.h>

@class AVAudioPlayer;

@interface JA_AudioPlayer_MC : NSObject <AVAudioPlayerDelegate>
@property (nonatomic, assign) NSTimeInterval audioTime;
@property (nonatomic, assign, readonly) NSTimeInterval audioDuration;
@property (nonatomic, assign) float audioVolume;
@property (nonatomic, strong) AVAudioPlayer *audioPlayerM;
@property (nonatomic, assign) NSTimeInterval jumpSeconds;
@property (nonatomic, strong) NSNotificationCenter *notificationCenter;
@property (nonatomic, strong) NSTimer *playbackPollingTimer;
- (void)loadAudioWithContentsOfURL:(NSURL *)url;
- (void)startAudio;
- (void)stopAudio;
- (void)jumpAudioBack;
- (void)jumpAudioForward;
- (void)scrubToTime:(NSTimeInterval)time1;
- (BOOL)isAudioPlaying;
@end