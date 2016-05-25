//
//  MvpCycleController.m
//  Show
//
//  Created by Colorful on 16/5/25.
//  Copyright © 2016年 Mvp. All rights reserved.
//

#import "MvpCycleController.h"
#import "MvpCycle.h"
#import "MvpCycleCell.h"
#import <objc/runtime.h>
#import "Masonry.h"

#define SectionCount 3
@interface MvpCycleController ()
//返回数据集合
@property(nonatomic,strong)NSArray *innerCycleList;

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *cycleFlowLayout;
//页码
@property(nonatomic,weak)UIPageControl *myPageControl;

@end

@implementation MvpCycleController

- (void)viewDidLoad {
    [super viewDidLoad];
    //取消滚动条
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    [self setupItemSize];
    
    //加载数据并刷新
    [self loadData];
    
    //初始化pageControl
    [self setupPageControl];
    
    //获取UIPageControl里面的所有属性
//    [self getUIPageControlProperties];
}

- (void)setupItemSize{
    self.cycleFlowLayout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 250);
}

- (void)loadData{
    __weak typeof(self) weakSelf = self;
    [MvpCycle cycleListWithURLString:@"ad/headline/0-4.html" niceBlock:^(NSArray *cycleList) {
        //记录数据
        weakSelf.innerCycleList = cycleList;
        
        //刷新表格
        [weakSelf.collectionView reloadData];
        
        //滚到中间那一组第一个
        NSIndexPath *centerIndexPath = [NSIndexPath indexPathForItem:0 inSection:SectionCount/2];
        
        [weakSelf.collectionView scrollToItemAtIndexPath:centerIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        
        //设置当前有几个numberOfPages
        weakSelf.myPageControl.numberOfPages = cycleList.count;
    }];
}


- (void)setupPageControl{
    //1.创建出来
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    //pageControl.backgroundColor = [UIColor redColor];
    //KVC可以给公有属性和私有属性赋值--以下为私有属性
    [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKey:@"_pageImage"];
    [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKey:@"_currentPageImage"];
    
    //2.添加到collectionView
    [self.view addSubview:pageControl];
    
#warning self.view不同于self.collectionView
    //设置Frame
    [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-6);
        make.bottom.equalTo(self.view).offset(8);
    }];
    
    //4.赋值
    self.myPageControl = pageControl;
}
//***************************获取UIPageControl里面的所有属性**************************

//- (void)getUIPageControlProperties{
//    unsigned int count;
//    /**
//     1.获取属性列表
//     class_copyPropertyList 这个方法只能获取类的公有属性
//     
//     class_copyIvarList 能获取类的所有属性,包括私有属性
//     **/
//    
//    Ivar *propertyList = class_copyIvarList([UIPageControl class], &count);
//    
//    for (int i=0; i<count; i++) {
//        //2.取出objc_property_t数组中的property
//        Ivar property = propertyList[i];
//        
//        //3.获取的是C语言的名称
//        const char *cPropertyName = ivar_getName(property);
//        
//        //4.将C语言的字符串转成OC的
//        NSString *ocPropertyName = [[NSString alloc] initWithCString:cPropertyName encoding:NSUTF8StringEncoding];
//        
//        //5.打印
//        //NSLog(@"%@",ocPropertyName);
//    }
//    
//    //5.C语言中,用完copy,create的东西之后,最好释放
//    free(propertyList);
//}
//***************************获取UIPageControl里面的所有属性**************************

#pragma mark - 滚动完毕之后,回到中间那组对应的第几个
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //1.计算当前滚动到第几页来了吧
    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    //2.取模,获取每组的索引
    NSInteger currentPage = index % self.innerCycleList.count;
    
    //3.回到中间那组对应的item
    NSIndexPath *centerIndex = [NSIndexPath indexPathForItem:currentPage inSection:SectionCount/2];
    
    [self.collectionView scrollToItemAtIndexPath:centerIndex atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    
    //4.设置当前选中的是哪个圈圈
    self.myPageControl.currentPage = currentPage;
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return SectionCount;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.innerCycleList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MvpCycleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MvpCycleCell" forIndexPath:indexPath];
    
    cell.cycle = self.innerCycleList[indexPath.item];
    
    return cell;
}
@end
