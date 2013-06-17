#import "JA_Sentence_MVO.h"
#import "JA_Article_MVO.h"
#import "JA_ExampleArticle_Factory.h"

@implementation JA_ExampleArticle_Factory
#pragma mark - Public Methods
+ (JA_Article_MVO *)exampleArticle
{
  JA_Article_MVO *article = [[JA_Article_MVO alloc] init];
  article.title = @"Biff Meets Biff";
  article.audioFileName = @"back_to_the_future_2_audio";
  article.sentences = [self makeSentences];
  return article;
}

#pragma mark - Private Methods
+ (NSOrderedSet *)makeSentences
{
  NSArray *sentenceStrings = [self makeSentenceTexts];
  NSArray *sentenceStartIndexes = [self makeSentenceStartingIndexes:sentenceStrings];
  NSArray *sentenceStartSeconds = [self makeSentenceStartSeconds];

  NSMutableOrderedSet *sentences = [NSMutableOrderedSet orderedSet];
  for (NSUInteger i = 0; i < [sentenceStrings count]; i++) {
    JA_Sentence_MVO *sentence = [[JA_Sentence_MVO alloc] init];
    sentence.text = sentenceStrings[i];
    sentence.startIndex = [sentenceStartIndexes[i] unsignedIntegerValue];
    sentence.startSeconds = [sentenceStartSeconds[i] floatValue];
    [sentences addObject:sentence];
  }
  return sentences;
}

+ (NSArray *)makeSentenceStartSeconds
{
  return @[
      @0,
      @9,
      @14.75,
      @29.25,
      @35.75,
      @39.75,
      @47.15
  ];
}

+ (NSArray *)makeSentenceStartingIndexes:(NSArray *)sentenceStrings
{
  NSMutableArray *sentenceStartIndexes = [NSMutableArray array];
  NSInteger indexCount = 0;
  for (NSString *aSentence in sentenceStrings) {
    [sentenceStartIndexes addObject:[NSNumber numberWithInteger:indexCount]];
    indexCount += [aSentence length];
  }
  return sentenceStartIndexes;
}

+ (NSArray *)makeSentenceTexts
{
  return @[
      @"2015 Biff: Let's just say we're related Biff, and that being the case I got a little present for you. Something that'll make you rich. You wanna be rich, don't ya?\r\r",
      @"1955 Biff: Oh yeah, sure, right, that's rich, ha ha, you're gonna make me rich!\r\r",
      @"2015 Biff: You see this book? This book tells the future. It tells the events of every major sports event til the end of the century. Football, baseball, horse races, boxing...the information in here is worth millions, and I'm giving it to you.\r\r",
      @"1955 Biff: Well, that's very nice, thank you very much. Now why don't you make like a tree and get out of here?\r\r",
      @"(2015 Biff gives 1955 Biff a slap across the head.)\r\r",
      @"2015 Biff: It's leave, you idiot! \"Make like a tree, and leave.\" You sound like a damn fool when you say it wrong!\r\r",
      @"1955 Biff: Alright then, leave! (He throws the book in the back of the car. 2015 Biff catches it.) And take your book with you!"
  ];
}
@end