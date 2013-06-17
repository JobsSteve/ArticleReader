#import "JA_Slider.h"

@implementation JA_Slider
#pragma mark - Public Methods
- (id)init
{
  self = [super init];
  if (self) {
    [self setThumbImage:[UIImage imageNamed:@"thumb.png"] forState:UIControlStateNormal];
    UIEdgeInsets insets = UIEdgeInsetsMake(1, 5, 1, 5);
    UIImage *minImage = [[UIImage imageNamed:@"track_min.png"] resizableImageWithCapInsets:insets];
    UIImage *maxImage = [[UIImage imageNamed:@"track_max.png"] resizableImageWithCapInsets:insets];
    [self setMinimumTrackImage:minImage forState:UIControlStateNormal];
    [self setMaximumTrackImage:maxImage forState:UIControlStateNormal];
  }
  return self;
}
@end