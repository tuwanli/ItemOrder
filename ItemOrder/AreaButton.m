//
//  AreaButton.m
//  Newdemo
//
//  Created by 吕强 on 15/10/28.
//  Copyright © 2015年 吕强. All rights reserved.
//

#import "AreaButton.h"


@implementation AreaButton

-(AreaButton *)initWithFrame:(CGRect)frame Model:(NSDictionary *)model
{

    self = [AreaButton buttonWithType:UIButtonTypeCustom];
    self.frame = frame;
    
    CGFloat imageWidth = 60;
    //
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((frame.size.width-imageWidth)/2, (frame.size.width-imageWidth)/2-10, imageWidth, imageWidth)];
    [imageView setImage:[UIImage imageNamed:model[@"name"]]];
    
    [self addSubview:imageView];
    //title
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,imageView.frame.size.height+imageView.frame.origin.y+5,frame.size.width , 20)];
    [titleLabel setText:model[@"title"]];
    [titleLabel setFont:[UIFont systemFontOfSize:14]];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setTextColor:[UIColor grayColor]];
    [self addSubview:titleLabel];

    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1].CGColor;
    self.backgroundColor = [UIColor whiteColor];
    self.moveImg = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width-25,5, 20, 20)];
    [self.moveImg setImage:[UIImage imageNamed:@"ButtonMove.png"]];
    self.moveImg.hidden = YES;
    [self addSubview:self.moveImg];
    return self;
}


@end
