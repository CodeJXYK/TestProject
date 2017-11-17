//
//  UIColor+Extension.h
//  项目工具文件
//
//  Created by 凯哥 on 2017/11/13.
//  Copyright © 2017年 凯哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)

/**16进制，颜色转换*/
- (NSString *)hexString;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
+ (UIColor *)colorWithHexRGB:(int)hex;
+ (UIColor *)colorWithHexRGB:(int)hex alpha:(CGFloat)alpha;

@end
