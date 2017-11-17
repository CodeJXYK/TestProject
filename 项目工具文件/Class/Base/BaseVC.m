//
//  BaseVC.m
//  项目工具文件
//
//  Created by 凯哥 on 2017/11/13.
//  Copyright © 2017年 凯哥. All rights reserved.
//

#import "BaseVC.h"
#import "BaseNC.h"
#import "Common.h"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"
@interface BaseVC ()

//处理侧滑返回临时变量
@property (nonatomic , strong) BaseVC *backLastVC;
@property (nonatomic , strong) BaseNC *backNC;
@property (nonatomic , assign) CGFloat backLastVCAlpha;
@property (nonatomic , assign) CGFloat backSelfVCAlpha;

@end

@implementation BaseVC

- (void)dealloc{
    
}

- (instancetype)init{
    if(self = [super init]){
        _navigationBarAlpha = 1;
        self.hidesBottomBarWhenPushed = YES;
        _shouldSwipeToBack = YES;
        _shouldShowBackBtn = YES;
    }
    return self;
}

#pragma mark - override
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    if(_backBtnImg){
        [self overrideBackBtn];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self setNavigationBarAlpha:_navigationBarAlpha];
    if(_navigationBarAlpha <= 0 && !self.navigationController.navigationBarHidden){
        [self.navigationController setNavigationBarHidden:YES animated:NO];
    }
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    NSArray *vcs = self.navigationController.viewControllers;
    if(vcs.count){
        BOOL isBack = NO; //判断是前进还是后退
        if(![vcs containsObject:self]){
            isBack = YES;
        }
        UIViewController *nextVC = vcs.lastObject;
        if([nextVC isKindOfClass:[BaseVC class]]){
            BaseVC *vc =(BaseVC *)nextVC;
            if(_navigationBarAlpha == 0 && self.navigationController.isNavigationBarHidden && vc.navigationBarAlpha > 0){
                [self.navigationController setNavigationBarHidden:NO animated:NO];
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    if ([self.view window] == nil){
        // Add code to preserve data stored in the views that might be
        // needed later.
        
        // Add code to clean up other strong references to the view in
        // the view hierarchy.
        self.view = nil;// 目的是再次进入时能够重新加载调用viewDidLoad函数。
    }
    Log(@"控制器收到内存警告：%@",NSStringFromClass([self class]));
}

#pragma mark - setter
- (void)setLeftBarItems:(NSArray *)leftBarItems{
    _leftBarItems = leftBarItems;
    
    for (NSObject *obj in leftBarItems) {
        if (![obj isKindOfClass:[NSString class]]
            && ![obj isKindOfClass:[UIImage class]]
            && ![obj isKindOfClass:[UIButton class]]) {
            _leftBarItems = nil;
            return;
        }
    }
    
    self.navigationItem.leftBarButtonItems = [self addBarItems:leftBarItems
                                                isLeftBarItems:YES];
}

- (void)setRightBarItems:(NSArray *)rightBarItems{
    _rightBarItems = rightBarItems;
    
    for (NSObject *obj in rightBarItems) {
        if (![obj isKindOfClass:[NSString class]]
            && ![obj isKindOfClass:[UIImage class]]
            && ![obj isKindOfClass:[UIButton class]]) {
            _rightBarItems = nil;
            return;
        }
    }
    
    self.navigationItem.rightBarButtonItems = [self addBarItems:rightBarItems
                                                 isLeftBarItems:NO];
}

#pragma mark - 重写系统返回按钮
- (void)overrideBackBtn{
    [self.navigationItem setHidesBackButton:YES animated:NO];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    self.navigationItem.backBarButtonItem = backItem;
    backItem.title = @"";
    
    if (self.navigationController.viewControllers.count > 1 && _shouldShowBackBtn) {
        UIImage *leftBtnImg = _backBtnImg;
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.frame = CGRectMake(0, 0, leftBtnImg.size.width, leftBtnImg.size.height);
        [leftBtn setImage:leftBtnImg
                 forState:UIControlStateNormal];
        [leftBtn addTarget:self
                    action:@selector(nativeComesBackButtonClicked)
          forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
        UIBarButtonItem *leftSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                       target:nil
                                                                                       action:nil];
        leftSpaceItem.width = -6;
        
        self.navigationItem.leftBarButtonItems = @[leftSpaceItem,leftItem];
    }else{
        self.navigationItem.leftBarButtonItems = nil;
    }
}

- (void)nativeComesBackButtonClicked{
    if(self.navigationController.viewControllers.count > 1){
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - 设置导航栏透明度
- (void)setNavigationBarAlpha:(CGFloat)navigationBarAlpha{
    _navigationBarAlpha = navigationBarAlpha;
    if([self.navigationController isKindOfClass:[BaseNC class]]){
        BaseNC *nc = (BaseNC *)self.navigationController;
        nc.alpha = navigationBarAlpha;
    }
}

#pragma mark - 设置导航栏背景色
- (void)setNavigationBarColor:(UIColor *)navigationBarColor{
    _navigationBarColor = navigationBarColor;
    if(navigationBarColor){
        if([self.navigationController isKindOfClass:[BaseNC class]]){
            BaseNC *nc = (BaseNC *)self.navigationController;
            nc.backgroundColor = navigationBarColor;
        }
    }
}

#pragma mark - getter
- (BOOL)isVisiable{
    return (self.isViewLoaded && self.view.window);
}

#pragma mark - private methods
- (NSMutableArray *)addBarItems:(NSArray *)array
                 isLeftBarItems:(BOOL)isLeftBarItems{
    NSMutableArray *items = [NSMutableArray array];
    for (NSObject *obj in array) {
        UIButton *button = nil;
        NSUInteger index = [array indexOfObject:obj];
        
        if ([obj isKindOfClass:[NSString class]]) {
            button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            button.titleLabel.font = FONT(12);
            [button setTitle:(NSString *)obj
                    forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor]
                         forState:UIControlStateNormal];
            [button setTitleColor:HexRGB(0xc3cdd8)
                         forState:UIControlStateHighlighted];
            [button sizeToFit];
        }else if ([obj isKindOfClass:[UIImage class]]) {
            UIImage *image = (UIImage *)obj;
            button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.size = CGSizeMake(image.size.width, image.size.height);
            [button setImage:image
                    forState:UIControlStateNormal];
        }else if ([obj isKindOfClass:[UIButton class]]) {
            button = (UIButton *)obj;
        }
        button.tag = index + 100;
        if (isLeftBarItems) {
            [button addTarget:self
                       action:@selector(leftBarItemsClicked:)
             forControlEvents:UIControlEventTouchUpInside];
        }else {
            [button addTarget:self
                       action:@selector(rightBarItemsClicked:)
             forControlEvents:UIControlEventTouchUpInside];
        }
        
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
        UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                   target:nil
                                                                                   action:nil];
        if(0 == index){
            spaceItem.width = -5;
        }else{
            spaceItem.width = 20;
        }
        
        [items addObject:spaceItem];
        [items addObject:item];
    }
    
    return items;
}

#pragma mark - 自定义按钮事件(用于继承重载)
- (void)leftBarItemsClicked:(UIButton *)button{}
- (void)rightBarItemsClicked:(UIButton *)button{}

@end
