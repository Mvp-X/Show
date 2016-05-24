//
//  MvpCar.m
//  Show
//
//  Created by Colorful on 16/5/24.
//  Copyright © 2016年 Mvp. All rights reserved.
//

#import "MvpCar.h"

@implementation MvpCar

-(instancetype)initWithDict:(NSDictionary *)dict{
    //初始化
    self = [super init];
    //判断是否为nil
    if (self) {
        //转模型
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
    
}

+ (instancetype)carWithDict:(NSDictionary *)dict{
    //调用对象方法
    return [[self alloc]initWithDict:dict];
}




@end
