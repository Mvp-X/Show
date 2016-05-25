//
//  MvpChannel.m
//  Show
//
//  Created by Colorful on 16/5/24.
//  Copyright © 2016年 Mvp. All rights reserved.
//

#import "MvpChannel.h"

@implementation MvpChannel

//+(NSArray *)channels{
//    NSArray *channels = @[@"One",@"Two",@"Three",@"Four",@"Five",@"Six",@"Seven",@"eight",@"nine",@"ten"];
//    return channels.copy;
//}

//通过重写tid方法给urlString赋值
-(void)setTid:(NSString *)tid{
    _tid = tid.copy;
    if ([tid isEqualToString:@"T1348647853363"]) {
        //头条
        _URLString = @"article/headline/T1348647853363/0-40.html";
    }else{
        //其它,比如社会,军事
        _URLString = [NSString stringWithFormat:@"article/list/%@/0-40.html",_tid];
    }
}

+ (NSArray *)properties{
    return @[@"tid",@"tname"];
}
//转模型方法
+ (instancetype)MvpchannelWithDict:(NSDictionary *)dict{
    
    id obj = [[self alloc] init];
    NSArray *properties = [self properties];
    
    for (NSString *property in properties) {
        if (dict[property]!=nil) {
//            KVC会调用set方法
            [obj setValue:dict[property] forKey:property];
        }
    }
    return obj;
}

//返回的模型数组
+(NSArray *)Mvpchannels{
    //1.Bundle中加载json文件
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"topic_news.json" withExtension:nil];
    //2.转二进制
    NSData *JSONData = [NSData dataWithContentsOfURL:fileURL];
    //3.二进制转字典
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:JSONData options:0 error:NULL];
    //4.根据字典的key取值---所得也是一个数组
    NSArray *dictArray = jsonDict[@"tList"];
    //5.遍历转模型
    NSMutableArray *channels = [NSMutableArray array];
    
    [dictArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        //转模型
        MvpChannel *channel = [MvpChannel MvpchannelWithDict:dict];
        
        [channels addObject:channel];
    }];
    //6.排序--数组调用方法---(记得更改参数类型)
    [channels sortUsingComparator:^NSComparisonResult(MvpChannel *obj1, MvpChannel *obj2) {
       //升序
        return [obj1.tid compare:obj2.tid];
    }];
    return channels.copy;
    
}

@end
