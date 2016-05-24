//
//  MvpChannelLabel.m
//  Show
//
//  Created by Colorful on 16/5/24.
//  Copyright © 2016年 Mvp. All rights reserved.
//

#import "MvpChannelLabel.h"

@implementation MvpChannelLabel

//初始化调用

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.textAlignment = NSTextAlignmentCenter;
        
        self.font = [UIFont systemFontOfSize:14];
        
        //开启交互
        self.userInteractionEnabled = YES;
        
        self.scale = 0;
    }
    
    return self;
}

- (void)setScale:(float)scale{
    _scale = scale;
    
    //颜色的变化
    self.textColor = [UIColor colorWithRed:scale green:0 blue:0 alpha:1.0];
    //transform的缩放
    CGFloat minScale = 0.8;
    
    //真实尺寸在0.8~1.0之间
    CGFloat realScale = minScale + (1 - minScale)*scale;
    
    self.transform = CGAffineTransformMakeScale(realScale, realScale);
}

@end
