//
//  YKSafeSwizzle.h
//  项目工具文件
//
//  Created by 凯哥 on 2017/11/13.
//  Copyright © 2017年 凯哥. All rights reserved.
//

#import <Foundation/Foundation.h>

/*集合数据安全处理防止崩溃*/

@interface NSArray (Swizzle) @end

@interface NSMutableArray (Swizzle) @end

@interface NSMutableDictionary (Swizzle) @end
