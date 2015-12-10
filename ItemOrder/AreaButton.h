//
//  ViewController.h
//  ItemOrder
//
//  Created by 涂婉丽 on 15/12/10.
//  Copyright (c) 2015年 涂婉丽. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface AreaButton : UIButton

@property (nonatomic,retain) UIImageView *moveImg;
-(AreaButton *)initWithFrame:(CGRect)frame Model:(NSDictionary *)model;
@end
