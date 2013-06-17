#import "Kiwi.h"
#import "JA_Article_MVO.h"
#import "JA_Sentence_MVO.h"

SPEC_BEGIN(JA_Article_MVO_Spec)
    __block JA_Article_MVO *_sut;

    beforeEach(^{
      id sentenceMock1 = [JA_Sentence_MVO nullMock];
      [sentenceMock1 stub:@selector(text) andReturn:@"Sentence1."];
      [sentenceMock1 stub:@selector(startIndex) andReturn:theValue(0)];
      [sentenceMock1 stub:@selector(endIndex) andReturn:theValue(10)];
      [sentenceMock1 stub:@selector(startSeconds) andReturn:theValue(0)];

      id sentenceMock2 = [JA_Sentence_MVO nullMock];
      [sentenceMock2 stub:@selector(text) andReturn:@"Sentence2."];
      [sentenceMock2 stub:@selector(startIndex) andReturn:theValue(10)];
      [sentenceMock2 stub:@selector(endIndex) andReturn:theValue(20)];
      [sentenceMock2 stub:@selector(startSeconds) andReturn:theValue(10)];

      id sentenceMock3 = [JA_Sentence_MVO nullMock];
      [sentenceMock3 stub:@selector(text) andReturn:@"Sentence3."];
      [sentenceMock3 stub:@selector(startIndex) andReturn:theValue(20)];
      [sentenceMock3 stub:@selector(endIndex) andReturn:theValue(30)];
      [sentenceMock3 stub:@selector(startSeconds) andReturn:theValue(20)];

      _sut = [[JA_Article_MVO alloc] init];
      _sut.sentences = [NSMutableOrderedSet orderedSetWithObjects:sentenceMock1, sentenceMock2, sentenceMock3, nil];
    });

    describe(@"JA_Article_MVO", ^{
      it(@"Should return a compiled sentence", ^{
        [[[_sut compiledSentences] should] equal:@"Sentence1.Sentence2.Sentence3."];
      });
      it(@"Should return the sentence that corresponds to an index", ^{
        [[[_sut sentenceForIndex:0] should] equal:_sut.sentences[0]];
        [[[_sut sentenceForIndex:15] should] equal:_sut.sentences[1]];
        [[[_sut sentenceForIndex:28] should] equal:_sut.sentences[2]];
      });
      it(@"Should return the sentence that corresponds to seconds", ^{
        [[[_sut sentenceForSeconds:0] should] equal:_sut.sentences[0]];
        [[[_sut sentenceForSeconds:15] should] equal:_sut.sentences[1]];
        [[[_sut sentenceForSeconds:28] should] equal:_sut.sentences[2]];
      });
    });
    SPEC_END