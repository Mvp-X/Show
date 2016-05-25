//
//  MvpNews.h
//  Show
//
//  Created by Colorful on 16/5/25.
//  Copyright © 2016年 Mvp. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^FinishedBlock)(NSArray *newsList);

@interface MvpNews : NSObject

// 标题
@property (nonatomic, copy) NSString *title;
// 摘要
@property (nonatomic, copy) NSString *digest;
// 图片
@property (nonatomic, copy) NSString *imgsrc;
// 跟贴数
@property (nonatomic, assign) int replyCount;
// 多张配图
@property (nonatomic, strong) NSArray *imgextra;
// 大图标记
@property (nonatomic, assign) BOOL imgType;

//模型调用的加载数据方法--通过Block回调得到数据

+ (void)newsListWithURLString:(NSString *)URLString finishedBlock:(FinishedBlock)finishedBlock;

@end
