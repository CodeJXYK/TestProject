//
//  MineVC.m
//  项目工具文件
//
//  Created by 凯哥 on 2017/11/13.
//  Copyright © 2017年 凯哥. All rights reserved.
//

#import "MineVC.h"
#import "BaseAlertView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIImage+GIF.h>
#import <SDWebImage/UIImage+GIF.h>


@interface MineVC ()



@end

@implementation MineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBarAlpha = 1;
    
    self.view.backgroundColor = [UIColor grayColor];
    // Do any additional setup after loading the view.
    
     UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 150, 150)];
    
    NSString *path = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]] pathForResource:@"loading_gif" ofType:@"gif"];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    imgView.image = [UIImage sd_animatedGIFWithData:data];
    
    [self.view addSubview:imgView];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    BaseAlertView *alert = [BaseAlertView new];
    
    UIView *showView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];

    showView.backgroundColor = [UIColor redColor];
    
    [alert showWithPanelView:showView];
    
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
