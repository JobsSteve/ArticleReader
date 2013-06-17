#import <objc/message.h>
#import "Kiwi.h"
#import "JA_VC.h"
#import "JA_VolumeControls_VC.h"
#import "JA_VolumeControls_V.h"
#import "JA_Slider.h"
#import "JA_AudioPlayer_MC.h"
#import "NotificationNames.h"

SPEC_BEGIN(JA_VolumeControls_VC_Spec)
    __block JA_VolumeControls_VC *_sut;

    beforeEach(^{
      id volumeControlsVMock = [JA_VolumeControls_V nullMock];
      [volumeControlsVMock stub:@selector(slider) andReturn:[JA_Slider nullMock]];
      [volumeControlsVMock stub:@selector(minVolumeButton) andReturn:[UIButton nullMock]];
      [volumeControlsVMock stub:@selector(maxVolumeButton) andReturn:[UIButton nullMock]];

      _sut = [[JA_VolumeControls_VC alloc] init];
      _sut.view = volumeControlsVMock;
      _sut.audioPlayerMC = [JA_AudioPlayer_MC nullMock];
      _sut.notificationCenter = [[NSNotificationCenter alloc] init];
    });

    describe(@"JA_VolumeControls_VC", ^{
      it(@"Slider should respond to value changes", ^{
        [[[_sut.genericView slider] should] receive:@selector(addTarget:action:forControlEvents:) withArguments:_sut, any(), theValue(UIControlEventValueChanged)];

        [_sut viewDidLoad];
      });
      it(@"When changing the slider value, the audio player's volume should change", ^{
        [[_sut.genericView slider] stub:@selector(value) andReturn:theValue(0.75)];

        [[_sut.audioPlayerMC should] receive:@selector(setAudioVolume:) withArguments:theValue(0.75)];

        objc_msgSend(_sut, @selector(sliderValueWasChanged:), nil);
      });
      it(@"Min volume button should respond to tapping", ^{
        [[[_sut.genericView minVolumeButton] should] receive:@selector(addTarget:action:forControlEvents:) withArguments:_sut, any(), theValue(UIControlEventTouchUpInside)];

        [_sut viewDidLoad];
      });
      it(@"When the min volume button is tapped it should set the audio volume and slider to 0", ^{
        [[_sut.audioPlayerMC should] receive:@selector(setAudioVolume:) withArguments:theValue(0)];
        [[[_sut.genericView slider] should] receive:@selector(setValue:animated:) withArguments:theValue(0), any()];

        objc_msgSend(_sut, @selector(minButtonWasTapped:), nil);
      });
      it(@"Max volume button should respond to tapping", ^{
        [[[_sut.genericView maxVolumeButton] should] receive:@selector(addTarget:action:forControlEvents:) withArguments:_sut, any(), theValue(UIControlEventTouchUpInside)];

        [_sut viewDidLoad];
      });
      it(@"When the max volume button is tapped it should set the audio volume and slider to 1", ^{
        [[_sut.audioPlayerMC should] receive:@selector(setAudioVolume:) withArguments:theValue(1)];
        [[[_sut.genericView slider] should] receive:@selector(setValue:animated:) withArguments:theValue(1), any()];

        objc_msgSend(_sut, @selector(maxButtonWasTapped:), nil);
      });
      it(@"Should respond to audio loaded notifications", ^{
        [[_sut.notificationCenter should] receive:@selector(addObserver:selector:name:object:) withArguments:_sut, any(), AudioPlayerDidLoadAudioNotification, any()];

        [_sut viewDidLoad];
      });
      it(@"When audio loads, the volume slider should equal the audio player's volume", ^{
        [_sut.audioPlayerMC stub:@selector(audioVolume) andReturn:theValue(0.5)];

        [[[_sut.genericView slider] should] receive:@selector(setValue:animated:) withArguments:theValue(0.5), any()];

        objc_msgSend(_sut, @selector(audioPlayerDidLoadAudio:), nil);
      });
      it(@"Should respond to audio volume change notifications", ^{
        [[_sut.notificationCenter should] receive:@selector(addObserver:selector:name:object:) withArguments:_sut, any(), AudioPlayerVolumeDidChangeNotification, any()];

        [_sut viewDidLoad];
      });
      it(@"When a volume change notification is posted, the volume slider should be set to the audio player's volume", ^{
        [_sut.audioPlayerMC stub:@selector(audioVolume) andReturn:theValue(0.25)];

        [[[_sut.genericView slider] should] receive:@selector(setValue:animated:) withArguments:theValue(0.25), any()];

        objc_msgSend(_sut, @selector(audioPlayerDidChangeVolume:), nil);
      });
    });
    SPEC_END