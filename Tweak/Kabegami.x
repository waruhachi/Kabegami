#import <Kabegami.h>

void SaveWallpaper() {
	SBWallpaperController *wallpaperController = [%c(SBWallpaperController) sharedInstance];
	PBUIPosterWallpaperRemoteViewController *wallpaperRemoteController = [wallpaperController safeValueForKey:@"_rootWallpaperViewController"];
	PBUIPosterWallpaperViewController *wallpaperViewController = [wallpaperRemoteController safeValueForKey:@"_viewController"];
	UIView *wallpaperView = wallpaperViewController.view;

	if (!wallpaperView) {
		dispatch_async(dispatch_get_main_queue(), ^{
			CustomToast *toast = [[CustomToast alloc] initWithTitle:@"Unable to Save Wallpaper" subtitle:@"Kabegami" icon:[UIImage systemImageNamed:@"exclamationmark.triangle"] iconColor:[UIColor redColor] autoHide:3.0];
			[toast presentToast];
		});
		return;
	}

	UIGraphicsBeginImageContextWithOptions(wallpaperView.frame.size, NO, [UIScreen mainScreen].scale);
	[wallpaperView.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *wallpaperImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();

	if (!wallpaperImage) {
		dispatch_async(dispatch_get_main_queue(), ^{
			CustomToast *toast = [[CustomToast alloc] initWithTitle:@"Unable to Save Wallpaper" subtitle:@"Kabegami" icon:[UIImage systemImageNamed:@"exclamationmark.triangle"] iconColor:[UIColor redColor] autoHide:3.0];
			[toast presentToast];
		});
		return;
	}

	AudioServicesPlaySystemSound(hapticSoundID);
	UIImageWriteToSavedPhotosAlbum(wallpaperImage, nil, nil, nil);

	dispatch_async(dispatch_get_main_queue(), ^{
		CustomToast *toast = [[CustomToast alloc] initWithTitle:@"Wallpaper Saved" subtitle:@"Kabegami" icon:[UIImage systemImageNamed:@"checkmark.circle"] iconColor:[UIColor greenColor] autoHide:3.0];
		[toast presentToast];
	});
}

%hook CSCoverSheetViewController

- (void)viewDidLoad {
	%orig;

	if (self.view) {
		UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
		tapGestureRecognizer.numberOfTapsRequired = numberOfTapsRequired;
		[self.view addGestureRecognizer:tapGestureRecognizer];
	}
}

%new
- (void)handleTap:(UITapGestureRecognizer *)gesture {
	if (gesture.state == UIGestureRecognizerStateRecognized) {
		SaveWallpaper();
	}
}

%end

%hook SBHomeScreenViewController

- (void)viewDidLoad {
	%orig;

	if (self.view) {
		UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
		tapGestureRecognizer.numberOfTapsRequired = numberOfTapsRequired;
		[self.view addGestureRecognizer:tapGestureRecognizer];
	}
}

%new
- (void)handleTap:(UITapGestureRecognizer *)gesture {
	if (gesture.state == UIGestureRecognizerStateRecognized) {
		SaveWallpaper();
	}
}

%end