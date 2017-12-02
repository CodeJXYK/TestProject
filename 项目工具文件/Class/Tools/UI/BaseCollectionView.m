//
//  BaseCollectionView.m
//  项目工具文件
//
//  Created by 凯哥 on 2017/11/21.
//  Copyright © 2017年 凯哥. All rights reserved.
//

#import "BaseCollectionView.h"

@implementation BaseCollectionView

- (instancetype) initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
#ifdef __IPHONE_11_0
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
#endif
    }
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    if(self = [super initWithFrame:frame collectionViewLayout:layout]){
#ifdef __IPHONE_11_0
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
#endif
    }
    return self;
}

@end
