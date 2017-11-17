//
//  UIView+Extension.h
//  项目工具文件
//
//  Created by 凯哥 on 2017/11/13.
//  Copyright © 2017年 凯哥. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UIView (Extension)

/**方位坐标*/
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize  size;

/**图层相关*/
@property (nonatomic , assign) CGFloat cornerRadius;    //圆角半径
@property (nonatomic , assign) CGFloat borderWidth;     //边框宽度
@property (nonatomic , assign) UIColor *borderColor;    //边框颜色


/**
 设置阴影
 @param color 阴影颜色
 @param opacity 阴影透明度
 @param radius 阴影半径
 @param offset 阴影位置偏移量
 */
- (void)layerShadow:(UIColor *)color
            opacity:(float)opacity
             radius:(CGFloat)radius
             offset:(CGSize)offset;

/**
 设置虚线边框
 @param borderColor 边框颜色
 @param radius 边框半径
 */
- (void)dashedBorder:(UIColor *)borderColor
              radius:(CGFloat)radius;

/**
 设置实线边框
 @param borderColor 边框颜色
 @param top left righthu bottom 各边边框的粗细
 */
- (void)solidBorder:(UIColor *)borderColor
                top:(CGFloat)top
               left:(CGFloat)left
              right:(CGFloat)righthu
             bottom:(CGFloat)bottom;

/**
 获取控制器
 @return view的师徒控制器
 */
- (nullable UIViewController *)viewController;

/**
 移除所有的子视图
 */
- (void)removeAllSubviews;

/**
 设置点击事件
 @param clicked 事件处理内容
 */
- (void)tapped:(nonnull void(^)(UITapGestureRecognizer *gesture))clicked
      delegate:(nullable id <UIGestureRecognizerDelegate>)delegate;

/**
 设置长按事件
 @param longPressed 事件处理内容
 */
- (void)longPressed:(nonnull void(^)(UILongPressGestureRecognizer *))longPressed
           delegate:(nullable id <UIGestureRecognizerDelegate>)delegate;

/**
 截屏工具
 */
- (UIImage *)screenShot;

/**
 快速截屏工具
 */
-(UIImage *)quickScreenShot;

@end
NS_ASSUME_NONNULL_END
