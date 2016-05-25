//
//  MvpNetWorkTools.h
//  Show
//
//  Created by Colorful on 16/5/25.
//  Copyright © 2016年 Mvp. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef void (^CompleteBlock)(id object);

@interface MvpNetWorkTools : AFHTTPSessionManager

//单例请求类
+(instancetype)shareMvpNetWorkTools;

//传入url返回响应数据
-(void)objectWithURLString:(NSString *)URLString completeBlock:(CompleteBlock)completeBlock;

@end
