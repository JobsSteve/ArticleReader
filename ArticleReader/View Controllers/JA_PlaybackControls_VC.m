#import "JA_VC.h"
#import "JA_PlaybackControls_VC.h"
#import "JA_PlaybackControls_V.h"
#import "JA_AudioPlayer_MC.h"
#import "JA_GesturePlayback_VC.h"
#import "NotificationNames.h"

@implementation JA_PlaybackControls_VC
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
  self.view = [[JA_PlaybackControls_V alloc] initWithFrame:CGRectZero];
}

#pragma mark - Private Methods
- (void)addNotificationObservers
{
  [self.notificationCenter addObserver:self selector:@selector(audioPlayerWillStartPlaying:) name:AudioPlayerWillStartPlayingNotification object:nil];
  [self.notificationCenter addObserver:self selector:@selector(audioPlayerWillStopPlaying:) name:AudioPlayerWillStopPlayingNotification object:nil];
}

- (void)addTargetActions
{
  [[self.genericView startButton] addTarget:self action:@selector(startButtonWasTapped:) forControlEvents:UIControlEventTouchUpInside];
  [[self.genericView pauseButton] addTarget:self action:@selector(stopButtonWasTapped:) forControlEvents:UIControlEventTouchUpInside];
  [[self.genericView jumpBackButton] addTarget:self action:@selector(jumpBackButtonWasTapped:) forControlEvents:UIControlEventTouchUpInside];
  [[self.genericView jumpForwardButton] addTarget:self action:@selector(jumpForwardButtonWasTapped:) forControlEvents:UIControlEventTouchUpInside];
  [[self.genericView gestureModeButton] addTarget:self action:@selector(gestureModeButtonWasTapped:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)startButtonWasTapped:(id)sender
{
  [self.audioPlayerMC startAudio];
}

- (void)stopButtonWasTapped:(id)sender
{
  [self.audioPlayerMC stopAudio];
}

- (void)jumpBackButtonWasTapped:(id)sender
{
  [self.audioPlayerMC jumpAudioBack];
}

- (void)jumpForwardButtonWasTapped:(id)sender
{
  [self.audioPlayerMC jumpAudioForward];
}

- (void)gestureModeButtonWasTapped:(id)sender
{
  [self presentViewController:[self makeGesturePlaybackVC] animated:YES completion:nil];
}

- (void)audioPlayerWillStartPlaying:(NSNotification *)notification
{
  [self.genericView startButton].hidden = YES;
  [self.genericView pauseButton].hidden = NO;
}

- (void)audioPlayerWillStopPlaying:(NSNotification *)notification
{
  [self.genericView startButton].hidden = NO;
  [self.genericView pauseButton].hidden = YES;
}

- (JA_GesturePlayback_VC *)makeGesturePlaybackVC
{
  JA_GesturePlayback_VC *gesturePlaybackVC = [[JA_GesturePlayback_VC alloc] init];
  gesturePlaybackVC.audioPlayerMC = self.audioPlayerMC;
  gesturePlaybackVC.articleMVO = self.articleMVO;
  gesturePlaybackVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
  return gesturePlaybackVC;
}
@end