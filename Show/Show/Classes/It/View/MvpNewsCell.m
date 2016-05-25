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

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *digestLabel;

@property (weak, nonatomic) IBOutlet UILabel *replyCountLabel;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *extraImageViews;

@end

@implementation MvpNewsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setNews:(MvpNews *)news{
    _news = news;
    
    //1.给我们的iconImageView赋值
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:news.imgsrc]];
    
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
        }
    }
}

@end
