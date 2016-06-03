//
//  MvpAbout.m
//  Show
//
//  Created by Colorful on 16/5/28.
//  Copyright © 2016年 Mvp. All rights reserved.
//

#import "MvpAbout.h"

@implementation MvpAbout

+ (instancetype)aboutHeaderView
{
    return [[NSBundle mainBundle] loadNibNamed:@"MvpAboutHeaderView" owner:nil options:nil][0];
}


@end
