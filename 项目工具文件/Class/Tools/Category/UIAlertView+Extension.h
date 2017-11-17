//
//  UIAlertView+Extension.h
//  项目工具文件
//
//  Created by 凯哥 on 2017/11/13.
//  Copyright © 2017年 凯哥. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UIAlertViewActionBlock)(NSInteger index);

@interface UIAlertView (Extension)

- (UIAlertView *)initWithTitle:(NSString *)title
                       message:(NSString *)message
             cancelButtonTitle:(NSString *)cancelButtonTitle
             otherButtonTitles:(NSArray *)otherButtonTitles
                   clickAction:(UIAlertViewActionBlock)clickAction;
@end
