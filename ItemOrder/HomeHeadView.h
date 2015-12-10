//
//  HomeHeadView.h
//  Newdemo
//
//  Created by 吕强 on 15/10/28.
//  Copyright © 2015年 吕强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AreaButton.h"


@interface HomeHeadView : UIView
{
    
    // 开始拖动的view的下一个view的CGPoint（如果开始位置是0 结束位置是4 nextPoint值逐个往下算）
    CGPoint nextPoint;
    
    // 用于赋值CGPoint
    CGPoint valuePoint;
    
    UIView *backView;
    
    
}

@property (nonatomic,strong)NSMutableArray *modelArr;
-(void)configWithModelArr:(NSArray *)dataArr;
@end
