//
//  BaseAlertView.m
//  项目工具文件
//
//  Created by 凯哥 on 2017/11/21.
//  Copyright © 2017年 凯哥. All rights reserved.
//

#import "BaseAlertView.h"
#import "UIView+Extension.h"
#import <POP.h>

@interface BaseAlertView ()<UIGestureRecognizerDelegate>

@property (nonatomic , copy) BaseAlertDismissBlock dismissBlock; //消失回调

@property (nonatomic , strong) UIView *back; //背景视图

@end
@implementation BaseAlertView

-(instancetype)init{
    
    self = [super initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    if (self) {
       
        [self configureUI];
        
    }
    return self;
}

- (void)configureUI{
    
    self.backgroundColor = [UIColor clearColor];
    
    _allowTapDismiss = YES;
    
    __weak typeof(self) weakSelf = self;
    
    _back = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    
    _back.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.4];
    _back.tag = 100;
    
    [_back tapped:^(UITapGestureRecognizer * _Nonnull gesture) {
        
        if (weakSelf.allowTapDismiss) {
            
            [weakSelf dismiss];
        }
        
    } delegate:self];
    
    [self addSubview:_back];
    
    _panel = [[UIView alloc] init];
    _panel.backgroundColor = [UIColor clearColor];
    
    [self addSubview:_panel];
    
}

#pragma mark - UIGestureRecognizer delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if (touch.view.tag == 100) {

        return YES;
    }
    
    return NO;
}

-(void)showWithPanelView:(UIView *)panel{
    
    if(!(panel.superview && [panel.superview isEqual:_panel])){
        _panel.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - panel.width) / 2,
                                  ([UIScreen mainScreen].bounds.size.height - panel.height) / 2,
                                  panel.width,
                                  panel.height);
        _panel.backgroundColor = [UIColor clearColor];
        [_panel addSubview:panel];
    }
    
    _back.alpha = 0;
    _panel.alpha = 0;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.3
                     animations:^{
                         _back.alpha = 1;
                         _panel.alpha = 1;
                     }];
    [self animateWithView:_panel isShow:YES];
    
}
#pragma mark - private
- (void)animateWithView:(UIView *)view isShow:(BOOL)is{
    
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    springAnimation.removedOnCompletion = YES;
    springAnimation.additive = NO;
    
    if (is) {
        
        springAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0.5, 0.5)];
        springAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1.0, 1.0)];
    }else{
        springAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(1.0, 1.0)];
        springAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(0.5, 0.5)];
    }
    
    springAnimation.springBounciness = 10;
    
    [view.layer pop_addAnimation:springAnimation forKey:@"MSODZoom"];
    
}

- (void)dismiss{
    
    [self dismissWithBlock:nil];
}
- (void)dismissWithBlock:(BaseAlertDismissBlock)block{
    
    _dismissBlock = block;
    [UIView animateWithDuration:0.3
                     animations:^{
                         _back.alpha = 0;
                         _panel.alpha = 0;
                     } completion:^(BOOL finished) {
                         [self removeFromSuperview];
                         !_dismissBlock ? : _dismissBlock();
                     }];
    [self animateWithView:_panel isShow:NO];
}



@end
