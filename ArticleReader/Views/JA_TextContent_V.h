@interface JA_TextContent_V : UIView
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIColor *highlightColor;
- (void)highlightContent:(NSRange)range;
@end