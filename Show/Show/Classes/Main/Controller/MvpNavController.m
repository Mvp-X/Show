//
//  MvpNavController.m
//  Show
//
//  Created by Colorful on 16/5/23.
//  Copyright © 2016年 Mvp. All rights reserved.
//

#import "MvpNavController.h"

@interface MvpNavController ()<UINavigationControllerDelegate>

@end

@implementation MvpNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    
    // 设置文字颜色为白色
    [self.navigationBar setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    
    // 设置tint颜色为白色
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    
    //设置底图
    UIImage *image = [UIImage imageNamed:@"dl_yzm"];
    UIImage *newImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.width * 0.5 ,image.size.height * 0.5,image.size.width * 0.5 ,image.size.height * 0.5) resizingMode:UIImageResizingModeStretch];
    // 设置导航栏背景图片
    [self.navigationBar setBackgroundImage:newImage forBarMetrics:UIBarMetricsDefault];
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:17], NSForegroundColorAttributeName : [UIColor whiteColor]};
    [self.navigationBar setTitleTextAttributes:attrs];
    self.navigationBar.translucent = NO;
}

- (void)pushViewController:(UIViewController*)viewController animated:(BOOL)animated
{
    // 重写push方法 把跳转到的控制器 都设置成为隐藏tabbar
    viewController.hidesBottomBarWhenPushed = YES;
    
    [super pushViewController:viewController animated:animated];
}

// 设置状态栏的样式
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

//-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    if (self.viewControllers.lastObject == viewController && self.viewControllers.count == 1) {
//        self.tabBar.hidden = NO;
//    } else {
//        self.tabBar.hidden = YES;
//    }
//    
//}
@end
