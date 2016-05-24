//
//  MvpCustomBar.h
//  Show
//
//  Created by Colorful on 16/5/24.
//  Copyright © 2016年 Mvp. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MvpCustomBar : UIView

//tabBar里面的按钮被点击
@property (nonatomic, copy) void(^btnClickBlock)(MvpCustomBar *tabBar, NSInteger index);


- (void)addTabBarBtnWithItem:(UITabBarItem *)item;


@end

