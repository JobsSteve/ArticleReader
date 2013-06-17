#import "Kiwi.h"
#import "JA_VC.h"

SPEC_BEGIN(JA_VC_Spec)
    __block JA_VC *_sut;

    beforeEach(^{
      _sut = [[JA_VC alloc] init];
    });

    describe(@"JA_VC", ^{
      it(@"Generic view should return main view", ^{
        [[_sut.genericView should] equal:_sut.view];
      });
    });
    SPEC_END