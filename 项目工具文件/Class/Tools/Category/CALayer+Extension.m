//
//  CALayer+Extension.m
//  项目工具文件
//
//  Created by 凯哥 on 2017/11/13.
//  Copyright © 2017年 凯哥. All rights reserved.
//

#import "CALayer+Extension.h"

@implementation CALayer (Extension)

- (void)removeAllSublayers{
    while (self.sublayers.count) {
        CALayer *child = self.sublayers.lastObject;
        [child removeFromSuperlayer];
    }
}

@end
