//
//  LoginVC.m
//  项目工具文件
//
//  Created by 凯哥 on 2017/11/20.
//  Copyright © 2017年 凯哥. All rights reserved.
//

#import "LoginVC.h"
#import "MainTabBarController.h"

@interface LoginVC ()

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setTitle:@"Login" forState:UIControlStateNormal];
    button.frame = CGRectMake(100, 100, 100, 50);
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    
    button.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:button];
    
}

- (void)buttonAction{
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
//    
//   
//    UIWindow *window =  [UIApplication sharedApplication].delegate.window;
//    window.rootViewController = [MainTabBarController shareInstance];
    
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
