#import <objc/message.h>
#import "Kiwi.h"
#import "JA_GesturePlayback_VC.h"
#import "JA_AudioPlayer_MC.h"

SPEC_BEGIN(JA_GesturePlayback_VC_Spec)
    __block JA_GesturePlayback_VC *_sut;

    beforeEach(^{
      _sut = [[JA_GesturePlayback_VC alloc] init];
      _sut.audioPlayerMC = [JA_AudioPlayer_MC nullMock];
      _sut.tapGesture = [UITapGestureRecognizer nullMock];
      _sut.longPressGesture = [UILongPressGestureRecognizer nullMock];
      _sut.leftSwipeGesture = [UISwipeGestureRecognizer nullMock];
      _sut.rightSwipeGesture = [UISwipeGestureRecognizer nullMock];
      _sut.panGesture = [UIPanGestureRecognizer nullMock];
    });

    describe(@"JA_GesturePlayback_VC", ^{
      it(@"Tap gesture should exist", ^{
        [[[JA_GesturePlayback_VC alloc] init].tapGesture shouldNotBeNil];
      });
      it(@"Tap gesture should be attached to the main view", ^{
        [[_sut.view should] receive:@selector(addGestureRecognizer:) withArguments:_sut.tapGesture];

        [_sut viewDidLoad];
      });
      it(@"When the view is tapped, given the audio is not playing, the audio should stop", ^{
        [(id)_sut.audioPlayerMC stub:@selector(isAudioPlaying) andReturn:theValue(YES)];

        [[(id)_sut.audioPlayerMC should] receive:@selector(stopAudio)];

        objc_msgSend(_sut, @selector(viewWasTapped:), nil);
      });
      it(@"When the view is tapped, given the audio is not playing, the audio should stop", ^{
        [(id)_sut.audioPlayerMC stub:@selector(isAudioPlaying) andReturn:theValue(NO)];

        [[(id)_sut.audioPlayerMC should] receive:@selector(startAudio)];

        objc_msgSend(_sut, @selector(viewWasTapped:), nil);
      });
      it(@"Long press gesture should exist", ^{
        [[[JA_GesturePlayback_VC alloc] init].longPressGesture shouldNotBeNil];
      });
      it(@"Long press gesture should be attached to the main view", ^{
        [[_sut.view should] receive:@selector(addGestureRecognizer:) withArguments:_sut.longPressGesture];

        [_sut viewDidLoad];
      });
      it(@"When the view is long pressed, the screen should be dismissed", ^{
        [[_sut should] receive:@selector(dismissViewControllerAnimated:completion:)];
        objc_msgSend(_sut, @selector(viewWasLongPressed:), nil);
      });
      it(@"Left swipe gesture should exist", ^{
        [[[JA_GesturePlayback_VC alloc] init].leftSwipeGesture shouldNotBeNil];
      });
      it(@"Left swipe gesture should be attached to the main view", ^{
        [[_sut.view should] receive:@selector(addGestureRecognizer:) withArguments:_sut.leftSwipeGesture];

        [_sut viewDidLoad];
      });
      it(@"When the view is swiped left, the audio should jump back", ^{
        [[(id)_sut.audioPlayerMC should] receive:@selector(jumpAudioBack)];
        objc_msgSend(_sut, @selector(viewWasSwipedLeft:), nil);
      });
      it(@"Right swipe gesture should exist", ^{
        [[[JA_GesturePlayback_VC alloc] init].rightSwipeGesture shouldNotBeNil];
      });
      it(@"Right swipe gesture should be attached to the main view", ^{
        [[_sut.view should] receive:@selector(addGestureRecognizer:) withArguments:_sut.rightSwipeGesture];

        [_sut viewDidLoad];
      });
      it(@"When the view is swiped right, the audio should jump forward", ^{
        [[(id)_sut.audioPlayerMC should] receive:@selector(jumpAudioForward)];
        objc_msgSend(_sut, @selector(viewWasSwipedRight:), nil);
      });
      it(@"Pan gesture should exist", ^{
        [[[JA_GesturePlayback_VC alloc] init].panGesture shouldNotBeNil];
      });
      it(@"Pan gesture should be attached to the main view", ^{
        [[_sut.view should] receive:@selector(addGestureRecognizer:) withArguments:_sut.panGesture];

        [_sut viewDidLoad];
      });
      it(@"When the view is panned upwards, the audio's volume should be raised", ^{
        [_sut.audioPlayerMC stub:@selector(audioVolume) andReturn:theValue(0.5)];
        [_sut stub:@selector(volumePanIncrement) andReturn:theValue(0.1)];
        [_sut.panGesture stub:@selector(translationInView:) andReturn:theValue(CGPointMake(0, -5))];

        [[_sut.audioPlayerMC should] receive:@selector(setAudioVolume:) withArguments:theValue(0.6f)];

        objc_msgSend(_sut, @selector(viewWasPanned:), nil);
      });
      it(@"When the view is panned downwards, the audio's volume should be lowered", ^{
        [_sut.audioPlayerMC stub:@selector(audioVolume) andReturn:theValue(0.5)];
        [_sut stub:@selector(volumePanIncrement) andReturn:theValue(0.1)];
        [_sut.panGesture stub:@selector(translationInView:) andReturn:theValue(CGPointMake(0, 5))];

        [[_sut.audioPlayerMC should] receive:@selector(setAudioVolume:) withArguments:theValue(0.4f)];

        objc_msgSend(_sut, @selector(viewWasPanned:), nil);
      });
    });
    SPEC_END