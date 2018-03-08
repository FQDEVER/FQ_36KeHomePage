//
//  FQ_DragSortView.h
//  FQ_MineScrollerVC
//
//  Created by mac on 2017/9/4.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FQ_DragCollectionView.h"
#define SJScreenH [UIScreen mainScreen].bounds.size.height
#define SJScrrenW [UIScreen mainScreen].bounds.size.width
#define TitleViewH 44

@interface FQ_DragSortView : UIView

//回调序号还是什么?
@property (copy, nonatomic) void(^dragViewBlock)(NSArray * modes);

//这个view添加一个数组.昵称数组
@property (strong, nonatomic)  NSMutableArray *modes;

@property (strong, nonatomic) NSMutableArray *lenghts;

//选中的索引
@property (assign, nonatomic) NSInteger selectIndex;

//显示
-(void)showWithSelectIndex:(NSIndexPath *)index;

//隐藏
-(void)dismiss;

@end
