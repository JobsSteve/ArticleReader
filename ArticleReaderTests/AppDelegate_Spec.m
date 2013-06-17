#import "Kiwi.h"
#import "JA_AppDelegate.h"
#import "JA_Playback_VC.h"

SPEC_BEGIN(JA_AppDelegate_Spec)
    __block JA_AppDelegate *_sut;

    beforeEach(^{
      _sut = [[JA_AppDelegate alloc] init];
    });

    describe(@"JA_AppDelegate", ^{
      it(@"The top view controller should be a member of the correct class", ^{
        [_sut application:nil didFinishLaunchingWithOptions:nil];

        UINavigationController *navigationController = (UINavigationController *)_sut.window.rootViewController;
        [[navigationController.topViewController should] beMemberOfClass:[JA_Playback_VC class]];
      });
    });
    SPEC_END