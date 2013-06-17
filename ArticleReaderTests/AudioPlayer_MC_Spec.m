#import <AVFoundation/AVFoundation.h>
#import <objc/message.h>
#import "Kiwi.h"
#import "JA_AudioPlayer_MC.h"
#import "NotificationNames.h"

SPEC_BEGIN(JA_AudioPlayer_MC_Spec)
    __block JA_AudioPlayer_MC *_sut;

    beforeEach(^{
      _sut = [[JA_AudioPlayer_MC alloc] init];
      _sut.audioPlayerM = [AVAudioPlayer nullMock];
      _sut.notificationCenter = [NSNotificationCenter nullMock];
    });

    describe(@"JA_AudioPlayer_MC", ^{
      it(@"When setting the audio volume, given the volume is over 1, the volume should be set to 1", ^{
        [[_sut.audioPlayerM should] receive:@selector(setVolume:) withArguments:theValue(1)];

        _sut.audioVolume = 2;

        [[theValue(_sut.audioVolume) should] equal:theValue(1)];
      });
      it(@"When setting the audio volume, given the volume is under 0, the volume should be set to 0", ^{
        [[_sut.audioPlayerM should] receive:@selector(setVolume:) withArguments:theValue(0)];

        _sut.audioVolume = -1;

        [[theValue(_sut.audioVolume) should] equal:theValue(0)];
      });
      it(@"When setting the audio volume, given the volume is between 0 and 1, the volume should be set to the argument", ^{
        [[_sut.audioPlayerM should] receive:@selector(setVolume:) withArguments:theValue(0.75)];

        _sut.audioVolume = 0.75;

        [[theValue(_sut.audioVolume) should] equal:theValue(0.75)];
      });
      it(@"When setting the audio volume, a volume change notification should be posted", ^{
        [[_sut.notificationCenter should] receive:@selector(postNotificationName:object:) withArguments:AudioPlayerVolumeDidChangeNotification, _sut];

        _sut.audioVolume = 0.4;
      });
      it(@"When loading audio, the audio player should have its delegate set and notifications posted", ^{
        id audioPlayerMMock = [AVAudioPlayer nullMock];
        [_sut stub:@selector(makeAudioPlayerMWithURL:) andReturn:audioPlayerMMock];

        [[audioPlayerMMock should] receive:@selector(setDelegate:) withArguments:_sut];
        [[_sut.notificationCenter should] receive:@selector(postNotificationName:object:) withArguments:AudioPlayerDidLoadAudioNotification, _sut];

        [_sut loadAudioWithContentsOfURL:[NSURL URLWithString:nil]];
      });
      it(@"When the audio player will start playing, a notification should be posted and the polling timer should be started", ^{
        [[_sut.notificationCenter should] receive:@selector(postNotificationName:object:) withArguments:AudioPlayerWillStartPlayingNotification, any()];
        [[_sut.audioPlayerM should] receive:@selector(play)];

        [_sut startAudio];

        [_sut.playbackPollingTimer shouldNotBeNil];
      });
      it(@"When stopping the audio player, notifications should be posted and the polling timer should be stopped", ^{
        [_sut stub:@selector(playbackPollingTimer) andReturn:[NSTimer nullMock]];

        [[_sut.notificationCenter should] receive:@selector(postNotificationName:object:) withArguments:AudioPlayerWillStopPlayingNotification, any()];
        [[_sut.audioPlayerM should] receive:@selector(stop)];
        [[_sut.playbackPollingTimer should] receive:@selector(invalidate)];

        [_sut stopAudio];
      });
      it(@"Should return the current audio time", ^{
        [_sut.audioPlayerM stub:@selector(currentTime) andReturn:theValue(5)];

        [[theValue(_sut.audioTime) should] equal:theValue(5)];
      });
      it(@"When setting the audio's current time, given the argument is within the duration, current time should be set to the argument, and post a notification", ^{
        [_sut stub:@selector(audioDuration) andReturn:theValue(10)];

        [[_sut.audioPlayerM should] receive:@selector(setCurrentTime:) withArguments:theValue(8)];
        [[_sut.notificationCenter should] receive:@selector(postNotificationName:object:) withArguments:AudioPlayerPlaybackPositionWasChangedNotification, _sut];

        _sut.audioTime = 8;
      });
      it(@"When setting the audio's current time, given the argument is past the duration, the audio should stop, jump to the beginning, and post a notification", ^{
        [_sut stub:@selector(audioDuration) andReturn:theValue(10)];

        [[_sut should] receive:@selector(stopAudio)];
        [[_sut.audioPlayerM should] receive:@selector(setCurrentTime:) withArguments:theValue(0)];

        _sut.audioTime = 11;
      });
      it(@"When setting the audio's current time, given the argument is under 0, the audio should jump to the the beginning and post a notification", ^{
        [[_sut.audioPlayerM should] receive:@selector(setCurrentTime:) withArguments:theValue(0)];
        [[_sut.notificationCenter should] receive:@selector(postNotificationName:object:) withArguments:AudioPlayerPlaybackPositionWasChangedNotification, _sut];

        _sut.audioTime = -1;
      });
      it(@"Should jump audio ahead and post notifications", ^{
        [_sut stub:@selector(jumpSeconds) andReturn:theValue(5)];
        [_sut stub:@selector(audioTime) andReturn:theValue(3)];

        [[_sut.notificationCenter should] receive:@selector(postNotificationName:object:) withArguments:AudioPlayerPlaybackPositionWasChangedNotification, any()];
        [[_sut should] receive:@selector(setAudioTime:) withArguments:theValue(8)];

        [_sut jumpAudioForward];
      });
      it(@"Should jump audio back and post notifications", ^{
        [_sut stub:@selector(jumpSeconds) andReturn:theValue(5)];
        [_sut stub:@selector(audioTime) andReturn:theValue(8)];

        [[_sut.notificationCenter should] receive:@selector(postNotificationName:object:) withArguments:AudioPlayerPlaybackPositionWasChangedNotification, any()];
        [[_sut should] receive:@selector(setAudioTime:) withArguments:theValue(3)];

        [_sut jumpAudioBack];
      });
      it(@"When audio has reached the end, it should post a notification and stop the polling timer", ^{
        [_sut stub:@selector(playbackPollingTimer) andReturn:[NSTimer nullMock]];

        [[_sut.notificationCenter should] receive:@selector(postNotificationName:object:) withArguments:AudioPlayerPlaybackPositionWasChangedNotification, any()];
        [[_sut.notificationCenter should] receive:@selector(postNotificationName:object:) withArguments:AudioPlayerWillStopPlayingNotification, any()];
        [[_sut.audioPlayerM should] receive:@selector(stop)];
        [[_sut.playbackPollingTimer should] receive:@selector(invalidate)];

        [_sut audioPlayerDidFinishPlaying:nil successfully:YES];
      });
      it(@"Should return the audio duration", ^{
        [[_sut valueForKey:@"_audioPlayerM"] stub:@selector(duration) andReturn:theValue(5)];

        [[theValue(_sut.audioDuration)should] equal:theValue(5)];
      });
      it(@"When playback polling timer is fired, it should post a notification", ^{
        [[_sut.notificationCenter should] receive:@selector(postNotificationName:object:) withArguments:AudioPlayerPlaybackPositionWasChangedNotification, any()];

        objc_msgSend(_sut, @selector(playbackPollingTimerWasFired:), nil);
      });
      it(@"Should return the audio's playing status", ^{
        [_sut.audioPlayerM stub:@selector(isPlaying) andReturn:theValue(YES)];
        [[theValue([_sut isAudioPlaying]) should] equal:theValue(YES)];

        [_sut.audioPlayerM stub:@selector(isPlaying) andReturn:theValue(NO)];
        [[theValue([_sut isAudioPlaying]) should] equal:theValue(NO)];
      });
      it(@"When scrubbing, and the audio is not playing, it should set the audio to the new position", ^{
        [_sut stub:@selector(isAudioPlaying) andReturn:theValue(NO)];

        [[_sut should] receive:@selector(setAudioTime:) withArguments:theValue(5)];

        [_sut scrubToTime:5];
      });
      it(@"When scrubbing, and the audio is playing, it should set the audio to the new position and continue playing", ^{
        [_sut stub:@selector(isAudioPlaying) andReturn:theValue(YES)];

        [[_sut should] receive:@selector(setAudioTime:) withArguments:theValue(5)];
        [[_sut.audioPlayerM should] receive:@selector(play)];

        [_sut scrubToTime:5];
      });
    });
    SPEC_END