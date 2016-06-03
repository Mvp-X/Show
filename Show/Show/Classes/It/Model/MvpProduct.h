//
//  MvpProduct.h
//  Show
//
//  Created by Colorful on 16/5/28.
//  Copyright © 2016年 Mvp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MvpProduct : NSObject

@property (copy, nonatomic) NSString* title;
@property (copy, nonatomic) NSString* stitle;
@property (copy, nonatomic) NSString* ids;
@property (copy, nonatomic) NSString* url;
@property (copy, nonatomic) NSString* icon;
@property (copy, nonatomic) NSString* customUrl;

+ (instancetype)productWithDict:(NSDictionary*)dict;

@end
