@class JA_AudioPlayer_MC;
@class JA_Article_MVO;

@interface JA_VC : UIViewController
@property (nonatomic, strong, readonly) id genericView;
@property (nonatomic, strong) JA_AudioPlayer_MC *audioPlayerMC;
@property (nonatomic, strong) JA_Article_MVO *articleMVO;
@property (nonatomic, strong) NSNotificationCenter *notificationCenter;
@end