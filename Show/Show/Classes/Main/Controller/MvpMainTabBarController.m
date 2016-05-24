//
//  MvpMainTabBarController.m
//  Show
//
//  Created by Colorful on 16/5/23.
//  Copyright © 2016年 Mvp. All rights reserved.
//

#import "MvpMainTabBarController.h"
#import "MvpNavController.h"
#import "MvpCustomBar.h"
#import "MvpMineController.h"
#import "MvpYourController.h"
#import "MvpItController.h"


@interface MvpMainTabBarController ()

@property (nonatomic, weak) MvpCustomBar *customTabBar;


@end

@implementation MvpMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化自定义的tabBar
    [self setupCustomTabBar];
    
    //设置子控制器
    [self setChildController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setChildController{
    MvpItController *ItC = [[MvpItController alloc]init];
    [self setChild:ItC title:@"It" imageName:@"cy" selectImageName:@"cy_h"];
    MvpYourController *YourC = [[MvpYourController alloc]init];
    [self setChild:YourC title:@"Your" imageName:@"xc" selectImageName:@"xc_h"];
    MvpMineController *MineC = [[MvpMineController alloc]init];
    [self setChild:MineC title:@"Mine" imageName:@"my" selectImageName:@"my_h"];
    
}

//供setChildController调用的设置方法
-(void)setChild:(UIViewController *)childVc title:(NSString*)title imageName:(NSString *)imageName selectImageName:(NSString *)selectImageName{
    //以原图显示的方法
    childVc.tabBarItem.image =[[UIImage imageNamed:imageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.title = title;
    MvpNavController *NaV = [[MvpNavController alloc]initWithRootViewController:childVc];
    [self addChildViewController:NaV];
    //添加按钮
    [self.customTabBar addTabBarBtnWithItem:childVc.tabBarItem];
    
    
    
}

- (void)setupCustomTabBar
{
    MvpCustomBar *customTabBar = [[MvpCustomBar alloc] init];
    customTabBar.frame = self.tabBar.frame;
    // 添加到系统的tabBar上
    [self.view addSubview:customTabBar];
    // 赋值给成员变量
    self.customTabBar = customTabBar;
    [self.tabBar removeFromSuperview];
    
    //    弱引用block
    __weak typeof(self) weakSelf = self;
    
    // 给block赋值
    customTabBar.btnClickBlock = ^(MvpCustomBar *customTabBar, NSInteger index){
        weakSelf.selectedIndex = index;
    };
    
    
}


@end
