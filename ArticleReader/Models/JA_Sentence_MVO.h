@interface JA_Sentence_MVO : NSObject
@property (nonatomic, strong) NSString *text;
@property (nonatomic, assign) NSUInteger startIndex;
@property (nonatomic, assign, readonly) NSUInteger endIndex;
@property (nonatomic, assign, readonly) NSUInteger sentenceLength;
@property (nonatomic, assign) NSTimeInterval startSeconds;
@end