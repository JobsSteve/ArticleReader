#import "JA_VC.h"

@interface JA_GesturePlayback_VC : JA_VC
@property (nonatomic, assign) float volumePanIncrement;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGesture;
@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeGesture;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGesture;
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@end