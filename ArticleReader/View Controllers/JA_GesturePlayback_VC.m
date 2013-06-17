#import "JA_GesturePlayback_VC.h"
#import "JA_AudioPlayer_MC.h"
#import "JA_GesturePlayback_V.h"

@implementation JA_GesturePlayback_VC
#pragma mark - Public Properties
- (UITapGestureRecognizer *)tapGesture
{
  if (!_tapGesture)
    _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewWasTapped:)];
  return _tapGesture;
}

- (UILongPressGestureRecognizer *)longPressGesture
{
  if (!_longPressGesture)
    _longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(viewWasLongPressed:)];
  return _longPressGesture;
}

- (UISwipeGestureRecognizer *)leftSwipeGesture
{
  if (!_leftSwipeGesture) {
    _leftSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(viewWasSwipedLeft:)];
    _leftSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
  }
  return _leftSwipeGesture;
}

- (UISwipeGestureRecognizer *)rightSwipeGesture
{
  if (!_rightSwipeGesture) {
    _rightSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(viewWasSwipedRight:)];
    _rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
  }
  return _rightSwipeGesture;
}

- (UIPanGestureRecognizer *)panGesture
{
  if (!_panGesture) {
    _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(viewWasPanned:)];
    [_panGesture requireGestureRecognizerToFail:self.leftSwipeGesture];
    [_panGesture requireGestureRecognizerToFail:self.rightSwipeGesture];
  }
  return _panGesture;
}

#pragma mark - Public Methods
- (id)init
{
  self = [super init];
  if (self) {
    self.volumePanIncrement = 0.1;
  }
  return self;
}

- (void)viewDidLoad
{
  self.view.backgroundColor = [UIColor whiteColor];
  [self addGestureRecognizersToView];
  [self.view updateConstraints];
}

- (void)loadView
{
  self.view = [[JA_GesturePlayback_V alloc] initWithFrame:CGRectZero];
}

#pragma mark - Private Methods
- (void)addGestureRecognizersToView
{
  [self.view addGestureRecognizer:self.tapGesture];
  [self.view addGestureRecognizer:self.longPressGesture];
  [self.view addGestureRecognizer:self.leftSwipeGesture];
  [self.view addGestureRecognizer:self.rightSwipeGesture];
  [self.view addGestureRecognizer:self.panGesture];
}

- (void)viewWasTapped:(id)sender
{
  if ([self.audioPlayerMC isAudioPlaying])
    [self.audioPlayerMC stopAudio];
  else
    [self.audioPlayerMC startAudio];
}

- (void)viewWasLongPressed:(id)sender
{
  if (![self isBeingDismissed])
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWasSwipedLeft:(id)sender
{
  [self.audioPlayerMC jumpAudioBack];
}

- (void)viewWasSwipedRight:(id)sender
{
  [self.audioPlayerMC jumpAudioForward];
}

- (void)viewWasPanned:(id)sender
{
  CGPoint translatedPoint = [self.panGesture translationInView:self.view];

  if (translatedPoint.y < 0.0f)
    self.audioPlayerMC.audioVolume += self.volumePanIncrement;
  else if (translatedPoint.y > 0.0f)
    self.audioPlayerMC.audioVolume -= self.volumePanIncrement;

  [self.panGesture setTranslation:CGPointZero inView:self.view];
}
@end