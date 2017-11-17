//
//  NSUserDefaults+Extension.m
//  项目工具文件
//
//  Created by 凯哥 on 2017/11/13.
//  Copyright © 2017年 凯哥. All rights reserved.
//

#import "NSUserDefaults+Extension.h"

@implementation NSUserDefaults (Extension)

+ (void)writeWithObject:(id)object
                 forKey:(NSString *)key{
    //    id obj = [self readObjectWithKey:key];
    //    if(obj)
    [self removeObjectForKey:key];
    
    NSUserDefaults *userDefault = [self standardUserDefaults];
    
    //transform data
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
    [userDefault setObject:data
                    forKey:key];
    [userDefault synchronize];
}

+ (id)readObjectWithKey:(NSString *)key{
    NSUserDefaults *userDefault = [self standardUserDefaults];
    id obj = [userDefault objectForKey:key];
    //transform object
    if (obj) {
        return [NSKeyedUnarchiver unarchiveObjectWithData:obj];
    } else {
        return nil;
    }
}

+ (void)removeObjectForKey:(NSString *)key{
    NSUserDefaults *userDefault = [self standardUserDefaults];
    [userDefault removeObjectForKey:key];
    [userDefault synchronize];
}

@end
