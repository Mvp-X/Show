//
//  MvpCarGroup.h
//  Show
//
//  Created by Colorful on 16/5/24.
//  Copyright © 2016年 Mvp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MvpCarGroup : NSObject

//车的数组
@property (nonatomic,strong) NSMutableArray *cars;

//标头
@property (nonatomic,copy) NSString *title;


-(instancetype)initWithDict:(NSDictionary *)dict;


+ (instancetype)carGroupWithDict:(NSDictionary *)dict;



@end
