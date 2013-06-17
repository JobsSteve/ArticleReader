#import "JA_Playback_VC.h"
#import "JA_ScrubControls_VC.h"
#import "JA_TextContent_VC.h"
#import "JA_PlaybackControls_VC.h"
#import "JA_VolumeControls_VC.h"
#import "JA_AudioPlayer_MC.h"
#import "JA_Article_MVO.h"

@implementation JA_Playback_VC
#pragma mark - Public Properties
- (JA_PlaybackControls_VC *)playbackControlsVC
{
  if (!_playbackControlsVC) {
    _playbackControlsVC = [[JA_PlaybackControls_VC alloc] init];
    _playbackControlsVC.audioPlayerMC = self.audioPlayerMC;
    _playbackControlsVC.articleMVO = self.articleMVO;
    _playbackControlsVC.notificationCenter = self.notificationCenter;
  }
  return _playbackControlsVC;
}

- (JA_ScrubControls_VC *)scrubControlsVC
{
  if (!_scrubControlsVC) {
    _scrubControlsVC = [[JA_ScrubControls_VC alloc] init];
    _scrubControlsVC.audioPlayerMC = self.audioPlayerMC;
    _scrubControlsVC.articleMVO = self.articleMVO;
    _scrubControlsVC.notificationCenter = self.notificationCenter;
  }
  return _scrubControlsVC;
}

- (JA_TextContent_VC *)textContentVC
{
  if (!_textContentVC) {
    _textContentVC = [[JA_TextContent_VC alloc] init];
    _textContentVC.audioPlayerMC = self.audioPlayerMC;
    _textContentVC.articleMVO = self.articleMVO;
    _textContentVC.notificationCenter = self.notificationCenter;
  }
  return _textContentVC;
}

- (JA_VolumeControls_VC *)volumeControlsVC
{
  if (!_volumeControlsVC) {
    _volumeControlsVC = [[JA_VolumeControls_VC alloc] init];
    _volumeControlsVC.audioPlayerMC = self.audioPlayerMC;
    _volumeControlsVC.articleMVO = self.articleMVO;
    _volumeControlsVC.notificationCenter = self.notificationCenter;
  }
  return _volumeControlsVC;
}

#pragma mark - Public Methods
- (void)viewDidLoad
{
  [super viewDidLoad];
  [self addChildViewControllers];
  self.navigationItem.title = self.articleMVO.title;
  [self.view updateConstraintsIfNeeded];
  [self.audioPlayerMC loadAudioWithContentsOfURL:[[NSBundle mainBundle] URLForResource:self.articleMVO.audioFileName withExtension:@"mp3"]];
}

- (void)updateViewConstraints
{
  [super updateViewConstraints];
  NSDictionary *views = @{
      @"selfV"             : self.view,
      @"scrubControlsV"    : self.scrubControlsVC.view,
      @"textContentV"      : self.textContentVC.view,
      @"playbackControlsV" : self.playbackControlsVC.view,
      @"volumeControlsV"   : self.volumeControlsVC.view
  };

  [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[scrubControlsV]|" options:NSLayoutFormatAlignAllTop metrics:nil views:views]];
  [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrubControlsV][textContentV][playbackControlsV][volumeControlsV]|" options:NSLayoutFormatAlignAllLeft metrics:nil views:views]];

  [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[textContentV]|" options:NSLayoutFormatAlignAllTop metrics:nil views:views]];
  [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[playbackControlsV]|" options:NSLayoutFormatAlignAllTop metrics:nil views:views]];
  [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[volumeControlsV]|" options:NSLayoutFormatAlignAllTop metrics:nil views:views]];
}

#pragma mark - Private Properties
- (void)addChildViewControllers
{
  [self addChildViewController:self.scrubControlsVC];
  [self.view addSubview:self.scrubControlsVC.view];

  [self addChildViewController:self.textContentVC];
  [self.view addSubview:self.textContentVC.view];

  [self addChildViewController:self.playbackControlsVC];
  [self.view addSubview:self.playbackControlsVC.view];

  [self addChildViewController:self.volumeControlsVC];
  [self.view addSubview:self.volumeControlsVC.view];
}
@end