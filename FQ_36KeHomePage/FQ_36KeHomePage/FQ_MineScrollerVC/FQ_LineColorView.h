//
//  FQ_LineColorView.h
//  FQ_MineScrollerVC
//
//  Created by mac on 2017/7/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FQ_LineColorView : UIView


/**
 初始化拉伸下划线

 @param frame frame
 @param startPoint 起始中心点
 @param startLength 起始线长
 @param endPoint 结束时中心点
 @param endLength 结束线长
 @param colors 颜色数组
 @return lineColorView对象
 */
-(instancetype)initWithFrame:(CGRect)frame StartPoint:(CGPoint)startPoint startLength:(CGFloat)startLength endPoint:(CGPoint)endPoint endLength:(CGFloat)endLength Colors:(NSArray *)colors locations:(NSArray *)locations;

/**
 通过起始点和结束点.还有线条的长度以及当前进度来做处理

 @param startPoint 起始中心点
 @param startLength 起始线长
 @param endPoint 结束时中心点
 @param endLength 结束线长
 @param progress 起始与结束的进度
 */
-(void)setShapeLayerWithStartPoint:(CGPoint)startPoint startLength:(CGFloat)startLength endPoint:(CGPoint)endPoint endLength:(CGFloat)endLength andProgress:(CGFloat)progress;

@end
