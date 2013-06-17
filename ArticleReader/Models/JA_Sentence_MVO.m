#import "JA_Sentence_MVO.h"

@implementation JA_Sentence_MVO
- (NSUInteger)endIndex
{
  return self.startIndex + self.sentenceLength;
}

- (NSUInteger)sentenceLength
{
  return [self.text length];
}
@end