#import "Kiwi.h"
#import "JA_TextContent_V.h"

SPEC_BEGIN(JA_TextContent_V_Spec)
    __block JA_TextContent_V *_sut;

    beforeEach(^{
      _sut = [[JA_TextContent_V alloc] init];
    });

    describe(@"JA_TextContent_V", ^{
      it(@"Text view should not be nil", ^{
        [_sut.textView shouldNotBeNil];
      });
      it(@"Highlight color should not be nil", ^{
        [[[JA_TextContent_V alloc] init].highlightColor shouldNotBeNil];
      });
    });
    SPEC_END