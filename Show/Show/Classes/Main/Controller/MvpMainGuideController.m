//
//  MvpMainGuideController.m
//  Show
//
//  Created by Colorful on 16/5/23.
//  Copyright © 2016年 Mvp. All rights reserved.
//

#import "MvpMainGuideController.h"
#import "MvpGuideCell.h"
#import "Masonry.h"
#import "MvpMainTabBarController.h"

@interface MvpMainGuideController ()

@end

@implementation MvpMainGuideController

static NSString * const reuseIdentifier = @"MvpGuideCell";


- (instancetype)init
{
    // 创建流水布局
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    
    if (self = [super initWithCollectionViewLayout:layout]) {
        
        layout.itemSize = [UIScreen mainScreen].bounds.size;
        //设置最小item间的间距
        layout.minimumInteritemSpacing = 0;
        
        //设置最小行的间距
        layout.minimumLineSpacing = 0;
        
        //4.滚动方向
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        //一页一页
        self.collectionView.showsHorizontalScrollIndicator = NO;
        
        //设置分页
        layout.collectionView.pagingEnabled = YES;
        
        //没有弹簧效果
        layout.collectionView.bounces = NO;
    }
    return self;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 注册cell
    [self.collectionView registerClass:[MvpGuideCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self setState];
}

-(void)setState{
    // 不显示滚动条
    self.collectionView.showsHorizontalScrollIndicator = NO;
    // 取消弹簧
    self.collectionView.bounces = NO;
    // 分页
    self.collectionView.pagingEnabled = YES;
    
}

#pragma -- 数据源方法
// 有多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView
{
    return 1;
}

// 有多少行
- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

// cell
- (UICollectionViewCell *)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath
{
    // 缓存池
    MvpGuideCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // 获取引导页的背景图
    UIImage* image = [UIImage imageNamed:[NSString stringWithFormat:@"0%ld引导页%ld_640x960", indexPath.item + 2,indexPath.item + 1]];
    
    // 把图片传到cell中
    cell.image = image;
    
    
    if(indexPath.item == 2){
        UIButton *button = [[UIButton alloc]init];
        [cell addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200, 100));
            make.bottom.equalTo(cell).offset(-30);
            make.right.equalTo(cell).offset(-75);
        }];
        [button addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return cell;
}

//点击点击按钮
-(void)clickBtn{

    [self presentViewController:[[MvpMainTabBarController alloc]init] animated:NO completion:nil];
    NSLog(@"-Mvp-");
}

@end
