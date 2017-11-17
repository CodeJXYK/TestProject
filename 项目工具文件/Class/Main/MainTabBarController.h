//
//  MainTabBarController.h
//  项目工具文件
//
//  Created by 凯哥 on 2017/11/13.
//  Copyright © 2017年 凯哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTabBarController : UITabBarController

/**当前控制器*/
@property (nonatomic , strong , readonly) UIViewController *currVC;

/**单例*/
+ (instancetype)shareInstance;

@end
