//
//  MvpNewsCell.m
//  Show
//
//  Created by Colorful on 16/5/25.
//  Copyright © 2016年 Mvp. All rights reserved.
//

#import "MvpNewsCell.h"
#import <UIImageView+WebCache.h>
#import "MvpNews.h"

@interface MvpNewsCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

//记录使用
@property (weak, nonatomic) UIImageView *iconImageViewX;


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *digestLabel;

@property (weak, nonatomic) IBOutlet UILabel *replyCountLabel;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *extraImageViews;

//记录frame
@property (nonatomic, assign) CGRect lastFrame;

@end

@implementation MvpNewsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setNews:(MvpNews *)news{
    _news = news;
    
    //1.给我们的iconImageView赋值
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:news.imgsrc]];
    
//==========添加手势变大方法=================
    [self.iconImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)]];
    self.iconImageView.userInteractionEnabled = YES;
//==========添加手势变大方法=================
    
    //2.给titleLabel赋值
    self.titleLabel.text = news.title;
    
    //3.给digestLabel赋值
    self.digestLabel.text = news.digest;
    
    //给replyCountLabel赋值
    self.replyCountLabel.text = [NSString stringWithFormat:@"%d",news.replyCount];
    
    if (news.imgextra.count==2) {
        //多张图
        NSArray *dictArray = news.imgextra;
        
        for (int i=0; i<dictArray.count; i++) {
            NSDictionary *dict = dictArray[i];
            
            NSString *extraImageURLString = dict[@"imgsrc"];
            
            UIImageView *imageView = self.extraImageViews[i];
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:extraImageURLString]];
            //添加放大手势
            [imageView  addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)]];
            imageView.userInteractionEnabled = YES;
        }
    }
}

//点击放大
- (void)tapImageView:(UITapGestureRecognizer *)recognizer
{
    //添加遮盖
    UIView *cover = [[UIView alloc] init];
    cover.frame = [UIScreen mainScreen].bounds;
    cover.backgroundColor = [UIColor blackColor];
    [cover addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCover:)]];
    [[UIApplication sharedApplication].keyWindow addSubview:cover];
    
    //添加图片到遮盖上
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.iconImageView.image];
    //记录imageView
    self.iconImageViewX = imageView;
    //下面方法的意图是将cover(遮罩)中的frame转换为cell中对应的frame
    //返回的则是对应cell中的frame
    imageView.frame = [cover convertRect:recognizer.view.frame fromView:self];
    self.lastFrame = imageView.frame;
    [cover addSubview:imageView];
    
    //放大
    [UIView animateWithDuration:0.3f animations:^{
        cover.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.95];
        CGRect frame = imageView.frame;
        frame.size.width = cover.frame.size.width;
        frame.size.height = cover.frame.size.width * (imageView.image.size.height / imageView.image.size.width);
        frame.origin.x = 0;
        frame.origin.y = (cover.frame.size.height - frame.size.height) * 0.5;
        imageView.frame = frame;
    }];
}

//点击缩小
- (void)tapCover:(UITapGestureRecognizer *)recognizer
{
    [UIView animateWithDuration:0.3f animations:^{
        recognizer.view.backgroundColor = [UIColor clearColor];
//    改变alpha
        recognizer.view.alpha = 0;
        self.iconImageViewX.frame = self.lastFrame;
        
    }completion:^(BOOL finished) {
        if (finished){
            [recognizer.view removeFromSuperview];
            self.iconImageViewX = nil;
        }
    }];
}


@end
