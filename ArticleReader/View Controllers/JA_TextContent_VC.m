#import "JA_VC.h"
#import "JA_TextContent_VC.h"
#import "NotificationNames.h"
#import "JA_Article_MVO.h"
#import "JA_TextContent_V.h"
#import "JA_Sentence_MVO.h"
#import "JA_AudioPlayer_MC.h"

@implementation JA_TextContent_VC
#pragma mark - Public Properties
- (UITapGestureRecognizer *)tapGesture
{
  if (!_tapGesture)
    _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textViewWasTapped:)];
  return _tapGesture;
}

#pragma mark - Public Methods
- (void)viewDidLoad
{
  [super viewDidLoad];
  [[self.genericView textView] addGestureRecognizer:self.tapGesture];
  [self.notificationCenter addObserver:self selector:@selector(audioPlayerDidLoadAudio:) name:AudioPlayerDidLoadAudioNotification object:nil];
  [self.notificationCenter addObserver:self selector:@selector(audioPlayerPlaybackPositionWasChanged:) name:AudioPlayerPlaybackPositionWasChangedNotification object:nil];
}

- (void)dealloc
{
  [self.notificationCenter removeObserver:self];
}

- (void)loadView
{
  self.view = [[JA_TextContent_V alloc] initWithFrame:CGRectZero];
}

#pragma mark - Private Methods
- (void)textViewWasTapped:(id)sender
{
  JA_Sentence_MVO *sentence = [self.articleMVO sentenceForIndex:[self indexOfTap]];
  [self.genericView highlightContent:NSMakeRange(sentence.startIndex, sentence.sentenceLength)];
  self.audioPlayerMC.audioTime = sentence.startSeconds;
}

- (NSInteger)indexOfTap
{
  UITextView *textView = [self.genericView textView];
  CGPoint tapLocation = [self.tapGesture locationInView:textView];
  UITextPosition *tappedTextPosition = [textView closestPositionToPoint:tapLocation];
  return [textView offsetFromPosition:textView.beginningOfDocument toPosition:tappedTextPosition];
}

- (void)audioPlayerDidLoadAudio:(NSNotification *)notification
{
  NSDictionary *attributes = @{
      NSFontAttributeName            : [UIFont fontWithName:@"AvenirNext-Regular" size:16],
      NSForegroundColorAttributeName : [UIColor blackColor]
  };
  NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:[self.articleMVO compiledSentences] attributes:attributes];
  [self.genericView textView].attributedText = attributedString;
  [self highlightContentForAudioTime];
  [[self.genericView textView] setContentOffset:CGPointZero animated:YES];
}

- (void)audioPlayerPlaybackPositionWasChanged:(NSNotification *)notification
{
  [self highlightContentForAudioTime];
}

- (void)highlightContentForAudioTime
{
  JA_Sentence_MVO *sentence = [self.articleMVO sentenceForSeconds:self.audioPlayerMC.audioTime];
  NSRange range = NSMakeRange(sentence.startIndex, sentence.sentenceLength);
  [self.genericView highlightContent:range];
  [[self.genericView textView] scrollRangeToVisible:range];
}
@end