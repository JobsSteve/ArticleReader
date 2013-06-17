#import "JA_AppDelegate.h"
#import "JA_Playback_VC.h"
#import "JA_AudioPlayer_MC.h"
#import "JA_ExampleArticle_Factory.h"

@implementation JA_AppDelegate
#pragma mark - Public Properties
- (UIWindow *)window
{
  if (!_window) {
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _window.backgroundColor = [UIColor whiteColor];
    _window.rootViewController = [self makeNavigationController];
  }
  return _window;
}

#pragma mark - Public Methods
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  [self configureAudioSession];
  [self styleNavigationBars];
  [self.window makeKeyAndVisible];
  return YES;
}

#pragma mark - Private Methods
- (void)configureAudioSession
{
  AVAudioSession *audioSession = [AVAudioSession sharedInstance];
  NSError *error;
  NSAssert([audioSession setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionMixWithOthers error:&error], @"Could not configure audio session, error: %@", error);
  NSAssert([audioSession setActive:YES error:&error], @"Could not set audio session active, error: %@", error);
}

- (void)styleNavigationBars
{
  [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
  [[UINavigationBar appearance] setTitleTextAttributes:@{
      UITextAttributeFont            : [UIFont fontWithName:@"AvenirNext-Bold" size:18],
      UITextAttributeTextColor       : [UIColor blackColor],
      UITextAttributeTextShadowColor : [UIColor clearColor]
  }];
}

- (UINavigationController *)makeNavigationController
{
  return [[UINavigationController alloc] initWithRootViewController:[self makePlaybackVC]];
}

- (JA_Playback_VC *)makePlaybackVC
{
  JA_Playback_VC *playbackVC = [[JA_Playback_VC alloc] init];
  playbackVC.notificationCenter = [[NSNotificationCenter alloc] init];
  playbackVC.audioPlayerMC = [self makeAudioPlayerMCWithNotificationCenter:playbackVC.notificationCenter];
  playbackVC.articleMVO = [JA_ExampleArticle_Factory exampleArticle];
  return playbackVC;
}

- (JA_AudioPlayer_MC *)makeAudioPlayerMCWithNotificationCenter:(NSNotificationCenter *)notificationCenter
{
  JA_AudioPlayer_MC *audioPlayerMC = [[JA_AudioPlayer_MC alloc] init];
  audioPlayerMC.notificationCenter = notificationCenter;
  return audioPlayerMC;
}
@end