#import "JA_VolumeControls_V.h"
#import "JA_Slider.h"

@implementation JA_VolumeControls_V
#pragma mark - Public Properties
- (JA_Slider *)slider
{
  if (!_slider) {
    _slider = [[JA_Slider alloc] init];
    [_slider setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_slider];
  }
  return _slider;
}

- (UIButton *)minVolumeButton
{
  if (!_minVolumeButton) {
    _minVolumeButton = [[UIButton alloc] init];
    [_minVolumeButton setImage:[UIImage imageNamed:@"min_volume.png"] forState:UIControlStateNormal];
    [_minVolumeButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_minVolumeButton];
  }
  return _minVolumeButton;
}

- (UIButton *)maxVolumeButton
{
  if (!_maxVolumeButton) {
    _maxVolumeButton = [[UIButton alloc] init];
    [_maxVolumeButton setImage:[UIImage imageNamed:@"max_volume.png"] forState:UIControlStateNormal];
    [_maxVolumeButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_maxVolumeButton];
  }
  return _maxVolumeButton;
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
      @"self"      : self,
      @"slider"    : self.slider,
      @"minVolumeButton" : self.minVolumeButton,
      @"maxVolumeButton" : self.maxVolumeButton
  };

  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[self(44)]" options:NSLayoutFormatAlignAllLeft metrics:nil views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[minVolumeButton]|" options:NSLayoutFormatAlignAllLeft metrics:nil views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[maxVolumeButton(==minVolumeButton)]|" options:NSLayoutFormatAlignAllLeft metrics:nil views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[minVolumeButton(44)][slider][maxVolumeButton(44)]|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:views]];
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