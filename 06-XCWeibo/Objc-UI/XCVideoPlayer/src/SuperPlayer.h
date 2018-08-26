
#import "SuperPlayerView.h"
#import "SuperPlayerModel.h"
#import "SuperPlayerControlView.h"
#import "SuperPlayerControlViewDelegate.h"
#import "SuperPlayerGlobleConfig.h"
#import "SuperPlayerWindow.h"
#import <Masonry/Masonry.h>
#import "UIImageView+WebCache.h"    // SDWebImage
#import "AFNetworking.h"


// player的单例
#define SuperPlayerShared                   [SuperPlayerSharedView sharedInstance]
// 屏幕的宽
#define ScreenWidth                         [[UIScreen mainScreen] bounds].size.width
// 屏幕的高
#define ScreenHeight                        [[UIScreen mainScreen] bounds].size.height
// 颜色值RGB
#define RGBA(r,g,b,a)                       [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
// 图片路径
#define SuperPlayerImage(file)              [UIImage imageNamed:[@"SuperPlayer.bundle" stringByAppendingPathComponent:file]]

#define IsIPhoneX                           (ScreenHeight == 812 || ScreenWidth == 812)

// 配置的单例
#define SuperPlayerGlobleConfigShared       [SuperPlayerGlobleConfig sharedInstance]
// 小窗单例
#define SuperPlayerWindowShared             [SuperPlayerWindow sharedInstance]

#define TintColor RGBA(252, 89, 81, 1)
