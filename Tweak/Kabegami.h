#include <UIKit/UIKit.h>
#include <CustomToast/CustomToast.h>
#include <AudioToolbox/AudioToolbox.h>

static const SystemSoundID hapticSoundID = 1521;
static const NSUInteger numberOfTapsRequired = 3;

@interface NSObject (Undocumented)
	- (id)safeValueForKey:(NSString *)key;
@end

@interface UITapGestureRecognizer (Additions)
	- (NSUInteger)numberOfTapsRequired;
@end

@interface CSCoverSheetViewController : UIViewController
@end

@interface SBWallpaperController : NSObject
	+ (id)sharedInstance;
@end

@interface PBUIPosterWallpaperRemoteViewController : UIViewController
@end

@interface PBUIPosterWallpaperViewController : UIViewController
@end

@interface SBHomeScreenViewController : UIViewController
@end