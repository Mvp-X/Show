//
//  MvpCar.h
//  Show
//
//  Created by Colorful on 16/5/24.
//  Copyright © 2016年 Mvp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MvpCar : NSObject


@property (nonatomic,copy) NSString *icon;


@property (nonatomic,copy) NSString *name;



-(instancetype)initWithDict:(NSDictionary *)dict;


+ (instancetype)carWithDict:(NSDictionary *)dict;



@end
