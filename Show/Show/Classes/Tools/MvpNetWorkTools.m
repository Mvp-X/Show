//
//  MvpNetWorkTools.m
//  Show
//
//  Created by Colorful on 16/5/25.
//  Copyright © 2016年 Mvp. All rights reserved.
//

#import "MvpNetWorkTools.h"
#import "AFNetworking.h"

static NSString * const BaseURLString = @"http://c.m.163.com/nc/";

@implementation MvpNetWorkTools

static MvpNetWorkTools *_instance;

+(instancetype)shareMvpNetWorkTools{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       _instance = [[MvpNetWorkTools alloc]initWithBaseURL:[NSURL URLWithString:BaseURLString]];
    //更改响应格式
    _instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
        
    });
    
    return _instance;
}

//GET请求方法
-(void)objectWithURLString:(NSString *)URLString completeBlock:(CompleteBlock)completeBlock{
//发起请求
   [self GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       if(completeBlock){
        //请求下来的数据AFN默认反序列化为json格式
           completeBlock(responseObject);
       }
   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       NSLog(@"error");
   }];
}
@end
