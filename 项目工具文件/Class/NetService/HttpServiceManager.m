//
//  HttpServiceManager.m
//  项目工具文件
//
//  Created by 凯哥 on 2017/11/16.
//  Copyright © 2017年 凯哥. All rights reserved.
//

#import "HttpServiceManager.h"

@implementation HttpServiceManager

+(instancetype)manager{
    
    static HttpServiceManager *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       
        _instance = [[self alloc] init];
        
    });
    
    return _instance;
}

-(instancetype)init{
    
    if (self = [super init]) {
      
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        self.responseSerializer =  [AFJSONResponseSerializer serializer];
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [self.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        self.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    }
    return self;
    
}


@end
