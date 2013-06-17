#import "Kiwi.h"
#import "JA_ScrubControls_V.h"
#import "JA_Slider.h"

SPEC_BEGIN(JA_ScrubControls_V_Spec)
    __block JA_ScrubControls_V *_sut;

    beforeEach(^{
      _sut = [[JA_ScrubControls_V alloc] init];
    });

    describe(@"JA_ScrubControls_V", ^{
      it(@"Slider should not be nil", ^{
        [_sut.slider shouldNotBeNil];
      });
      it(@"Label should not be nil", ^{
        [_sut.label shouldNotBeNil];
      });
    });
    SPEC_END