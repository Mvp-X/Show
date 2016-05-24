//
//  MvpMoreController.m
//  Show
//
//  Created by Colorful on 16/5/24.
//  Copyright © 2016年 Mvp. All rights reserved.
//

#import "MvpMoreController.h"
#import "MvpChannel.h"
#import "MvpChannelLabel.h"
#import "MvpMoreCell.h"



@interface MvpMoreController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UIScrollView *channelScrollView;
//模型数组-得到数据
@property(nonatomic,strong)NSArray *channels;
//控件数组-得到控件
@property(nonatomic,strong)NSMutableArray *channelLabels;

//**********************collectionViewll相关***********************

@property (weak, nonatomic) IBOutlet UICollectionView *ArticleContentCollectionView;

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *ArticleContentFlowLayout;




//记录选中label对应的标签的索引
@property(nonatomic,assign)NSUInteger currentSeleceIndex;
////底部注册-登录控件
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation MvpMoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    //加载频道的Label
    [self setupChannelLabels];
    //关掉自适应
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //设置我们ContentCollectionView里面的itemSize
    [self setContentCollectionViewItemSize];
    
    //设置登录注册底部View
    [self setBottomView];
}

#pragma mark - 懒加载
//初始化控件数组
- (NSMutableArray *)channelLabels{
    if (_channelLabels==nil) {
        _channelLabels = [NSMutableArray array];
    }
    
    return _channelLabels;
}

#pragma mark - 加载频道的标签
- (void)setupChannelLabels{
    //1.通过模型去加载模型数组
    self.channels = [MvpChannel channels];
    
    //2.循环去创建对应个数的ChannelLabel
    CGFloat channelLabelX = 0;
    CGFloat channelLabelY = 0;
    CGFloat channelLabelW = 80;
    CGFloat channelLabelH = self.channelScrollView.bounds.size.height;
    for (int i= 0; i<self.channels.count; i++) {
        //2.1 创建一个ChannelLabel
        MvpChannelLabel *channelLabel = [[MvpChannelLabel alloc] init];
        
        if (i==0) {//表示第一个
            channelLabel.scale = 1.0;
        }
        
        //2.1.1 给我们的创建出来的channelLabel添加一个tag,并且添加交互
        channelLabel.tag = i;
        //频道控件加到控件数组中
        
        [self.channelLabels addObject:channelLabel];
        
        //2.2 设置frame
        channelLabelX  = i * channelLabelW;
        channelLabel.frame = CGRectMake(channelLabelX, channelLabelY, channelLabelW, channelLabelH);
        
        //2.3 设置文字
        channelLabel.text = self.channels[i];
        
        //2.4 加入父控件身上
        [self.channelScrollView addSubview:channelLabel];
        
        ////        //2.5 给我们channelLabel添加手势
        [channelLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(channelLabel:)]];
    }
    
    //3.设置channelScrollView的contentSize
    self.channelScrollView.contentSize = CGSizeMake(channelLabelW * self.channels.count, 0);
}

#pragma mark -ContentCollectionView的itemsize大小
- (void)setContentCollectionViewItemSize{
    CGFloat itemSizeW = [UIScreen mainScreen].bounds.size.width;
    CGFloat itemSizeH = [UIScreen mainScreen].bounds.size.height - 64 - 44;
    self.ArticleContentFlowLayout.itemSize = CGSizeMake(itemSizeW, itemSizeH);
}


//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    self.tabBarController.tabBar.hidden = YES;
//    
//}
//
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    self.tabBarController.tabBar.hidden = NO;
//}


#pragma mark - CollectionView数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.channels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MvpMoreCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Mvp" forIndexPath:indexPath];
    
    
    return cell;
}

