//
//  MvpCycleCell.m
//  Show
//
//  Created by Colorful on 16/5/25.
//  Copyright © 2016年 Mvp. All rights reserved.
//

#import "MvpCycleCell.h"
#import "MvpCycle.h"
#import <UIImageView+WebCache.h>

@interface MvpCycleCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation MvpCycleCell

- (void)setCycle:(MvpCycle *)cycle{
    _cycle = cycle;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:cycle.imgsrc]];
    
    self.titleLabel.text = cycle.title;
}

@end
