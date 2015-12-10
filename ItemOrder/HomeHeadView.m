//
//  HomeHeadView.m
//  Newdemo
//
//  Created by 吕强 on 15/10/28.
//  Copyright © 2015年 吕强. All rights reserved.
//
#define KBase_tag     100
#define k_width  [UIScreen mainScreen].bounds.size.width
#define k_height [UIScreen mainScreen].bounds.size.height
#define AirButtonHeight  ([UIScreen mainScreen].bounds.size.width/4+5)
#import "HomeHeadView.h"
//#import "Tool.h"
@implementation HomeHeadView


-(void)configWithModelArr:(NSArray *)dataArr
{
    
    backView = [[UIView alloc]initWithFrame:CGRectMake(0, 91, k_width, AirButtonHeight*2)];
    backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backView];

    self.modelArr = [NSMutableArray arrayWithArray:dataArr];
    
    
    //创建按钮
    CGFloat buttonWidth = self.frame.size.width/4;
    for (int i = 0 ; i < dataArr.count; i++) {
        
        AreaButton *area = [[AreaButton alloc]initWithFrame:CGRectMake(i%4*buttonWidth, i/4*AirButtonHeight, buttonWidth, AirButtonHeight) Model:self.modelArr[i]];
        area.tag = KBase_tag+i;
        [backView addSubview:area];
        // 长按手势
        UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [area addGestureRecognizer:longPress];
    }
    
}
/**
 *  长按手势
 */
-(void)longPress:(UIGestureRecognizer*)recognizer{
    //
    AreaButton *recognizerView = (AreaButton *)recognizer.view;
    
    // 禁用其他按钮的拖拽手势
    for (UIButton * bt in backView.subviews) {
        if (bt!=recognizerView) {
            bt.userInteractionEnabled = NO;
        }
    }
    
    // 长按视图在父视图中的位置（触摸点的位置）
    CGPoint recognizerPoint = [recognizer locationInView:backView];
    NSLog(@"_____%@",NSStringFromCGPoint(recognizerPoint));
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        // 开始的时候改变拖动view的外观（放大，改变颜色等）
        [UIView animateWithDuration:0.2 animations:^{
            recognizerView.transform = CGAffineTransformMakeScale(1.3, 1.3);
            recognizerView.alpha = 0.7;
        }];
        
        // 把拖动view放到最上层
        [backView bringSubviewToFront:recognizerView];
        
        // valuePoint保存最新的移动位置
        valuePoint = recognizerView.center;
        recognizerView.moveImg.hidden = NO;
    }else if(recognizer.state == UIGestureRecognizerStateChanged){
        
        // 更新pan.view的center
        recognizerView.center = recognizerPoint;
        
        /**
         * 可以创建一个继承UIButton的类(MyButton)，这样便于扩展，增加一些属性来绑定数据
         * 如果在self.view上加其他控件拖拽会奔溃，可以在下面方法里面加判断MyButton，也可以把所有按钮放到一个全局变量的UIView上来替换self.view
         
         */
        for (UIButton * bt in backView.subviews) {
            
            // 判断是否移动到另一个view区域
            // CGRectContainsPoint(rect,point) 判断某个点是否被某个frame包含
            if (CGRectContainsPoint(bt.frame, recognizerView.center)&&bt!=recognizerView)
            {
                NSLog(@"bt_______%@",bt);
                // 开始位置
                NSInteger fromIndex = recognizerView.tag - KBase_tag;
                
                // 需要移动到的位置
                NSInteger toIndex = bt.tag - KBase_tag;
                NSLog(@"开始位置=%ld  结束位置=%ld",fromIndex,toIndex);
                
                // 往后移动
                if ((toIndex-fromIndex)>0) {
                    
                    // 从开始位置移动到结束位置
                    // 把移动view的下一个view移动到记录的view的位置(valuePoint)，并把下一view的位置记为新的nextPoint，并把view的tag值-1,依次类推
                    [UIView animateWithDuration:0.2 animations:^{
                        for (NSInteger i = fromIndex+1; i<=toIndex; i++) {
                            UIButton * nextBt = (UIButton*)[backView viewWithTag:KBase_tag+i];
                            nextPoint = nextBt.center;
                            nextBt.center = valuePoint;
                            valuePoint = nextPoint;
                            
                            nextBt.tag--;
                            
                        }
                        recognizerView.tag = KBase_tag + toIndex;
                        
                        
                    }];
                    
                }
                // 往前移动
                else
                {
                    // 从开始位置移动到结束位置
                    // 把移动view的上一个view移动到记录的view的位置(valuePoint)，并把上一view的位置记为新的nextPoint，并把view的tag值+1,依次类推
                    [UIView animateWithDuration:0.2 animations:^{
                        for (NSInteger i = fromIndex-1; i>=toIndex; i--) {
                            UIButton * nextBt = (UIButton*)[backView viewWithTag:KBase_tag+i];
                            nextPoint = nextBt.center;
                            nextBt.center = valuePoint;
                            valuePoint = nextPoint;
                            
                            nextBt.tag++;
                        }
                        recognizerView.tag = KBase_tag + toIndex;
                        
                        
                    }];
                    
                }
    
            }
            
        }
        
    }else if(recognizer.state == UIGestureRecognizerStateEnded){
        // 恢复其他按钮的拖拽手势
        for (UIButton * bt in backView.subviews) {
            if (bt!=recognizerView) {
                bt.userInteractionEnabled = YES;
            }
        }
        
        // 结束时候恢复view的外观（放大，改变颜色等）
        [UIView animateWithDuration:0.2 animations:^{
            recognizerView.transform = CGAffineTransformMakeScale(1.0, 1.0);
            recognizerView.alpha = 1;
            
            recognizerView.center = valuePoint;
            
        }];
        recognizerView.moveImg.hidden = YES;
        //记录button

    }
}

@end
