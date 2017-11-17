//
//  MainTabBarController.m
//  项目工具文件
//
//  Created by 凯哥 on 2017/11/13.
//  Copyright © 2017年 凯哥. All rights reserved.
//

#import "MainTabBarController.h"
#import "BaseNC.h"
#import "BaseVC.h"
#import "HomeVC.h"
#import "MineVC.h"
#import "Common.h"
#import "UIImage+Extension.h"

@interface MainTabBarController ()<UITabBarControllerDelegate>

@property(nonatomic,strong) BaseNC *homeNC;
@property(nonatomic,strong) BaseNC *mineNC;


@property(nonatomic,strong) HomeVC *homeVC;
@property(nonatomic,strong) MineVC *mineVC;

@end

@implementation MainTabBarController

+ (instancetype)shareInstance{
    static MainTabBarController *_instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _instance = [[MainTabBarController alloc] init];
    });
    
    return _instance;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureTabBar];
    
    [self confignureItem];
    
}

-(void)configureTabBar{
    
    self.delegate = self;
    
    //设置TabBar背景图片
    UIImage *tabBarBgImg = [UIImage imageWithColor:[UIColor whiteColor]];
    [[UITabBar appearance] setBackgroundImage:[tabBarBgImg resizableImageWithCapInsets:UIEdgeInsetsMake(tabBarBgImg.size.width/2, tabBarBgImg.size.height/2, tabBarBgImg.size.height/2, tabBarBgImg.size.width/2)]];
    [[UITabBar appearance] setShadowImage:[UIImage imageWithColor:HexRGB(0xeeeeee) size:CGSizeMake(1, LINE_HEIGHT)]];
    
    //self.tabBar.barTintColor = [UIColor blackColor];
    //设置TabBarItem相关属性
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:WORD_COLOR_LEVEL_1, NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:WORD_COLOR_LEVEL_3, NSForegroundColorAttributeName, nil]forState:UIControlStateSelected];
    
    
    
    
    
}

-(void)confignureItem{
    
    //首页
    _homeVC = [HomeVC new];
    _homeVC.hidesBottomBarWhenPushed = NO;
    
    UIImage *homeNormal = [[UIImage imageNamed:@"tab_home_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *homeSelected = [[UIImage imageNamed:@"tab_home_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    _homeNC = [[BaseNC alloc] initWithRootViewController:_homeVC];
    
    _homeNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:homeNormal selectedImage:homeSelected];
    _homeNC.backgroundColor = NAVIGATION_BAR_COLOR;

    //我的
    _mineVC = [MineVC new];
    _mineVC.hidesBottomBarWhenPushed = NO;
    
    UIImage *mineNormal = [[UIImage imageNamed:@"tab_mine_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *mineSelected = [[UIImage imageNamed:@"tab_mine_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    _mineNC = [[BaseNC alloc] initWithRootViewController:_mineVC];
    
    _mineNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:mineNormal selectedImage:mineSelected];
    _mineNC.backgroundColor = NAVIGATION_BAR_COLOR;

    self.viewControllers = @[_homeNC,_mineNC];
    self.selectedIndex = 0;
    
    
}

#pragma mark - UITabBarController delegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
