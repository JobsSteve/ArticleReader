#import "Kiwi.h"
#import "JA_Playback_VC.h"
#import "JA_AudioPlayer_MC.h"
#import "JA_Article_MVO.h"
#import "JA_ScrubControls_VC.h"
#import "JA_VolumeControls_VC.h"
#import "JA_TextContent_VC.h"
#import "JA_PlaybackControls_VC.h"
#import "JA_ScrubControls_V.h"
#import "JA_TextContent_V.h"
#import "JA_VolumeControls_V.h"
#import "JA_PlaybackControls_V.h"

SPEC_BEGIN(JA_Playback_VC_Spec)
    __block JA_Playback_VC *_sut;

    beforeEach(^{
      _sut = [[JA_Playback_VC alloc] init];
      _sut.view = [UIView nullMock];
      _sut.scrubControlsVC = [[JA_ScrubControls_VC alloc] init];
      [_sut.scrubControlsVC stub:@selector(view) andReturn:[JA_ScrubControls_V nullMock]];

      _sut.textContentVC = [[JA_TextContent_VC alloc] init];
      [_sut.textContentVC stub:@selector(view) andReturn:[JA_TextContent_V nullMock]];

      _sut.volumeControlsVC = [[JA_VolumeControls_VC alloc] init];
      [_sut.volumeControlsVC stub:@selector(view) andReturn:[JA_VolumeControls_V nullMock]];

      _sut.playbackControlsVC = [[JA_PlaybackControls_VC alloc] init];
      [_sut.playbackControlsVC stub:@selector(view) andReturn:[JA_PlaybackControls_V nullMock]];

      _sut.audioPlayerMC = [JA_AudioPlayer_MC nullMock];
      _sut.articleMVO = [JA_Article_MVO nullMock];
      _sut.notificationCenter = [NSNotificationCenter nullMock];
    });

    describe(@"JA_Playback_VC", ^{
      it(@"Scrub controls view controller should be in child heiarchy", ^{
        [[_sut should] receive:@selector(addChildViewController:) withArguments:_sut.scrubControlsVC];

        [_sut viewDidLoad];
      });
      it(@"Text content view controller should be in child heiarchy", ^{
        [[_sut should] receive:@selector(addChildViewController:) withArguments:_sut.textContentVC];

        [_sut viewDidLoad];
      });
      it(@"Playback controls view controller should be in child heiarchy", ^{
        [[_sut should] receive:@selector(addChildViewController:) withArguments:_sut.playbackControlsVC];

        [_sut viewDidLoad];
      });
      it(@"Volume controls view controller should be in child heiarchy", ^{
        [[_sut should] receive:@selector(addChildViewController:) withArguments:_sut.volumeControlsVC];

        [_sut viewDidLoad];
      });
      it(@"Scrub controls view should be in view heiarchy", ^{
        [[_sut.view should] receive:@selector(addSubview:) withArguments:_sut.scrubControlsVC.view];

        [_sut viewDidLoad];
      });
      it(@"Text content view should be in view heiarchy", ^{
        [[_sut.view should] receive:@selector(addSubview:) withArguments:_sut.textContentVC.view];

        [_sut viewDidLoad];
      });
      it(@"Playback controls view should be in view heiarchy", ^{
        [[_sut.view should] receive:@selector(addSubview:) withArguments:_sut.playbackControlsVC.view];

        [_sut viewDidLoad];
      });
      it(@"Volume controls view should be in view heiarchy", ^{
        [[_sut.view should] receive:@selector(addSubview:) withArguments:_sut.volumeControlsVC.view];

        [_sut viewDidLoad];
      });
      it(@"When the view is loaded, it should load the audio", ^{
        [[_sut.audioPlayerMC should] receive:@selector(loadAudioWithContentsOfURL:)];

        [_sut viewDidLoad];
      });
    });
    SPEC_END