//
//  MvpconvertController.m
//  Show
//
//  Created by Colorful on 16/5/28.
//  Copyright © 2016年 Mvp. All rights reserved.
//

#import "MvpconvertController.h"

@interface MvpconvertController ()
//遮罩
@property (weak, nonatomic) UIView* coverView;
//弹图
@property (weak, nonatomic) UIImageView* imageView;

@end

@implementation MvpconvertController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setSegmentedControl];
    
    //设置rightBarButtonItem
    [self setRightBarItem];
}


-(void)setSegmentedControl{

    // 设置控制器view的背景图片
//    self.view.layer.contents = (__bridge id)[UIImage imageNamed:@"NLArenaBackground"].CGImage;
    
    // 创建UISegmentedControl
    UISegmentedControl * seg=[[UISegmentedControl alloc] initWithFrame:CGRectMake(80.0f, 8.0f, 150.0f, 30.0f) ];
    //设置标题
    [seg insertSegmentWithTitle:@"One" atIndex:0 animated:YES];
    [seg insertSegmentWithTitle:@"Two" atIndex:1 animated:YES];
    [seg insertSegmentWithTitle:@"Three" atIndex:2 animated:YES];
    
    // 设置seg的背景--UIBarMetricsDefault会完整填充
    [seg setBackgroundImage:[UIImage imageNamed:@"CPArenaSegmentBG"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [seg setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    //是否保持选中状态
    seg.momentary = YES;
    //关闭多点触摸
    seg.multipleTouchEnabled=NO;
    
    // 设置文字的颜色
    [seg setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] } forState:UIControlStateNormal];
    [seg setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] } forState:UIControlStateSelected];
    
    // 取消蓝色的线
    [seg setTintColor:[UIColor clearColor]];
    
    //添加切换方法
//    [seg addTarget:self action:@selector(SelectSeg) forControlEvents:UIControlEventValueChanged];
    
    //设置替换titleView
    [self.navigationItem setTitleView:seg];
    
}

//设置leftBarButtonItem
-(void)setRightBarItem{
    // 获取图片
    UIImage* image = [UIImage imageNamed:@"lamp"];
    // 告诉系统不要进行蓝色的渲染
//    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 创建坐上角的按钮
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(btnClick)];
    
    // 设置右上角按钮
    self.navigationItem.rightBarButtonItem = item;
    
}

// 活动的点击事件
- (void)btnClick
{
    // 创建一个遮罩
    UIView* coverView = [[UIView alloc] init];
    coverView.frame = [UIScreen mainScreen].bounds;
    coverView.backgroundColor = [UIColor blackColor];
    coverView.alpha = 0.5;
    [self.tabBarController.view addSubview:coverView];
    
    /**
     UIImageView不用设置Frame--图片本身大小直接影响.
     **/
    // 创建图片框
    UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"482739ca55c5e89f81fc1073e0fae298"]];
    imageView.center = self.view.center;
    // 开启用户交互 让上面的按钮可以点击
    imageView.userInteractionEnabled = YES;
    [self.tabBarController.view addSubview:imageView];
    
    // 创建button
    
    UIButton* closeButton = [[UIButton alloc] init];
    // 获取关闭按钮的图片
    UIImage* closeImage = [UIImage imageNamed:@"alphaClose"];
    [closeButton setImage:closeImage forState:UIControlStateNormal];
    closeButton.frame = CGRectMake(imageView.bounds.size.width - closeImage.size.width, 0, closeImage.size.width, closeImage.size.height);
    // 监听点击事件
    [closeButton addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:closeButton];
    
    self.imageView = imageView;
    self.coverView = coverView;
}

// 关闭按钮点击事件
- (void)closeClick
{
    [self.imageView removeFromSuperview];
    [self.coverView removeFromSuperview];
}

@end
