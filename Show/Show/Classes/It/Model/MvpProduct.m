//
//  MvpProduct.m
//  Show
//
//  Created by Colorful on 16/5/28.
//  Copyright © 2016年 Mvp. All rights reserved.
//

#import "MvpProduct.h"

@implementation MvpProduct

+ (instancetype)productWithDict:(NSDictionary*)dict
{
    MvpProduct* p = [[self alloc] init];
    p.title = dict[@"title"];
    p.stitle = dict[@"stitle"];
    p.ids = dict[@"id"];
    p.url = dict[@"url"];
    p.icon = dict[@"icon"];
    p.customUrl = dict[@"customUrl"];
    return p;
}

@end
