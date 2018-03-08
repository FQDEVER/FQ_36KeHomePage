//
//  ViewController.m
//  FQ_MineScrollerVC
//
//  Created by mac on 2017/7/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ViewController.h"
#import "FQ_MineScrollerVC.h"
#import "FQ_MineScrollerModel.h"
#import "TestViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    
    FQ_MineScrollerModel * scrollerModel = [[FQ_MineScrollerModel alloc]init];
    
    TestViewController * testVC1 = [[TestViewController alloc]init];
    testVC1.view.backgroundColor = [UIColor orangeColor];
    
    TestViewController * testVC2 = [[TestViewController alloc]init];
    testVC2.view.backgroundColor = [UIColor whiteColor];
    
    TestViewController * testVC3 = [[TestViewController alloc]init];
    testVC3.view.backgroundColor = [UIColor redColor];
    
    TestViewController * testVC4 = [[TestViewController alloc]init];
    testVC4.view.backgroundColor = [UIColor blueColor];
    
    TestViewController * testVC5 = [[TestViewController alloc]init];
    testVC5.view.backgroundColor = [UIColor grayColor];
    
    TestViewController * testVC6 = [[TestViewController alloc]init];
    testVC6.view.backgroundColor = [UIColor greenColor];
    
    TestViewController * testVC11 = [[TestViewController alloc]init];
    testVC1.view.backgroundColor = [UIColor orangeColor];
    
    TestViewController * testVC21 = [[TestViewController alloc]init];
    testVC2.view.backgroundColor = [UIColor whiteColor];
    
    TestViewController * testVC31 = [[TestViewController alloc]init];
    testVC3.view.backgroundColor = [UIColor redColor];
    
    TestViewController * testVC41 = [[TestViewController alloc]init];
    testVC4.view.backgroundColor = [UIColor blueColor];
    
    TestViewController * testVC51 = [[TestViewController alloc]init];
    testVC5.view.backgroundColor = [UIColor grayColor];
    
    TestViewController * testVC61 = [[TestViewController alloc]init];
    testVC6.view.backgroundColor = [UIColor greenColor];
    
    TestViewController * testVC12 = [[TestViewController alloc]init];
    testVC1.view.backgroundColor = [UIColor orangeColor];
    
    TestViewController * testVC22 = [[TestViewController alloc]init];
    testVC2.view.backgroundColor = [UIColor whiteColor];
    
    TestViewController * testVC32 = [[TestViewController alloc]init];
    testVC3.view.backgroundColor = [UIColor redColor];
    
    TestViewController * testVC42 = [[TestViewController alloc]init];
    testVC4.view.backgroundColor = [UIColor blueColor];
    
    TestViewController * testVC52 = [[TestViewController alloc]init];
    testVC5.view.backgroundColor = [UIColor grayColor];
    
    TestViewController * testVC62 = [[TestViewController alloc]init];
    testVC6.view.backgroundColor = [UIColor greenColor];
    
    scrollerModel.titlesArr = @[@"开始",@"历史的",@"新",@"快乐的时",@"信息的地方",@"新闻时刻",@"大幅度",@"历轨迹",@"放大地方的",@"快乐的时刻",@"信息地方",@"时刻",@"开官方",@"历史的轨迹",@"新范德萨",@"快时刻",@"信息",@"新闻时刻放大"];
    scrollerModel.childVCArr = @[testVC1,testVC2,testVC3,testVC4,testVC5,testVC6,testVC11,testVC21,testVC31,testVC41,testVC51,testVC61,testVC12,testVC22,testVC32,testVC42,testVC52,testVC62];
    scrollerModel.lineType = BottomLineTypeScaling;
    scrollerModel.lineLength  = 5;
    scrollerModel.line_Scaling_colors = @[(id)[UIColor cyanColor].CGColor,(id)[UIColor redColor].CGColor,(id)[UIColor yellowColor].CGColor,(id)[UIColor greenColor].CGColor,(id)[UIColor orangeColor].CGColor,(id)[UIColor blueColor].CGColor,];
    
    self.scrollerModel = scrollerModel;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

