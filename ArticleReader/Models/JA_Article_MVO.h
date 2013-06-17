@class JA_Sentence_MVO;

@interface JA_Article_MVO : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *audioFileName;
@property (nonatomic, strong) NSOrderedSet* sentences;
- (NSString *)compiledSentences;
- (JA_Sentence_MVO *)sentenceForIndex:(NSInteger)index;
- (JA_Sentence_MVO *)sentenceForSeconds:(NSTimeInterval)seconds;
@end