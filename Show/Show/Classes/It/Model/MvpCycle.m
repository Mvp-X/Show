//
//  MvpCycle.m
//  Show
//
//  Created by Colorful on 16/5/25.
//  Copyright © 2016年 Mvp. All rights reserved.
//

#import "MvpCycle.h"
#import "MvpNetWorkTools.h"
#import <objc/runtime.h>

@implementation MvpCycle

//通过运行时获取属性
+(NSArray *)properties{
    //获取个数
    unsigned int count;
    //运行时方法--返回(属性列表)字符串集合数组(propertyList)
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    //定义OC可变数组
    NSMutableArray *ocProperties = [NSMutableArray array];
    //遍历
    for (int i = 0 ; i < count ; i++){
        //在属性列表中取出每一个属性
        objc_property_t property = propertyList[i];
        //获取对应名称--此方法获得是C语言名称
        const char *cPropertyName = property_getName(property);
        //将C字符串转成OC字符串
        NSString *ocPropertyName = [[NSString alloc]initWithCString:cPropertyName encoding:NSUTF8StringEncoding];
        //添加到可变数组中
        [ocProperties addObject:ocPropertyName];
    }
    //****记得释放C中creat的数组****
    free(propertyList);
    
    return ocProperties.copy;
}

//转模型类方法
+(instancetype)mvpCycleWithDict:(NSDictionary *)dict{
    
    id obj = [[self alloc] init];
    
    NSArray *properties = [self properties];
    for (NSString *property in properties) {
        if (dict[property]!=nil) {
            //KVC赋值
            [obj setValue:dict[property] forKey:property];
        }
    }
    
    return obj;
}

//模型调用加载数据的方法
+(void)cycleListWithURLString:(NSString *)URLString niceBlock:(NiceBlock)niceBlock{
    //1.创建单例加载
    [[MvpNetWorkTools shareMvpNetWorkTools]objectWithURLString:URLString completeBlock:^(id object) {
        if([object isKindOfClass:[NSDictionary class]]){
            //如果true-强转成字典
            NSDictionary *result = (NSDictionary *)object;
            //2.通过键名取得字典数组
            NSArray *dictArray = result[@"headline_ad"];
            //3.遍历--转模型
            NSMutableArray *CycleList = [NSMutableArray array];
            //更改参数中第一个为相应类型--字典类型
            [dictArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
                MvpCycle *cycle = [MvpCycle mvpCycleWithDict:dict];
                //添加
                [CycleList addObject:cycle];
            }];
            //5.通过block,返回我们的模型数组
            if (niceBlock) {
                niceBlock(CycleList.copy);
            }
        }
    }];
    
}

@end
