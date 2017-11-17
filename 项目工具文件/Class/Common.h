//
//  Common.h
//  项目工具文件
//
//  Created by 凯哥 on 2017/11/13.
//  Copyright © 2017年 凯哥. All rights reserved.
//

#ifndef Common_h
#define Common_h

#import "UIColor+Extension.h"

#define kSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define kSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
// debug日志输出
#ifdef DEBUG
#define Log(...) NSLog(__VA_ARGS__)
#else
#define Log(...)
#define NSLog(...)
#endif


//屏幕对象
#define SCREEN [UIApplication sharedApplication].keyWindow

//屏幕宽高
#define SCREEN_WIDTH    [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height

//iphone各机型判断
#define IS_IPHONE_3_5               CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] bounds].size)
#define IS_IPHONE_4_0               CGSizeEqualToSize(CGSizeMake(320, 568), [[UIScreen mainScreen] bounds].size)
#define IS_IPHONE_4_7               CGSizeEqualToSize(CGSizeMake(375, 667), [[UIScreen mainScreen] bounds].size)
#define IS_IPHONE_5_5               CGSizeEqualToSize(CGSizeMake(414, 736), [[UIScreen mainScreen] bounds].size)
#define IS_IPHONE_5_8               CGSizeEqualToSize(CGSizeMake(375, 812), [[UIScreen mainScreen] bounds].size)

//UI机型尺寸比例（以iphone6为基准）
#define UI_H_SCALE                  SCREEN_WIDTH/375
#define UI_V_SCALE                  SCREEN_HEIGHT/667

//分割线
#define LINE_HEIGHT                 1.f/SCREEN_SCALE
#define LINE_COLOR                  HexRGB(0xeeeeee)

//屏幕物理像素与现实像素比值
#define SCREEN_SCALE                [UIScreen mainScreen].scale

//判断是否是iphone设备
#define IS_PHONE [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone

//字体大小,宏名以iphone6P下的字号为准
#define FONT(x)             [UIFont systemFontOfSize:FONT_SIZE(x)]
#define BOLD_FONT(x)        [UIFont boldSystemFontOfSize:FONT_SIZE(x)]
#define FONT_SIZE(x)        (IS_IPHONE_5_8?x+2:(IS_IPHONE_5_5?x+1:(IS_IPHONE_4_7?x:x-1)))

#define TABBAR_HEIGHT           (IS_IPHONE_5_8?83:49)  //tabbar的默认高度
#define STATUSBAR_HEIGHT        (IS_IPHONE_5_8?44:20)  //状态栏高度
#define NAVIGATION_BAR_HEIGHT   (STATUSBAR_HEIGHT+44)  //navigation+statue默认高度

//生成颜色对象
#define HexRGB(rgbValue)            [UIColor colorWithHexRGB:rgbValue alpha:1.0]
#define HexRGBAlpha(rgbValue,a)     [UIColor colorWithHexRGB:rgbValue alpha:a]
#define RGB(r, g, b)                [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]
#define RGBAlpha(r, g, b, a)        [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]

//获取本地图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:file ofType:ext]]
//获取当前APP名字
#define APP_NAME [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
//获取当前APP版本号
#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//获取当前APPbuild号
#define APP_BUILD [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
//获取系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
//获取bundle id
#define APP_BUNDLEID [[NSBundle mainBundle] bundleIdentifier]



//常用颜色
#define VIEW_BGCOLOR                HexRGB(0xf3f6f6) //默认视图颜色
#define NAVIGATION_BAR_COLOR        HexRGB(0x282f38) //导航栏颜色
#define BTN_COLOR_RED_NORMAL        HexRGB(0xe22040) //按钮红色正常
#define BTN_COLOR_RED_HIGHLIGHTED   HexRGB(0xce1c3a) //按钮红色选中
#define BTN_COLOR_DISABLED          HexRGB(0xb3bcc6) //按钮不可点
#define WORD_COLOR_LEVEL_1          HexRGB(0xc3cdd8) //字体颜色1
#define WORD_COLOR_LEVEL_2          HexRGB(0x9ca9b7) //字体颜色2
#define WORD_COLOR_LEVEL_3          HexRGB(0x7f8a97) //字体颜色3
#define WORD_COLOR_LEVEL_4          HexRGB(0x3b4a5a) //字体颜色4
#define kControlH(_H_)    SCREEN_HEIGHT*_H_/667
#define kControlW(_W_)   SCREEN_WIDTH*_W_/375

#endif /* Common_h */
