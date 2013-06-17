#import <AVFoundation/AVFoundation.h>
#import "JA_AudioPlayer_MC.h"
#import "NotificationNames.h"

@implementation JA_AudioPlayer_MC
#pragma mark - Public Properties
- (void)setAudioVolume:(float)audioVolume
{
  float validAudioVolume = audioVolume;
  if (audioVolume > 1)
    validAudioVolume = 1;
  else if (audioVolume < 0)
    validAudioVolume = 0;

  _audioVolume = validAudioVolume;
  self.audioPlayerM.volume = validAudioVolume;
  [self.notificationCenter postNotificationName:AudioPlayerVolumeDidChangeNotification object:self];
}

- (NSTimeInterval)audioTime
{
  return self.audioPlayerM.currentTime;
}

- (void)setAudioTime:(NSTimeInterval)time
{
  if (time < 0) {
    self.audioPlayerM.currentTime = 0;
    [self.notificationCenter postNotificationName:AudioPlayerPlaybackPositionWasChangedNotification object:self];
  } else if (time > [self audioDuration]) {
    self.audioPlayerM.currentTime = 0;
    [self audioPlayerDidFinishPlaying:self.audioPlayerM successfully:YES];
  } else {
    self.audioPlayerM.currentTime = time;
    [self.notificationCenter postNotificationName:AudioPlayerPlaybackPositionWasChangedNotification object:self];
  }
}

- (NSTimeInterval)audioDuration
{
  return self.audioPlayerM.duration;
}

#pragma mark - Public Methods
- (id)init
{
  self = [super init];
  if (self) {
    self.audioVolume = 0.5;
    self.jumpSeconds = 5;
  }
  return self;
}

- (void)loadAudioWithContentsOfURL:(NSURL *)url
{
  self.audioPlayerM = [self makeAudioPlayerMWithURL:url];
  self.audioPlayerM.delegate = self;
  [self.notificationCenter postNotificationName:AudioPlayerDidLoadAudioNotification object:self];
  [self.audioPlayerM prepareToPlay];
}

- (void)startAudio
{
  [self.notificationCenter postNotificationName:AudioPlayerWillStartPlayingNotification object:self];
  [self.audioPlayerM play];
  [self startPollingTimer];
}

- (void)stopAudio
{
  [self.notificationCenter postNotificationName:AudioPlayerWillStopPlayingNotification object:self];
  [self.audioPlayerM stop];
  [self stopPollingTimer];
}

- (void)jumpAudioBack
{
  NSTimeInterval newTime = self.audioTime - self.jumpSeconds;
  self.audioTime = newTime;
  [self.notificationCenter postNotificationName:AudioPlayerPlaybackPositionWasChangedNotification object:self];
}

- (void)jumpAudioForward
{
  NSTimeInterval newTime = self.audioTime + self.jumpSeconds;
  self.audioTime = newTime;
  [self.notificationCenter postNotificationName:AudioPlayerPlaybackPositionWasChangedNotification object:self];
}

- (void)scrubToTime:(NSTimeInterval)time
{
  BOOL isPlaying = [self isAudioPlaying];

  if (isPlaying) {
    [self.audioPlayerM stop];
    self.audioTime = time;
    [self.audioPlayerM prepareToPlay];
    [self.audioPlayerM play];
  } else {
    self.audioPlayerM.currentTime = time;
    self.audioTime = time;
    [self.audioPlayerM prepareToPlay];
  }
}

- (BOOL)isAudioPlaying
{
  return self.audioPlayerM.playing;
}

- (void)dealloc
{
  [self stopPollingTimer];
}

#pragma mark - Private Methods
- (AVAudioPlayer *)makeAudioPlayerMWithURL:(NSURL *)url
{
  NSError *error;
  AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
  NSAssert(audioPlayer, @"Audio player could not be created. %@", error);
  return audioPlayer;
}

- (void)startPollingTimer
{
  self.playbackPollingTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(playbackPollingTimerWasFired:) userInfo:nil repeats:YES];
}

- (void)stopPollingTimer
{
  [self.playbackPollingTimer invalidate];
}

- (void)playbackPollingTimerWasFired:(id)sender
{
  [self.notificationCenter postNotificationName:AudioPlayerPlaybackPositionWasChangedNotification object:self];
}

#pragma mark - AVAudioPlayerDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
  [self.notificationCenter postNotificationName:AudioPlayerPlaybackPositionWasChangedNotification object:self];
  [self stopAudio];
}
@end