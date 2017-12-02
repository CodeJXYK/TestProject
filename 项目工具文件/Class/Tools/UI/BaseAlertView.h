//
//  BaseAlertView.h
//  项目工具文件
//
//  Created by 凯哥 on 2017/11/21.
//  Copyright © 2017年 凯哥. All rights reserved.
//

#import <UIKit/UIKit.h>

/**消失回调*/
typedef void(^BaseAlertDismissBlock)(void);

/**警告框基础类（实现一些基础的动画与事件，用于继承）*/
@interface BaseAlertView : UIView

@property (nonatomic , assign) BOOL allowTapDismiss;

/**是否允许点击旁白消失（默认YES）*/
@property (nonatomic , assign) BOOL shouldTapToDissmiss;
/**浮板视图*/
@property (nonatomic , strong) UIView *panel;

/**显示方法*/
- (void)showWithPanelView:(UIView *)panel;

/**消失方法*/
- (void)dismiss;
- (void)dismissWithBlock:(BaseAlertDismissBlock)block;


@end

