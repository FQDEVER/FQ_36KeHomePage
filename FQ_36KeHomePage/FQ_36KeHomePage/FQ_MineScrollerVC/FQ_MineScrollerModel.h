//
//  FQ_MineScrollerModel.h
//  FQ_MineScrollerVC
//
//  Created by mac on 2017/7/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#define TitleMargin 40
#define TitleViewH 44
#define TitleViewFontSize 15

#define R  (arc4random() % 256)
#define RandomColor [UIColor colorWithRed:R/255.0 green:R/255.0 blue:R/255.0 alpha:1]


typedef enum : NSInteger{
    BottomLineTypeNone, //无下划线
    BottomLineTypeDefault = 0, //默认
    BottomLineTypeScaling, //拉伸
}BottomLineType;


@interface FQ_MineScrollerModel : NSObject

//标题数组
@property (strong, nonatomic) NSArray *titlesArr;

//子控制器数组
@property (strong, nonatomic) NSArray *childVCArr;

//下划线样式.默认:BottomLineTypeDefault
@property (assign, nonatomic) BottomLineType lineType;

//titleView默认颜色
@property (strong, nonatomic) UIColor *defaultColor;

//titleView选中颜色
@property (strong, nonatomic) UIColor *selectColor;

//普通下滑线的颜色
@property (strong, nonatomic) UIColor *lineColor;

//下滑线使用Scaling拉伸样式.渐变颜色.CGColor.或者UIColor对象.不设置则使用随机色
@property (strong, nonatomic) NSArray *line_Scaling_colors;

//使用拉伸时可设置线长.默认为0.随文字长度变化!一旦设置所有下划线长度均固定
@property (assign, nonatomic) CGFloat lineLength;

//titleView选中的索引
@property (assign, nonatomic) NSInteger selectIndex;

//计算属性.获取titlesLength的长度
@property (strong, nonatomic) NSArray *titlesLength;

//获取总的titleViewContentSize
@property (assign, nonatomic) NSInteger titleContentSizeW;

@end
