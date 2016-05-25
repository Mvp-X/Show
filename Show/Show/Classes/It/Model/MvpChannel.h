//
//  MvpChannel.h
//  Show
//
//  Created by Colorful on 16/5/24.
//  Copyright © 2016年 Mvp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MvpChannel : NSObject

//频道id
@property(nonatomic,copy)NSString *tid;

//频道名称
@property(nonatomic,copy)NSString *tname;

//每一个频道对应的加载数据的URLString

@property(nonatomic,copy,readonly)NSString *URLString;

//返回模型数组
+ (NSArray *)Mvpchannels;

@end
