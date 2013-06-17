#import "JA_TextContent_V.h"
#import "JA_TextView.h"

@implementation JA_TextContent_V
#pragma mark - Public Properties
- (UITextView *)textView
{
  if (!_textView) {
    _textView = [[JA_TextView alloc] initWithFrame:CGRectZero];
    _textView.editable = NO;
    _textView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_textView];
  }
  return _textView;
}

- (UIColor *)highlightColor
{
  if (!_highlightColor)
    _highlightColor = [UIColor magentaColor];
  return _highlightColor;
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
      @"self"     : self,
      @"textView" : self.textView
  };

  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[textView]|" options:NSLayoutFormatAlignAllTop metrics:nil views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[textView]|" options:NSLayoutFormatAlignAllLeft metrics:nil views:views]];
}

- (void)highlightContent:(NSRange)range
{
  NSMutableAttributedString *mutableContent = [[NSMutableAttributedString alloc] initWithAttributedString:self.textView.attributedText];
  [mutableContent removeAttribute:NSBackgroundColorAttributeName range:NSMakeRange(0, self.textView.text.length)];
  [mutableContent addAttribute:NSBackgroundColorAttributeName value:self.highlightColor range:range];
  self.textView.attributedText = mutableContent;
}
@end