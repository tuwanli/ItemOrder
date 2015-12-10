//
//  ViewController.m
//  ItemOrder
//
//  Created by 涂婉丽 on 15/12/10.
//  Copyright (c) 2015年 涂婉丽. All rights reserved.
//
#define k_width  [UIScreen mainScreen].bounds.size.width
#define k_height [UIScreen mainScreen].bounds.size.height
#define AirButtonHeight  ([UIScreen mainScreen].bounds.size.width/4+5)
#import "ViewController.h"
#import "HomeHeadView.h"
@interface ViewController ()
@property (nonatomic,strong)NSMutableArray *MenuArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
- (void)initUI
{
    _MenuArr  = [[NSMutableArray alloc]init];
    for (int i=0; i<8; i++) {
        NSString *str1 = [NSString stringWithFormat:@"title%d",i];
        NSString *str2 = [NSString stringWithFormat:@"%d",i+1];
        NSDictionary *dict = @{@"name":str2,@"title":str1};
        [_MenuArr addObject:dict];
    }

    NSLog(@"%@",_MenuArr);
    HomeHeadView *homeView = [[HomeHeadView alloc]initWithFrame:CGRectMake(0, 64, k_width, 91+(AirButtonHeight*2)+5)];
    [homeView configWithModelArr:_MenuArr];
    [self.view addSubview:homeView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
