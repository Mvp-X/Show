//
//  MvpProductController.m
//  Show
//
//  Created by Colorful on 16/5/28.
//  Copyright © 2016年 Mvp. All rights reserved.
//

#import "MvpProductController.h"
#import "MvpProduct.h"
#import "MvpProductCell.h"

@interface MvpProductController ()

@property (strong, nonatomic) NSArray* products;


@end

@implementation MvpProductController

static NSString* const reuseIdentifier = @"product_cell";

// 懒加载
- (NSArray*)products
{
    if (!_products) {
        // 1.获取文件路径
        NSString* path = [[NSBundle mainBundle] pathForResource:@"more_project" ofType:@"json"];
        
        // 2.把文件转化成NSData
        NSData* data = [NSData dataWithContentsOfFile:path];
        
        // 3.把data转成临时数组
        NSArray* tempArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        // 4.初始化可变数组
        NSMutableArray* array = [NSMutableArray array];
        
        // 5.遍历临时数组 获取字典
        for (NSDictionary* dict in tempArray) {
            // 6.字典转模型
            MvpProduct* p = [MvpProduct productWithDict:dict];
            
            // 7.把模型添加到可变数组当中
            [array addObject:p];
        }
        
        // 8.赋值
        _products = array;
    }
    return _products;
}

- (instancetype)init
{
    
    // 创建一个流水布局
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    // item大小
    layout.itemSize = CGSizeMake(80, 80);
    // item左右间距
    layout.minimumInteritemSpacing = 0;
    // 组间距
    layout.sectionInset = UIEdgeInsetsMake(16, 0, 0, 0);
    
    return [super initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 注册单元格
    [self.collectionView registerNib:[UINib nibWithNibName:@"MvpProductCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    // 设置collectionView的背景颜色
    self.collectionView.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.93 alpha:1];
}

// cell点击事件
- (void)collectionView:(UICollectionView*)collectionView didSelectItemAtIndexPath:(NSIndexPath*)indexPath
{
    
    // 获取模型
    MvpProduct* p = self.products[indexPath.row];
    
    // 获取app
    UIApplication* app = [UIApplication sharedApplication];
    // 获取 苹果商店 地址
    NSURL* storeUrl = [NSURL URLWithString:p.url];
    
    // 获取 本机程序 地址
    NSURL* appUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@://%@", p.customUrl, p.ids]];
    
    // ----- ios9 ------
    
    // 如果本机安装了某个程序 那么直接打开
    if (![app openURL:appUrl]) {
        // 如果没有安装 那么跳转到对应的app store上
        [app openURL:storeUrl];
    }
    
    // ----- ios9 ------
}

// 有多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView
{
    return 1;
}

// 某一组有多少行
- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.products.count;
}

// cell长什么样
- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath
{
    // 缓存池找
    MvpProductCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // 把数据传给cell
    cell.product = self.products[indexPath.row];
    
    return cell;
}

@end