#pragma mark - 上下联动相关代码
- (void)channelLabel:(UITapGestureRecognizer *)recognizer{
    MvpChannelLabel *clickChannelLabel = (MvpChannelLabel *)recognizer.view;
    
    //记录属性---当前选中的索引
    self.currentSeleceIndex = clickChannelLabel.tag;
    
    //2.让下面的newsContentCollectionView滚动
    CGFloat offsetX = clickChannelLabel.tag * self.ArticleContentCollectionView.bounds.size.width;
    
    
    // 切记animated选择NO--滑动时不会多次请求- 因为如果是YES的话,会经过很多个item,这样很一个item都会去发请求,并且,会看到连续经过这些item
    [self.ArticleContentCollectionView setContentOffset:CGPointMake(offsetX, 0) animated:NO];
    
    //3.调用最终的方法,让我们被点击的频道标签,居中
    [self lastMethod:self.ArticleContentCollectionView];
}


#pragma mark - 下面的collectionView的item手动拖拽结束后也调用label居中方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //这个scroll就是下面的newsContentCollectionView
    [self lastMethod:scrollView];
}

#pragma mark - scrowView和ArticleContentCollectionView居中方法
- (void)lastMethod:(UIScrollView *)scrollView{
    //下面的滚动到了第几页来了--滚动偏差/可见范围
    self.currentSeleceIndex = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    //1.点击的频道标签居中
    MvpChannelLabel *selectChannelLabel = self.channelLabels[self.currentSeleceIndex];
    
    //2.计算channelScrollView应该滚动的偏移量--label的center-scrollview的一半
    CGFloat needScrollOffsetX = selectChannelLabel.center.x - self.channelScrollView.bounds.size.width * 0.5;
    
    //*****************设置极端值************************
    //当发现滚动距离<0
    if (needScrollOffsetX < 0) {
        needScrollOffsetX = 0;
    }
    
    //只能允许滚出的最大距离
    CGFloat maxScrollOffsetX = self.channelScrollView.contentSize.width - self.channelScrollView.bounds.size.width ;
    
    if (needScrollOffsetX > maxScrollOffsetX) {
        needScrollOffsetX = maxScrollOffsetX;
    }
    //*****************设置极端值************************
    
    //3.让channelScrollView滚动
    [self.channelScrollView setContentOffset:CGPointMake(needScrollOffsetX, 0) animated:YES];
    
    // 必须重置一下,我们的缩放比率
    for (MvpChannelLabel *channelLabel in self.channelLabels) {
        if (channelLabel.tag == self.currentSeleceIndex) {
            channelLabel.scale = 1.0;
        }else{
            channelLabel.scale = 0.0;
        }
    }
}

#pragma mark - 手动拖拽结束调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //1.让我们的标签进行颜色值的变化及缩放
    float value = scrollView.contentOffset.x / scrollView.bounds.size.width;
    //最左及最右不做变化
    if (value<0 || value>(self.channelLabels.count-1)) return;
    
    //1.1 1
    //2.4 2 =0.4
    //1.左边的索引
    int leftIndex = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    //2.右边的索引=左边的索引 + 1;
    int rightIndex = leftIndex + 1;
    
    //3.右边的比率
    CGFloat rightScale = value - leftIndex;
    
    //4.左边的比率
    CGFloat leftScale = 1- rightScale;
    
    //5.分别拿到左右的标签给其设置缩放比率,并且注意,左右加起来是1
    MvpChannelLabel *leftChannelLabel = self.channelLabels[leftIndex];
    leftChannelLabel.scale = leftScale;
    
    //切记判断长度---这里需要判断一下,防止越界
    if (rightIndex<self.channelLabels.count) {
        MvpChannelLabel *rightChannelLabel = self.channelLabels[rightIndex];
        rightChannelLabel.scale = rightScale;
    }
    
}

#pragma mark - 设置底部注册-登录View

-(void)setBottomView{
    //在此判断是否登录--是否显示
    if(self.isLogin == NO){
        [self.view bringSubviewToFront: self.bottomView];
    }else{
        self.bottomView.hidden = YES;
    }
}

- (IBAction)ClickRightItemButton:(UIBarButtonItem *)sender {
    self.bottomView.hidden =YES;
    
}
- (IBAction)ClickLeftItemButton:(UIBarButtonItem *)sender {
    
    [self dismissViewControllerAnimated:NO completion:Nil];
}


@end
