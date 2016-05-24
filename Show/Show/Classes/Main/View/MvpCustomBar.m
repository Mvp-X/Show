//
//  MvpCustomBar.m
//  Show
//
//  Created by Colorful on 16/5/24.
//  Copyright © 2016年 Mvp. All rights reserved.
//

#import "MvpCustomBar.h"
#import "MvpCustomBtn.h"

@interface MvpCustomBar()

//这个按钮的作用是来记录上个按钮的状态

@property (nonatomic, weak) MvpCustomBtn *tempTabBarBtn;

@end


@implementation MvpCustomBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 遍历子控件
    for (int i = 0; i < self.subviews.count; i++) {
        // 计算尺寸
        CGFloat tabBarBtnW = self.bounds.size.width / self.subviews.count;
        CGFloat tabBarBtnH = self.bounds.size.height;
        CGFloat tabBarBtnX = tabBarBtnW * i;
        CGFloat tabBarBtnY = 0;
        
        // 取出每个子控件
        MvpCustomBtn *tabBarBtn = self.subviews[i];
        tabBarBtn.frame = CGRectMake(tabBarBtnX, tabBarBtnY, tabBarBtnW, tabBarBtnH);
        
    }
    
}

- (void)addTabBarBtnWithItem:(UITabBarItem *)item
{
    // 创建按钮
    MvpCustomBtn *tabBarBtn = [[MvpCustomBtn alloc] init];
    // 绑定tag
    tabBarBtn.tag = self.subviews.count;
    // 监听按钮的点击
    [tabBarBtn addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchDown];
    // 添加按钮
    [self addSubview:tabBarBtn];
    
    // 设置子控件的图片
    [tabBarBtn setImage:item.image forState:UIControlStateNormal];
    // 设置选中的图片
    [tabBarBtn setImage:item.selectedImage forState:UIControlStateSelected];
    // 设置按钮的文字
//    [tabBarBtn setTitle:item.title forState:UIControlStateNormal];
    
    // 默认选择第一个btn
    if (self.subviews.count == 1)
    {
        [self tabBarButtonClick:tabBarBtn];
    }
    
}

- (void)tabBarButtonClick:(MvpCustomBtn *)tabBarBtn
{
    if (self.btnClickBlock) {
        self.btnClickBlock(self, tabBarBtn.tag);
    }
    // 修改上一次点击按钮的状态
    self.tempTabBarBtn.selected = NO;
    tabBarBtn.selected = YES;
    self.tempTabBarBtn = tabBarBtn;
}


@end
