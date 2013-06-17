#import "JA_Slider.h"
#import "Kiwi.h"
#import "JA_ScrubControls_VC.h"
#import "JA_AudioPlayer_MC.h"
#import "JA_Article_MVO.h"
#import "NotificationNames.h"
#import "JA_ScrubControls_V.h"
#import "JA_VolumeControls_V.h"
#import <objc/message.h>

SPEC_BEGIN(JA_ScrubControls_VC_Spec)
    __block JA_ScrubControls_VC *_sut;

    beforeEach(^{
      id scrubControlsVMock = [JA_ScrubControls_V nullMock];
      [scrubControlsVMock stub:@selector(slider) andReturn:[JA_Slider nullMock]];
      [scrubControlsVMock stub:@selector(label) andReturn:[UILabel nullMock]];

      _sut = [[JA_ScrubControls_VC alloc] init];
      _sut.view = scrubControlsVMock;
      _sut.audioPlayerMC = [JA_AudioPlayer_MC nullMock];
      _sut.articleMVO = [JA_Article_MVO nullMock];
      _sut.notificationCenter = [NSNotificationCenter nullMock];
    });

    describe(@"JA_ScrubControls_VC", ^{
      it(@"Should respond to audio polling timer notifications", ^{
        [[_sut.notificationCenter should] receive:@selector(addObserver:selector:name:object:) withArguments:_sut, any(), AudioPlayerPlaybackPositionWasChangedNotification, any()];

        [_sut viewDidLoad];
      });
      it(@"Should update the slider value in accordance to the audio player ", ^{
        [_sut.audioPlayerMC stub:@selector(audioTime) andReturn:theValue(25)];

        [[[_sut.genericView slider] should] receive:@selector(setValue:animated:) withArguments:theValue(25), any()];

        objc_msgSend(_sut, @selector(updateSliderAndLabelValues));
      });
      it(@"Should update the label value in accordance to audio player", ^{
        [_sut.audioPlayerMC stub:@selector(audioTime) andReturn:theValue(25)];
        [_sut.audioPlayerMC stub:@selector(audioDuration) andReturn:theValue(50)];
        NSString *expectedString = [NSString stringWithFormat:@"[00:00:25]"];

        [[[_sut.genericView label] should] receive:@selector(setText:) withArguments:expectedString];

        objc_msgSend(_sut, @selector(updateSliderAndLabelValues));
      });
      it(@"When the audio data update notification fires, the slider value should update", ^{
        [[[_sut.genericView slider] should] receive:@selector(setValue:animated:)];

        objc_msgSend(_sut, @selector(audioPlayerPlaybackPositionWasChanged:), nil);
      });
      it(@"When the audio data update notification fires, the label should update", ^{
        [[[_sut.genericView label] should] receive:@selector(setText:)];

        objc_msgSend(_sut, @selector(audioPlayerPlaybackPositionWasChanged:), nil);
      });
      it(@"When the audio data is loaded, the slider's min and max values should be set", ^{
        [_sut.audioPlayerMC stub:@selector(audioDuration) andReturn:theValue(10)];

        [[[_sut.genericView slider] should] receive:@selector(setMinimumValue:) withArguments:theValue(0)];
        [[[_sut.genericView slider] should] receive:@selector(setMaximumValue:) withArguments:theValue(10)];

        objc_msgSend(_sut, @selector(audioPlayerDidLoadAudio:), nil);
      });
      it(@"Should respond to audio loading notification", ^{
        [[_sut.notificationCenter should] receive:@selector(addObserver:selector:name:object:) withArguments:_sut, any(), AudioPlayerDidLoadAudioNotification, any()];

        [_sut viewDidLoad];
      });
      it(@"When audio is loaded, the slider and label should be updated", ^{
        [[[_sut.genericView slider] should] receive:@selector(setValue:animated:)];
        [[[_sut.genericView label] should] receive:@selector(setText:)];

        objc_msgSend(_sut, @selector(audioPlayerDidLoadAudio:), nil);
      });
      it(@"Slider should respond to touch down events", ^{
        [[[_sut.genericView slider] should] receive:@selector(addTarget:action:forControlEvents:) withArguments:_sut, any(), theValue(UIControlEventTouchDown)];

        [_sut viewDidLoad];
      });
      it(@"Slider should respond to drag events", ^{
        [[[_sut.genericView slider] should] receive:@selector(addTarget:action:forControlEvents:) withArguments:_sut, any(), theValue(UIControlEventTouchDragInside | UIControlEventTouchDragOutside)];

        [_sut viewDidLoad];
      });
      it(@"Slider should respond to touch up events", ^{
        [[[_sut.genericView slider] should] receive:@selector(addTarget:action:forControlEvents:) withArguments:_sut, any(), theValue(UIControlEventTouchUpInside | UIControlEventTouchUpOutside)];

        [_sut viewDidLoad];
      });
      it(@"When slider is touched down, it should stop observering playback polling timer notifications", ^{
        [[_sut.notificationCenter should] receive:@selector(removeObserver:name:object:) withArguments:_sut, AudioPlayerPlaybackPositionWasChangedNotification, any()];

        objc_msgSend(_sut, @selector(sliderWasTouchedDown:), nil);
      });
      it(@"When the slider value is changed via drag, it should scrub the audio player, and the label's text should be updated", ^{
        [_sut.audioPlayerMC stub:@selector(audioDuration) andReturn:theValue(10)];
        [[_sut.genericView slider] stub:@selector(value) andReturn:theValue(5)];

        [[_sut.audioPlayerMC should] receive:@selector(scrubToTime:) withArguments:theValue(5)];
        [[[_sut.genericView label] should] receive:@selector(setText:)];

        objc_msgSend(_sut, @selector(sliderWasDragged:), nil);
      });
      it(@"When the slider is touched up, it should continue to receiving playback polling timer notifications, and update the label and slider values", ^{
        [[_sut.notificationCenter should] receive:@selector(addObserver:selector:name:object:) withArguments:_sut, any(), AudioPlayerPlaybackPositionWasChangedNotification, any()];
        [[[_sut.genericView slider] should] receive:@selector(setValue:animated:)];
        [[[_sut.genericView label] should] receive:@selector(setText:)];

        objc_msgSend(_sut, @selector(sliderWasTouchedUp:), nil);
      });
    });
    SPEC_END