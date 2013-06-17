#import <objc/message.h>
#import "Kiwi.h"
#import "JA_VC.h"
#import "JA_PlaybackControls_VC.h"
#import "JA_PlaybackControls_V.h"
#import "JA_AudioPlayer_MC.h"
#import "JA_GesturePlayback_VC.h"
#import "NotificationNames.h"

SPEC_BEGIN(JA_PlaybackControls_VC_Spec)\
    __block JA_PlaybackControls_VC *_sut;

    beforeEach(^{
      JA_PlaybackControls_V *playbackControlsVMock = [JA_PlaybackControls_V nullMock];
      [playbackControlsVMock stub:@selector(startButton) andReturn:[UIButton nullMock]];
      [playbackControlsVMock stub:@selector(pauseButton) andReturn:[UIButton nullMock]];
      [playbackControlsVMock stub:@selector(jumpBackButton) andReturn:[UIButton nullMock]];
      [playbackControlsVMock stub:@selector(jumpForwardButton) andReturn:[UIButton nullMock]];
      [playbackControlsVMock stub:@selector(gestureModeButton) andReturn:[UIButton nullMock]];

      _sut = [[JA_PlaybackControls_VC alloc] init];
      _sut.view = playbackControlsVMock;
      _sut.audioPlayerMC = [JA_AudioPlayer_MC nullMock];
      _sut.notificationCenter = [[NSNotificationCenter alloc] init];
    });

    describe(@"JA_PlaybackControls_VC", ^{
      it(@"Play button should respond to taps", ^{
        [[[_sut.genericView startButton] should] receive:@selector(addTarget:action:forControlEvents:) withArguments:_sut, any(), theValue(UIControlEventTouchUpInside)];

        [_sut viewDidLoad];
      });
      it(@"When the play button is tapped, it should start the audio player", ^{
        [[_sut.audioPlayerMC should] receive:@selector(startAudio)];

        objc_msgSend(_sut, @selector(startButtonWasTapped:), nil);
      });
      it(@"Stop button should respond to taps", ^{
        [[[_sut.genericView pauseButton] should] receive:@selector(addTarget:action:forControlEvents:) withArguments:_sut, any(), theValue(UIControlEventTouchUpInside)];

        [_sut viewDidLoad];
      });
      it(@"When the stop button is tapped, it should stop the audio player", ^{
        [[_sut.audioPlayerMC should] receive:@selector(stopAudio)];

        objc_msgSend(_sut, @selector(stopButtonWasTapped:), nil);
      });
      it(@"Jump back button should respond to taps", ^{
        [[[_sut.genericView jumpBackButton] should] receive:@selector(addTarget:action:forControlEvents:) withArguments:_sut, any(), theValue(UIControlEventTouchUpInside)];

        [_sut viewDidLoad];
      });
      it(@"When the jump back button is tapped, the audio should jump back", ^{
        [[_sut.audioPlayerMC should] receive:@selector(jumpAudioBack)];

        objc_msgSend(_sut, @selector(jumpBackButtonWasTapped:), nil);
      });
      it(@"Jump forward button should respond to taps", ^{
        [[[_sut.genericView jumpForwardButton] should] receive:@selector(addTarget:action:forControlEvents:) withArguments:_sut, any(), theValue(UIControlEventTouchUpInside)];

        [_sut viewDidLoad];
      });
      it(@"When the jump forward button is tapped, the audio should jump forward", ^{
        [[_sut.audioPlayerMC should] receive:@selector(jumpAudioForward)];

        objc_msgSend(_sut, @selector(jumpForwardButtonWasTapped:), nil);
      });
      it(@"Gesture mode button should respond to taps", ^{
        [[[_sut.genericView gestureModeButton] should] receive:@selector(addTarget:action:forControlEvents:) withArguments:_sut, any(), theValue(UIControlEventTouchUpInside)];

        [_sut viewDidLoad];
      });
      it(@"When the gesture mode button is tapped, the gesture playback screen should be presented", ^{
        id gesturePlaybackVCMock = [JA_GesturePlayback_VC nullMock];
        [_sut stub:@selector(makeGesturePlaybackVC) andReturn:gesturePlaybackVCMock];

        [[_sut should] receive:@selector(presentViewController:animated:completion:) withArguments:gesturePlaybackVCMock, any(), any()];

        objc_msgSend(_sut, @selector(gestureModeButtonWasTapped:), nil);
      });
      it(@"Should respond to audio will play notifications", ^{
        [[_sut.notificationCenter should] receive:@selector(addObserver:selector:name:object:) withArguments:_sut, any(), AudioPlayerWillStartPlayingNotification, any()];

        [_sut viewDidLoad];
      });
      it(@"When the audio player will start playing, the play button should be hidden and the stop button should be shown.", ^{
        [[[_sut.genericView startButton] should] receive:@selector(setHidden:) withArguments:theValue(YES)];
        [[[_sut.genericView pauseButton] should] receive:@selector(setHidden:) withArguments:theValue(NO)];

        objc_msgSend(_sut, @selector(audioPlayerWillStartPlaying:), nil);
      });
      it(@"Should respond to audio will stop notifications", ^{
        [[_sut.notificationCenter should] receive:@selector(addObserver:selector:name:object:) withArguments:_sut, any(), AudioPlayerWillStopPlayingNotification, any()];

        [_sut viewDidLoad];
      });
      it(@"When the audio player will stop playing, the play button should be shown and the stop button should be hidden.", ^{
        [[[_sut.genericView startButton] should] receive:@selector(setHidden:) withArguments:theValue(NO)];
        [[[_sut.genericView pauseButton] should] receive:@selector(setHidden:) withArguments:theValue(YES)];

        objc_msgSend(_sut, @selector(audioPlayerWillStopPlaying:), nil);
      });
    });
    SPEC_END