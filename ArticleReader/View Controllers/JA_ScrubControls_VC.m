#import "JA_ScrubControls_VC.h"
#import "JA_ScrubControls_V.h"
#import "JA_Slider.h"
#import "JA_AudioPlayer_MC.h"
#import "NotificationNames.h"
#import "JA_VolumeControls_V.h"

@implementation JA_ScrubControls_VC
#pragma mark - Public Methods
- (void)viewDidLoad
{
  [super viewDidLoad];
  [self addNotificationObservers];
  [self addTargetActions];
}

- (void)dealloc
{
  [self.notificationCenter removeObserver:self];
}

- (void)loadView
{
  self.view = [[JA_ScrubControls_V alloc] initWithFrame:CGRectZero];
}

#pragma mark - Private Methods
- (void)addTargetActions
{
  [[self.genericView slider] addTarget:self action:@selector(sliderWasTouchedDown:) forControlEvents:UIControlEventTouchDown];
  [[self.genericView slider] addTarget:self action:@selector(sliderWasDragged:) forControlEvents:UIControlEventTouchDragInside | UIControlEventTouchDragOutside];
  [[self.genericView slider] addTarget:self action:@selector(sliderWasTouchedUp:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
}

- (void)addNotificationObservers
{
  [self.notificationCenter addObserver:self selector:@selector(audioPlayerPlaybackPositionWasChanged:) name:AudioPlayerPlaybackPositionWasChangedNotification object:nil];
  [self.notificationCenter addObserver:self selector:@selector(audioPlayerDidLoadAudio:) name:AudioPlayerDidLoadAudioNotification object:nil];
}

- (void)audioPlayerPlaybackPositionWasChanged:(NSNotification *)notification
{
  [self updateSliderAndLabelValues];
}

- (void)audioPlayerDidLoadAudio:(NSNotification *)notification
{
  [self.genericView slider].minimumValue = 0;
  [self.genericView slider].maximumValue = (float)floor(self.audioPlayerMC.audioDuration);
  [self updateSliderAndLabelValues];
}

- (void)sliderWasTouchedDown:(id)sender
{
  [self.notificationCenter removeObserver:self name:AudioPlayerPlaybackPositionWasChangedNotification object:nil];
}

- (void)sliderWasDragged:(id)sender
{
  [self.audioPlayerMC scrubToTime:[self.genericView slider].value];
  [self.genericView label].text = [self remainingDurationString:(NSInteger)([self.audioPlayerMC audioDuration] - [self.genericView slider].value)];
}

- (void)sliderWasTouchedUp:(id)sender
{
  [self.notificationCenter addObserver:self selector:@selector(audioPlayerPlaybackPositionWasChanged:) name:AudioPlayerPlaybackPositionWasChangedNotification object:nil];
  [self updateSliderAndLabelValues];
}

- (void)updateSliderAndLabelValues
{
  [[self.genericView slider] setValue:(float)self.audioPlayerMC.audioTime animated:YES];
  [self.genericView label].text = [self remainingDurationString:(NSInteger)(self.audioPlayerMC.audioDuration - self.audioPlayerMC.audioTime)];
}

- (NSString *)remainingDurationString:(NSInteger)elapsedTime
{
  NSInteger seconds = elapsedTime % 60;
  NSInteger minutes = (elapsedTime / 60) % 60;
  NSInteger hours = (elapsedTime / 3600);
  return [NSString stringWithFormat:@"[%02i:%02i:%02i]", hours, minutes, seconds];
}
@end