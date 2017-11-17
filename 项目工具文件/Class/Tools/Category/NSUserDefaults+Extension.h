//
//  NSUserDefaults+Extension.h
//  项目工具文件
//
//  Created by 凯哥 on 2017/11/13.
//  Copyright © 2017年 凯哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (Extension)

/**
 存入自定义对象
 @param object 需要存入的自定义对象
 @param key 自定义对象对应的key
 */
+ (void)writeWithObject:(id)object
                 forKey:(NSString *)key;

/**
 获取自定义对象
 @param key 自定义对象对应的key
 @return 返回自定义对象
 */
+ (id)readObjectWithKey:(NSString *)key;

/**
 删除自定义对象
 @param key 自定义对象对应的key
 */
+ (void)removeObjectForKey:(NSString *)key;

@end
