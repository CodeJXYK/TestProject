//
//  BaseNC.h
//  项目工具文件
//
//  Created by 凯哥 on 2017/11/13.
//  Copyright © 2017年 凯哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseNC : UINavigationController

/**透明度*/
@property (nonatomic , assign) CGFloat alpha;
/**背景色*/
@property (nonatomic , strong) UIColor *backgroundColor;
/**标题属性*/
@property (nonatomic , strong) NSDictionary *titleTextAttributes;
/**用于标识唯一性*/
@property (nonatomic , strong) NSString *identifier;

@end
