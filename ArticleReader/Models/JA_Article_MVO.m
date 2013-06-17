#import "JA_Article_MVO.h"
#import "JA_Sentence_MVO.h"

@implementation JA_Article_MVO
#pragma mark - Public Methods
- (NSString *)compiledSentences
{
  NSMutableArray *stringArray = [NSMutableArray array];
  for (JA_Sentence_MVO *aSentence in self.sentences)
    [stringArray addObject:aSentence.text];

  return [stringArray componentsJoinedByString:@""];
}

- (JA_Sentence_MVO *)sentenceForIndex:(NSInteger)index
{
  NSUInteger foundIndex = [self.sentences indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
    if (obj == [self.sentences lastObject])
      return YES;
    else
      return (index >= [obj startIndex]) && (index < [obj endIndex]);
  }];
  return self.sentences[foundIndex];
}

- (JA_Sentence_MVO *)sentenceForSeconds:(NSTimeInterval)seconds
{
  NSUInteger foundIndex = [self.sentences indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
    if (obj == [self.sentences lastObject])
      return YES;
    else {
      JA_Sentence_MVO *sentence1 = obj;
      JA_Sentence_MVO *sentence2 = self.sentences[idx + 1];
      return (seconds >= sentence1.startSeconds) && (seconds < sentence2.startSeconds);
    }
  }];
  return self.sentences[foundIndex];
}
@end