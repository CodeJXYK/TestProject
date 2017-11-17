//
//  HomeVC.m
//  项目工具文件
//
//  Created by 凯哥 on 2017/11/13.
//  Copyright © 2017年 凯哥. All rights reserved.
//

#import "HomeVC.h"
#import "HomeViewController.h"
#import "HttpClient.h"
@interface HomeVC ()

@property(nonatomic,strong) NSURLSessionDataTask *task;

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBarAlpha = 0;
    
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setTitle:@"suspend" forState:UIControlStateNormal];
    button.frame = CGRectMake(100, 100, 100, 50);
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    
    button.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:button];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setTitle:@"resume" forState:UIControlStateNormal];
    button1.frame = CGRectMake(100, 200, 100, 50);
    [button1 addTarget:self action:@selector(buttonAction1) forControlEvents:UIControlEventTouchUpInside];
    
    button1.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:button1];
    // Do any additional setup after loading the view.
}

- (void)buttonAction{
    
    [self.task suspend];
    
}
- (void)buttonAction1{
    
    [self.task resume];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.navigationController pushViewController:[HomeViewController new] animated:YES];
    
    [HttpClient openLog:YES];
    
    [HttpClient getRequestWithURLString:@"http://120.25.226.186:32812/login?username=520it&pwd=520it" parameters:nil success:^(NSURLSessionDataTask *dataTask, id responseObject) {
        
        NSLog(@"responseObject:%@",responseObject);
    } failure:^(NSError *error) {
        
        NSLog(@"error:%@",error);
    }];
    
    
    
    NSDictionary *json = @{
                           @"username" : @"123",
                           @"pwd" : @"123"
                           };
    [HttpClient postRequestWithURLString:@"http://120.25.226.186:32812/login?username=520it&pwd=520it" parameters:json success:^(NSURLSessionDataTask *dataTask, id responseObject) {
        
        NSLog(@"responseObject:%@",responseObject);
        
    } failure:^(NSError *error) {
        
        NSLog(@"error:%@",error);
    }];
    
    
    NSURLSessionDataTask *task = [HttpClient downloadWithURL:@"http://wvideo.spriteapp.cn/video/2016/0328/56f8ec01d9bfe_wpd.mp4" fileDir:@"Download" progress:^(NSProgress *progress) {
        
        NSLog(@"progress:%.2f",(100.f * progress.completedUnitCount/progress.totalUnitCount));
        
    } success:^(NSString *filePath) {
        
        NSLog(@"dilePath:%@",filePath);
        
    } failure:^(NSError *error) {
        NSLog(@"error:%@",error);
        
    }];
    
    self.task = task;
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
