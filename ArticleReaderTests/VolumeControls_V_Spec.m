#import "Kiwi.h"
#import "JA_VolumeControls_V.h"
#import "JA_Slider.h"

SPEC_BEGIN(JA_VolumeControls_V_Spec)
    __block JA_VolumeControls_V *_sut;

    beforeEach(^{
      _sut = [[JA_VolumeControls_V alloc] init];
    });

    describe(@"JA_VolumeControls_V", ^{
      it(@"Slider should not be nil", ^{
        [_sut.slider shouldNotBeNil];
      });
      it(@"Min volume button should not be nil", ^{
        [_sut.minVolumeButton shouldNotBeNil];
      });
      it(@"Max volume button should not be nil", ^{
        [_sut.maxVolumeButton shouldNotBeNil];
      });
    });
    SPEC_END