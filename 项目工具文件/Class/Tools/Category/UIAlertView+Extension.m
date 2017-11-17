//
//  UIAlertView+Extension.m
//  项目工具文件
//
//  Created by 凯哥 on 2017/11/13.
//  Copyright © 2017年 凯哥. All rights reserved.
//

#import "UIAlertView+Extension.h"
#import <objc/runtime.h>

const static void *kUIAlertViewActionStorageKey = "kUIAlertViewActionStorageKey";

@implementation UIAlertView (Extension)

- (UIAlertView *)initWithTitle:(NSString *)title
                       message:(NSString *)message
             cancelButtonTitle:(NSString *)cancelButtonTitle
             otherButtonTitles:(NSArray *)otherButtonTitles
                   clickAction:(UIAlertViewActionBlock)clickAction{
    self = [self initWithTitle:title
                       message:message
                      delegate:self
             cancelButtonTitle:cancelButtonTitle
             otherButtonTitles:nil];
    for(NSString *title in otherButtonTitles){
        [self addButtonWithTitle:title];
    }
    if(clickAction){
        objc_setAssociatedObject(self, kUIAlertViewActionStorageKey, clickAction, OBJC_ASSOCIATION_COPY);
    }
    return self;
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    UIAlertViewActionBlock clickAction = objc_getAssociatedObject(alertView, kUIAlertViewActionStorageKey);
    !clickAction ? : clickAction(buttonIndex);
}

@end
