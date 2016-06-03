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

    //设置底图
    UIImage *image = [UIImage imageNamed:@"dl_yzm"];
    UIImage *newImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.width * 0.5 ,image.size.height * 0.5,image.size.width * 0.5 ,image.size.height * 0.5) resizingMode:UIImageResizingModeStretch];
    // 设置导航栏背景图片
    [self.navigationBar setBackgroundImage:newImage forBarMetrics:UIBarMetricsDefault];
    
    // 设置文字颜色为白色
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:17], NSForegroundColorAttributeName : [UIColor whiteColor]};
    [self.navigationBar setTitleTextAttributes:attrs];
    
    // 设置tint颜色为白色
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    
    //半透明--位置会发生变化
//    self.navigationBar.translucent = NO;
}



//// 重写push方法 把跳转到的控制器 都设置成为隐藏tabbar--不适用于view自定义的tabbar
//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    if (self.viewControllers.count > 0) {
//        viewController.hidesBottomBarWhenPushed = YES;
//    }
//    [super pushViewController:viewController animated:animated];
//}

//// 设置状态栏的样式
//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}

//nav的代理方法可以实现tabbar的隐藏
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.lastObject == viewController && self.viewControllers.count == 1) {
        self.tabBar.hidden = NO;
    } else {
        self.tabBar.hidden = YES;
    }
    
}
@end
