//
//  BaseVC.h
//  项目工具文件
//
//  Created by 凯哥 on 2017/11/13.
//  Copyright © 2017年 凯哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseVC : UIViewController

/**返回按钮图片*/
@property (nonatomic , strong) UIImage *backBtnImg;
/**导航栏透明度，默认1*/
@property (nonatomic , assign) CGFloat navigationBarAlpha;
/**导航栏背景色*/
@property (nonatomic , strong) UIColor *navigationBarColor;
/**是否应该侧滑返回，默认YES*/
@property (nonatomic , assign) BOOL shouldSwipeToBack;
/**是否需要显示返回按钮，默认YES，需要在子类viewDidLoad之前调用*/
@property (nonatomic , assign) BOOL shouldShowBackBtn;

/**自定义导航栏左边按钮*/
@property (nonatomic , strong) NSArray *leftBarItems;
/**自定义导航栏右边按钮*/
@property (nonatomic , strong) NSArray *rightBarItems;

/**是否可见*/
@property (nonatomic , assign , readonly) BOOL isVisiable;

/**系统自带导航栏返回按钮事件*/
- (void)nativeComesBackButtonClicked;

/**自定义导航栏按钮事件,用于继承重载*/
- (void)leftBarItemsClicked:(UIButton *)button;
- (void)rightBarItemsClicked:(UIButton *)button;

@end
