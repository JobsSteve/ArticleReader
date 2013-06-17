#import "JA_VC.h"

@class JA_ScrubControls_VC;
@class JA_TextContent_VC;
@class JA_PlaybackControls_VC;
@class JA_VolumeControls_VC;

@interface JA_Playback_VC : JA_VC
@property (nonatomic, strong) JA_ScrubControls_VC *scrubControlsVC;
@property (nonatomic, strong) JA_TextContent_VC *textContentVC;
@property (nonatomic, strong) JA_PlaybackControls_VC *playbackControlsVC;
@property (nonatomic, strong) JA_VolumeControls_VC *volumeControlsVC;
@end