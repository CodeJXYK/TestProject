//
//  HttpClient.m
//  项目工具文件
//
//  Created by 凯哥 on 2017/11/16.
//  Copyright © 2017年 凯哥. All rights reserved.
//

#import "HttpClient.h"
#import "HttpServiceManager.h"

@implementation HttpClient
static BOOL _isOpenLog;

+(instancetype)shareInstance{
    
    static HttpClient *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _instance = [[self alloc] init];
        
    });
    return _instance;
}

+(void)openLog:(BOOL)open{
    
    if (open) {
        _isOpenLog = YES;
    }else{
        _isOpenLog = NO;
    }
}

+ (void)cancelRequestWithURL:(NSString *)URL{
    
}

+(NSURLSessionDataTask *)postRequestWithURLString:(NSString *)URLString
                                       parameters:(NSDictionary *)parameters
                                          success:(void (^)(NSURLSessionDataTask *dataTask,id responseObject))success
                                          failure:(void (^)(NSError *error))failure{
    
    !_isOpenLog ? : NSLog(@"URLString:%@,parameters:%@",URLString,parameters);
    
    NSURLSessionDataTask *task = [[HttpServiceManager manager] POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        !success ? : success(task,responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        !failure ? : failure(error);
        
    }];
    
   
    return task;
}

+(NSURLSessionDataTask *)getRequestWithURLString:(NSString *)URLString
                                      parameters:(NSDictionary *)parameters
                                         success:(void (^)(NSURLSessionDataTask *dataTask,id responseObject))success
                                         failure:(void (^)(NSError *error))failure{
    !_isOpenLog ? : NSLog(@"URLString:%@,parameters:%@",URLString,parameters);
    
    NSURLSessionDataTask *task = [[HttpServiceManager manager] GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        !success ? : success(task,responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        !failure ? : failure(error);
        
    }];
    
    return task;
}

+ (NSURLSessionTask *)uploadFileWithURL:(NSString *)URLString
                                      parameters:(id)parameters
                                            name:(NSString *)name
                                        filePath:(NSString *)filePath
                                        progress:(void (^)(NSProgress *progress))progress
                                         success:(void (^)(NSURLSessionDataTask *dataTask,id responseObject))success
                                         failure:(void (^)(NSError *error))failure{
    
    !_isOpenLog ? : NSLog(@"URL:%@,parameters:%@",URLString,parameters);
    
    NSURLSessionTask *task = [[HttpServiceManager manager] POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSError *error = nil;
        [formData appendPartWithFileURL:[NSURL URLWithString:filePath] name:name error:&error];
        (failure && error) ? failure(error) : nil;
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        dispatch_async(dispatch_get_main_queue(), ^{
            
            progress ? : progress(uploadProgress);
        });
    
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        !success ? : success(task,responseObject) ;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        !failure ? : failure(error);
    }];
    
    return task;
}

+ (NSURLSessionTask *)uploadImagesWithURL:(NSString *)URLString
                               parameters:(id)parameters
                                     name:(NSString *)name
                                   images:(NSArray<UIImage *> *)images
                                fileNames:(NSArray<NSString *> *)fileNames
                               imageScale:(CGFloat)imageScale
                                imageType:(NSString *)imageType
                                 progress:(void (^)(NSProgress *progress))progress
                                  success:(void (^)(NSURLSessionDataTask *dataTask,id responseObject))success
                                  failure:(void (^)(NSError *error))failure{
    !_isOpenLog ? : NSLog(@"URL:%@,parameters:%@",URLString,parameters);
    
    NSURLSessionTask *task = [[HttpServiceManager manager] POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (NSUInteger i = 0; i < images.count; i++) {
            // 图片经过等比压缩后得到的二进制文件
            NSData *imageData = UIImageJPEGRepresentation(images[i], imageScale ?: 1.f);
            
            // 默认图片的文件名, 若fileNames为nil就使用
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *imageFileName =[NSString stringWithFormat:@"%@%ld.%@",str,i,imageType?:@"jpg"];
            
            [formData appendPartWithFileData:imageData
                                        name:name
                                    fileName:fileNames ? [NSString stringWithFormat:@"%@.%@",fileNames[i],imageType?:@"jpg"] : imageFileName
                                    mimeType:[NSString stringWithFormat:@"image/%@",imageType ?: @"jpg"]];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        dispatch_async(dispatch_get_main_queue(), ^{
            progress ? progress(uploadProgress) : nil;
        });
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success ? success(task,responseObject) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure ? failure(error) : nil;
    }];
 
    return task;
}

+ (NSURLSessionTask *)downloadWithURL:(NSString *)URL
                              fileDir:(NSString *)filePath
                             progress:(void (^)(NSProgress *progress))progress
                              success:(void(^)(NSString *filePath))success
                              failure:(void (^)(NSError *error))failure{
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    
    __block NSURLSessionDownloadTask *downloadTask = [[HttpServiceManager manager] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //下载进度
        dispatch_async(dispatch_get_main_queue(), ^{
            progress ? progress(downloadProgress) : nil;
        });
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //拼接缓存目录
        NSString *downloadDir = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:filePath ? filePath : @"Download"];
        //打开文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //创建Download目录
        [fileManager createDirectoryAtPath:downloadDir withIntermediateDirectories:YES attributes:nil error:nil];
        //拼接文件路径
        NSString *filePath = [downloadDir stringByAppendingPathComponent:response.suggestedFilename];
        //返回文件位置的URL路径
        return [NSURL fileURLWithPath:filePath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        if(failure && error) {failure(error) ; return ;};
        success ? success(filePath.absoluteString /** NSURL->NSString*/) : nil;
        
    }];
    //开始下载
    [downloadTask resume];
    
    return downloadTask;
    
}

@end
