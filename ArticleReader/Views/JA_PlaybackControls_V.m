#import "JA_PlaybackControls_V.h"

@implementation JA_PlaybackControls_V
#pragma mark - Public Properties
- (UIButton *)startButton
{
  if (!_startButton) {
    _startButton = [[UIButton alloc] init];
    [_startButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_startButton setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    [self addSubview:_startButton];
  }
  return _startButton;
}

- (UIButton *)pauseButton
{
  if (!_pauseButton) {
    _pauseButton = [[UIButton alloc] init];
    [_pauseButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_pauseButton setImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
    _pauseButton.hidden = YES;
    [self addSubview:_pauseButton];
  }
  return _pauseButton;
}

- (UIButton *)jumpBackButton
{
  if (!_jumpBackButton) {
    _jumpBackButton = [[UIButton alloc] init];
    [_jumpBackButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_jumpBackButton setImage:[UIImage imageNamed:@"jump_back.png"] forState:UIControlStateNormal];
    [self addSubview:_jumpBackButton];
  }
  return _jumpBackButton;
}

- (UIButton *)jumpForwardButton
{
  if (!_jumpForwardButton) {
    _jumpForwardButton = [[UIButton alloc] init];
    [_jumpForwardButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_jumpForwardButton setImage:[UIImage imageNamed:@"jump_forward.png"] forState:UIControlStateNormal];
    [self addSubview:_jumpForwardButton];
  }
  return _jumpForwardButton;
}

- (UIButton *)gestureModeButton
{
  if (!_gestureModeButton) {
    _gestureModeButton = [[UIButton alloc] init];
    [_gestureModeButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_gestureModeButton setImage:[UIImage imageNamed:@"gesture.png"] forState:UIControlStateNormal];
    [self addSubview:_gestureModeButton];
  }
  return _gestureModeButton;
}

#pragma mark - Public Methods
- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.opaque = NO;
  }
  return self;
}

- (void)updateConstraints
{
  [super updateConstraints];

  NSDictionary *views = @{
      @"self"               : self,
      @"startButton"         : self.startButton,
      @"pauseButton"         : self.pauseButton,
      @"jumpBackButton"     : self.jumpBackButton,
      @"jumpForwardButton"  : self.jumpForwardButton,
      @"gestureModeButton"  : self.gestureModeButton
  };

  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[self(44)]" options:NSLayoutFormatAlignAllLeft metrics:nil views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[jumpBackButton]|" options:NSLayoutFormatAlignAllLeft metrics:nil views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[jumpBackButton(>=44)]-[startButton(==jumpBackButton)]-[jumpForwardButton(==jumpBackButton)]-[gestureModeButton(==jumpBackButton)]|"
                                                               options:NSLayoutFormatAlignAllCenterY metrics:nil views:views]];

  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[pauseButton(==startButton)]" options:NSLayoutFormatAlignAllLeft metrics:nil views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[pauseButton(==startButton)]|" options:NSLayoutFormatAlignAllTop metrics:nil views:views]];
  [self addConstraint:[NSLayoutConstraint constraintWithItem:self.pauseButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.startButton
                                                   attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
  [self addConstraint:[NSLayoutConstraint constraintWithItem:self.pauseButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.startButton
                                                   attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
}

- (void)drawRect:(CGRect)rect
{
  [super drawRect:rect];

  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetLineWidth(context, 1);
  CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:155.0 / 255 green:155.0 / 255 blue:155.0 / 255 alpha:155.0 / 255].CGColor);

  CGContextMoveToPoint(context, 0, 0);
  CGContextAddLineToPoint(context, self.bounds.size.width, 0);

  CGContextStrokePath(context);
}
@end