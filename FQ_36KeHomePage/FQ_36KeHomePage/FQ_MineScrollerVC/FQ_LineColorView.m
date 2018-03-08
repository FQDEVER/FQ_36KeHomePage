//
//  FQ_LineColorView.m
//  FQ_MineScrollerVC
//
//  Created by mac on 2017/7/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "FQ_LineColorView.h"
#define  M_ScreenW CGRectGetWidth(self.bounds)
#define M_ScreenH CGRectGetHeight(self.bounds)
#define ScreenW  M_ScreenW
#define ScreenH [UIScreen mainScreen].bounds.size.height

@interface FQ_LineColorView ()

@property (nonatomic, strong) CAShapeLayer * lineLayer;

@property (nonatomic, strong) UIBezierPath *path;

@property (nonatomic, strong) CAGradientLayer *leftColor;

@end

@implementation FQ_LineColorView

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
-(instancetype)initWithFrame:(CGRect)frame StartPoint:(CGPoint)startPoint startLength:(CGFloat)startLength endPoint:(CGPoint)endPoint endLength:(CGFloat)endLength Colors:(NSArray *)colors locations:(NSArray *)locations
{
    if (self = [super initWithFrame:frame]) {
        [self setupStartPoint:startPoint startLength:startLength];
        
        self.leftColor.colors = colors;
        self.leftColor.locations = locations;
        [self setShapeLayerWithStartPoint:startPoint startLength:startLength endPoint:startPoint endLength:startLength andProgress:0.0f];
        
    }
    return self;
}




/**
 初始化控件

 @param startPoint 起始中心点
 @param startLegth 起始线长
 */
-(void)setupStartPoint:(CGPoint)startPoint startLength:(CGFloat)startLegth
{
    CAGradientLayer * leftColor = [CAGradientLayer layer];
    
    leftColor.frame = CGRectMake(0, 0, ScreenW, M_ScreenH);
    leftColor.startPoint = CGPointMake(0,1);
    leftColor.endPoint = CGPointMake(1,1);
    self.leftColor = leftColor;
    
    [self.layer addSublayer:leftColor];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [self.path moveToPoint:CGPointMake(startPoint.x - startLegth *0.5, M_ScreenH * 0.5)];
    [self.path addLineToPoint:CGPointMake(startPoint.x + startLegth * 0.5,M_ScreenH * 0.5)];
    self.path = path;
    
    CAShapeLayer * lineLayer = [CAShapeLayer layer];
    lineLayer.frame = CGRectMake(0,0, M_ScreenW, M_ScreenH);
    lineLayer.lineWidth = 10.0f;
    lineLayer.path = path.CGPath;
    lineLayer.lineCap = kCALineCapRound;
    self.lineLayer = lineLayer;
    self.layer.mask = lineLayer;
    lineLayer.fillColor = [UIColor clearColor].CGColor; // 填充色为透明（不设置为黑色）
    lineLayer.strokeColor = [UIColor blackColor].CGColor; // 随便设置一个边框颜色
    
}

/**
 通过起始点和结束点.还有线条的长度以及当前进度来做处理
 
 @param startPoint 起始中心点
 @param startLength 起始线长
 @param endPoint 结束时中心点
 @param endLength 结束线长
 @param progress 起始与结束的进度
 */
-(void)setShapeLayerWithStartPoint:(CGPoint)startPoint startLength:(CGFloat)startLength endPoint:(CGPoint)endPoint endLength:(CGFloat)endLength andProgress:(CGFloat)progress
{
    [self.path removeAllPoints];

    CGFloat lineMargin = endPoint.x - startPoint.x - startLength *0.5 - endLength * 0.5;
    if (progress < 0.5) {
        [self.path moveToPoint:CGPointMake(startPoint.x - startLength * 0.5, M_ScreenH * 0.5)];
        [self.path addLineToPoint:CGPointMake(startPoint.x + startLength * 0.5 +(lineMargin + endLength) * progress * 2.0 , M_ScreenH * 0.5)];
    }else{
        [self.path moveToPoint:CGPointMake(startPoint.x - startLength * 0.5 +(startLength + lineMargin) * (progress - 0.5) * 2.0 , M_ScreenH * 0.5)];
        [self.path addLineToPoint:CGPointMake(endPoint.x +endLength *0.5, M_ScreenH * 0.5)];
    }
    self.lineLayer.path = self.path.CGPath;
}

@end
