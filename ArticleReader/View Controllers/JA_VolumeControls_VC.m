#import "JA_VC.h"
#import "JA_VolumeControls_VC.h"
#import "JA_VolumeControls_V.h"
#import "JA_Slider.h"
#import "NotificationNames.h"
#import "JA_AudioPlayer_MC.h"

@implementation JA_VolumeControls_VC
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
  self.view = [[JA_VolumeControls_V alloc] initWithFrame:CGRectZero];
}

#pragma mark - Private Methods
- (void)addNotificationObservers
{
  [self.notificationCenter addObserver:self selector:@selector(audioPlayerDidLoadAudio:) name:AudioPlayerDidLoadAudioNotification object:nil];
  [self.notificationCenter addObserver:self selector:@selector(audioPlayerDidChangeVolume:) name:AudioPlayerVolumeDidChangeNotification object:nil];
}

- (void)addTargetActions
{
  [[self.genericView slider] addTarget:self action:@selector(sliderValueWasChanged:) forControlEvents:UIControlEventValueChanged];
  [[self.genericView minVolumeButton] addTarget:self action:@selector(minButtonWasTapped:) forControlEvents:UIControlEventTouchUpInside];
  [[self.genericView maxVolumeButton] addTarget:self action:@selector(maxButtonWasTapped:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)audioPlayerDidLoadAudio:(NSNotification *)notification
{
  [[self.genericView slider] setValue:self.audioPlayerMC.audioVolume animated:YES];
}

- (void)sliderValueWasChanged:(id)sender
{
  self.audioPlayerMC.audioVolume = [self.genericView slider].value;
}

- (void)minButtonWasTapped:(id)sender
{
  self.audioPlayerMC.audioVolume = 0;
  [[self.genericView slider] setValue:0 animated:YES];
}

- (void)maxButtonWasTapped:(id)sender
{
  self.audioPlayerMC.audioVolume = 1;
  [[self.genericView slider] setValue:1 animated:YES];
}

- (void)audioPlayerDidChangeVolume:(id)sender
{
  [[self.genericView slider] setValue:self.audioPlayerMC.audioVolume animated:YES];
}
@end