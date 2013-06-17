#import "JA_GesturePlayback_V.h"

@implementation JA_GesturePlayback_V
#pragma mark - Public Properties
- (UIImageView *)startStopImageV
{
  if (!_startStopImageV)
    _startStopImageV = [self imageVWithImageName:@"start_stop_diagram.png"];
  return _startStopImageV;
}

- (UIImageView *)exitImageV
{
  if (!_exitImageV)
    _exitImageV = [self imageVWithImageName:@"exit_diagram.png"];
  return _exitImageV;
}

- (UIImageView *)navigationImageV
{
  if (!_navigationImageV)
    _navigationImageV = [self imageVWithImageName:@"article_navigation_diagram.png"];
  return _navigationImageV;
}

#pragma mark - Public Methods
- (void)updateConstraints
{
  [super updateConstraints];
  NSDictionary *views = @{
      @"self"             : self, @"startStopImageV" : self.startStopImageV,
      @"exitImageV"       : self.exitImageV,
      @"navigationImageV" : self.navigationImageV
  };

  NSDictionary *metrics = @{
      @"padding" : [NSNumber numberWithFloat:15.0f], @"padding2" : [NSNumber numberWithFloat:15.0f * 2]
  };

  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(padding)-[startStopImageV]" options:NSLayoutFormatAlignAllTop metrics:metrics views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(padding)-[startStopImageV]" options:NSLayoutFormatAlignAllLeft metrics:metrics views:views]];

  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[exitImageV]-(padding)-|" options:NSLayoutFormatAlignAllTop metrics:metrics views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(padding)-[exitImageV]" options:NSLayoutFormatAlignAllLeft metrics:metrics views:views]];

  [self addConstraint:[NSLayoutConstraint constraintWithItem:self.navigationImageV attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self
                                                   attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
  [self addConstraint:[NSLayoutConstraint constraintWithItem:self.navigationImageV attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationLessThanOrEqual toItem:self
                                                   attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
}

#pragma mark - Private Methods
- (UIImageView *)imageVWithImageName:(NSString *)imageName
{
  UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
  imageView.translatesAutoresizingMaskIntoConstraints = NO;
  imageView.contentMode = UIViewContentModeCenter;
  [self addSubview:imageView];
  return imageView;
}
@end