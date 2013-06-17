#import <objc/message.h>
#import "Kiwi.h"
#import "JA_VC.h"
#import "JA_TextContent_VC.h"
#import "NotificationNames.h"
#import "JA_Article_MVO.h"
#import "JA_TextContent_V.h"
#import "JA_TextView.h"
#import "JA_AudioPlayer_MC.h"
#import "JA_Sentence_MVO.h"

SPEC_BEGIN(JA_TextContent_VC_Spec)
    __block JA_TextContent_VC *_sut;

    beforeEach(^{
      id mainViewMock = [JA_TextContent_V nullMock];
      [mainViewMock stub:@selector(textView) andReturn:[JA_TextView nullMock]];

      id articleMVOMock = [JA_Article_MVO nullMock];
      [articleMVOMock stub:@selector(compiledSentences) andReturn:@"Sentence."];

      _sut = [[JA_TextContent_VC alloc] init];
      _sut.view = mainViewMock;
      _sut.articleMVO = articleMVOMock;
      _sut.audioPlayerMC = [JA_AudioPlayer_MC nullMock];
      _sut.notificationCenter = [NSNotificationCenter nullMock];
    });

    describe(@"JA_TextContent_VC", ^{
      it(@"Tap gesture should not be nil", ^{
        [[[JA_TextContent_VC alloc] init].tapGesture shouldNotBeNil];
      });
      it(@"Text content view should respond to tap gestures", ^{
        [[[_sut.genericView textView] should] receive:@selector(addGestureRecognizer:) withArguments:_sut.tapGesture];

        [_sut viewDidLoad];
      });
      it(@"Should respond to audio loaded notifications", ^{
        [[_sut.notificationCenter should] receive:@selector(addObserver:selector:name:object:) withArguments:_sut, any(), AudioPlayerDidLoadAudioNotification, any()];

        [_sut viewDidLoad];
      });
      it(@"When the audio player did load audio, it should display the article's content and highlight the current sentence", ^{
        [[[_sut.genericView textView] should] receive:@selector(setAttributedText:)];
        [[_sut.genericView should] receive:@selector(highlightContent:)];

        objc_msgSend(_sut, @selector(audioPlayerDidLoadAudio:), nil);
      });
      it(@"When the text view is tapped, it should set the playback current time to the start of the sentence", ^{
        JA_Sentence_MVO *sentenceMock = [JA_Sentence_MVO nullMock];
        [sentenceMock stub:@selector(startSeconds) andReturn:theValue(5)];
        [_sut.articleMVO stub:@selector(sentenceForIndex:) andReturn:sentenceMock];

        [[_sut.audioPlayerMC should] receive:@selector(setAudioTime:) withArguments:theValue(5)];

        objc_msgSend(_sut, @selector(textViewWasTapped:), nil);
      });
      it(@"Should respond to playback position changes", ^{
        [[_sut.notificationCenter should] receive:@selector(addObserver:selector:name:object:) withArguments:_sut, any(), AudioPlayerPlaybackPositionWasChangedNotification, any()];

        [_sut viewDidLoad];
      });
      it(@"When playback position changed, it should highlight the corresponding sentence", ^{
        JA_Sentence_MVO *sentenceMock = [JA_Sentence_MVO nullMock];
        [sentenceMock stub:@selector(startIndex) andReturn:theValue(5)];
        [sentenceMock stub:@selector(sentenceLength) andReturn:theValue(5)];
        [sentenceMock stub:@selector(startSeconds) andReturn:theValue(10)];
        [_sut.articleMVO stub:@selector(sentenceForSeconds:) andReturn:sentenceMock];

        NSRange expectedRange = NSMakeRange(sentenceMock.startIndex, sentenceMock.sentenceLength);
        [[_sut.genericView  should] receive:@selector(highlightContent:) withArguments:theValue(expectedRange)];
        [[[_sut.genericView textView] should] receive:@selector(scrollRangeToVisible:) withArguments:theValue(expectedRange)];

        objc_msgSend(_sut, @selector(audioPlayerPlaybackPositionWasChanged:), nil);
      });
    });
    SPEC_END