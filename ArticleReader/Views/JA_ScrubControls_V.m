#import "JA_ScrubControls_V.h"
#import "JA_Slider.h"

@implementation JA_ScrubControls_V
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

- (UILabel *)label
{
  if (!_label) {
    _label = [[UILabel alloc] init];
    [_label setTranslatesAutoresizingMaskIntoConstraints:NO];
    _label.text = @"[00:00:00]";
    _label.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:12];
    _label.textColor = [UIColor colorWithRed:155.0 / 255 green:155.0 / 255 blue:155.0 / 255 alpha:155.0 / 255];
    _label.textAlignment = NSTextAlignmentRight;
    [self addSubview:_label];
  }
  return _label;
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
      @"self"   : self,
      @"slider" : self.slider,
      @"label"  : self.label
  };

  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[self(44)]" options:NSLayoutFormatAlignAllLeft metrics:nil views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[slider]|" options:NSLayoutFormatAlignAllLeft metrics:nil views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-12-[slider]-10-[label(>=30)]-12-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:views]];
}

- (void)drawRect:(CGRect)rect
{
  [super drawRect:rect];

  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetLineWidth(context, 1);
  CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:155.0 / 255 green:155.0 / 255 blue:155.0 / 255 alpha:155.0 / 255].CGColor);

  CGContextMoveToPoint(context, 0, self.bounds.size.height);
  CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height);

  CGContextStrokePath(context);
}
@end