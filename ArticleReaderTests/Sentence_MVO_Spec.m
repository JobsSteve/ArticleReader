#import "Kiwi.h"
#import "JA_Sentence_MVO.h"

SPEC_BEGIN(JA_Sentence_MVO_Spec)
    __block JA_Sentence_MVO *_sut;

    beforeEach(^{
      _sut = [[JA_Sentence_MVO alloc] init];
      _sut.text = @"Sentence.";
      _sut.startIndex = 0;
    });

    describe(@"JA_Sentence_MVO", ^{
      it(@"Should return the end index", ^{
        [[theValue(_sut.endIndex) should] equal:theValue(9)];
      });
      it(@"Should return the sentence length", ^{
        [[theValue(_sut.sentenceLength) should] equal:theValue(9)];
      });
    });
    SPEC_END