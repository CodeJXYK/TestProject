//
//  HttpClient.h
//  项目工具文件
//
//  Created by 凯哥 on 2017/11/16.
//  Copyright © 2017年 凯哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HttpClient : NSObject

//单例
+(instancetype)shareInstance;

//打印请求接口
+(void)openLog:(BOOL)open;

// 取消指定URL的HTTP请求
+ (void)cancelRequestWithURL:(NSString *)URL;


/**
 *  POST请求
 *
 *  @param URLString   接口
 *  @param parameters   参数
 *  @param success 请求成功回调
 *  @param failure 请求失败回调
 *
 *  @return NSURLSessionDataTask任务对象
 */

+(NSURLSessionDataTask *)postRequestWithURLString:(NSString *)URLString
                     parameters:(NSDictionary *)parameters
                        success:(void (^)(NSURLSessionDataTask *dataTask,id responseObject))success
                        failure:(void (^)(NSError *error))failure;

/**
 *  GET请求
 *
 *  @param URLString   接口
 *  @param parameters   参数
 *  @param success 请求成功回调
 *  @param failure 请求失败回调
 *
 *  @return NSURLSessionDataTask任务对象
 */
+(NSURLSessionDataTask *)getRequestWithURLString:(NSString *)URLString
                                       parameters:(NSDictionary *)parameters
                                          success:(void (^)(NSURLSessionDataTask *dataTask,id responseObject))success
                                          failure:(void (^)(NSError *error))failure;



/**
 *  上传文件
 *
 *  @param URLString  请求地址
 *  @param parameters 请求参数
 *  @param name       文件对应服务器上的字段
 *  @param filePath   文件本地的沙盒路径
 *  @param progress   上传进度信息
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (NSURLSessionTask *)uploadFileWithURL:(NSString *)URLString
                                      parameters:(id)parameters
                                            name:(NSString *)name
                                        filePath:(NSString *)filePath
                                        progress:(void (^)(NSProgress *progress))progress
                                         success:(void (^)(NSURLSessionDataTask *dataTask,id responseObject))success
                                         failure:(void (^)(NSError *error))failure;

/**
 *  上传单/多张图片
 *
 *  @param URLString        请求地址
 *  @param parameters 请求参数
 *  @param name       图片对应服务器上的字段
 *  @param images     图片数组
 *  @param fileNames  图片文件名数组, 可以为nil, 数组内的文件名默认为当前日期时间"yyyyMMddHHmmss"
 *  @param imageScale 图片文件压缩比 范围 (0.f ~ 1.f)
 *  @param imageType  图片文件的类型,例:png、jpg(默认类型)....
 *  @param progress   上传进度信息
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (NSURLSessionTask *)uploadImagesWithURL:(NSString *)URLString
                                        parameters:(id)parameters
                                              name:(NSString *)name
                                            images:(NSArray<UIImage *> *)images
                                         fileNames:(NSArray<NSString *> *)fileNames
                                        imageScale:(CGFloat)imageScale
                                         imageType:(NSString *)imageType
                                          progress:(void (^)(NSProgress *progress))progress
                                           success:(void (^)(NSURLSessionDataTask *dataTask,id responseObject))success
                                           failure:(void (^)(NSError *error))failure;

/**
 *  下载文件
 *
 *  @param URL      请求地址
 *  @param filePath  文件存储目录(默认存储目录为Download)
 *  @param progress 文件下载的进度信息
 *  @param success  下载成功的回调(回调参数filePath:文件的路径)
 *  @param failure  下载失败的回调
 *
 *  @return 返回NSURLSessionDownloadTask实例，可用于暂停继续，暂停调用suspend方法，开始下载调用resume方法
 */
+ (NSURLSessionTask *)downloadWithURL:(NSString *)URL
                                       fileDir:(NSString *)filePath
                                      progress:(void (^)(NSProgress *progress))progress
                                       success:(void(^)(NSString *filePath))success
                                       failure:(void (^)(NSError *error))failure;
@end
