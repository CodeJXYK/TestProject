//
//  BaseTextField.h
//  项目工具文件
//
//  Created by 凯哥 on 2017/11/21.
//  Copyright © 2017年 凯哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTextField : UITextField

/**字数限制*/
@property (nonatomic , assign) NSUInteger wordLimitNum;
/**提示文字颜色*/
@property (nonatomic , strong) UIColor *placeholderColor;

@end
