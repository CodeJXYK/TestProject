//
//  UIImage+Extension.h
//  项目工具文件
//
//  Created by 凯哥 on 2017/11/13.
//  Copyright © 2017年 凯哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/**生成纯色的图片对象*/
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**base64字符串转图片*/
+ (UIImage *)ImageWithBase64String:(NSString *)string;

/**
 压缩图片
 @param size 压缩后的尺寸
 @return 压缩后的图片对象
 */
- (UIImage *)scaleWithImageWithSize:(CGSize)size;

/**
 高斯模糊方法
 */
- (UIImage *)boxblurImageWithBlur:(CGFloat)blur exclusionPath:(UIBezierPath *)exclusionPath;

/**
 高斯模糊
 */
- (UIImage *)blurryImageWithBlurLevel:(CGFloat)blur;


/**
 将图像转换为黑白照片
 */
- (UIImage *)transformToBlackAndWhite;

/**
 将字符串生成二维码
 */
+ (UIImage *)createQRCodeImage:(NSString *)qrstring
                          size:(CGFloat)size;
/**
 保存图片到相册
 */
- (void)saveToAlbum;

@end
