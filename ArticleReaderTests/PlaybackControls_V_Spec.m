#import "Kiwi.h"
#import "JA_PlaybackControls_V.h"

SPEC_BEGIN(JA_PlaybackControls_V_Spec)
    __block JA_PlaybackControls_V *_sut;

    beforeEach(^{
      _sut = [[JA_PlaybackControls_V alloc] init];
    });

    describe(@"JA_PlaybackControls_V", ^{
      it(@"Play button should not be nil", ^{
        [_sut.startButton shouldNotBeNil];
      });
      it(@"Stop button should not be nil", ^{
        [_sut.pauseButton shouldNotBeNil];
      });
      it(@"Jump back button should not be nil", ^{
        [_sut.jumpBackButton shouldNotBeNil];
      });
      it(@"Jump forward button should not be nil", ^{
        [_sut.jumpForwardButton shouldNotBeNil];
      });
      it(@"Gesture mode button should not be nil", ^{
        [_sut.gestureModeButton shouldNotBeNil];
      });
    });
    SPEC_END