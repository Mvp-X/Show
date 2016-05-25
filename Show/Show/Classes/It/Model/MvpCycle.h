//
//  MvpCycle.h
//  Show
//
//  Created by Colorful on 16/5/25.
//  Copyright © 2016年 Mvp. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^NiceBlock)(NSArray *cycleList);


@interface MvpCycle : NSObject

//标题
@property (nonatomic, copy) NSString *title;

//图片
@property (nonatomic, copy) NSString *imgsrc;

//传入一个URLString,加载后通过block把模型数组返回给控制器
 
+ (void)cycleListWithURLString:(NSString *)URLString niceBlock:(NiceBlock)niceBlock;


@end
