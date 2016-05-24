//
//  MvpCarGroup.m
//  Show
//
//  Created by Colorful on 16/5/24.
//  Copyright © 2016年 Mvp. All rights reserved.
//

#import "MvpCarGroup.h"
#import "MvpCar.h"

@implementation MvpCarGroup

- (void)setCars:(NSArray *)cars{
    
    if (_cars == nil) {
        //1.定义可变数组
        NSMutableArray *nmArray = [NSMutableArray array];
        //2。遍历字典数组
        for (NSDictionary *dict in cars) {
            //3.字典转模型
            MvpCar *car = [MvpCar carWithDict:dict];
        
            //4.讲模型添加到可变数组中
            [nmArray addObject:car];
        
        }
        //5.赋值给数组
        _cars = nmArray;
    }

}

-(instancetype)initWithDict:(NSDictionary *)dict{
    
    //初始化
    self = [super init];
    //判断对象是否为nil
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
  
    }
    return self;
}

+ (instancetype)carGroupWithDict:(NSDictionary *)dict{
    //调用对象方法
    return [[self alloc]initWithDict:dict];
}



@end
