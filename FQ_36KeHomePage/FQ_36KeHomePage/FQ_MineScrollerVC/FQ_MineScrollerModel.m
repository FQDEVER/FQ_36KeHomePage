//
//  FQ_MineScrollerModel.m
//  FQ_MineScrollerVC
//
//  Created by mac on 2017/7/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "FQ_MineScrollerModel.h"

@interface FQ_MineScrollerModel()

@end


@implementation FQ_MineScrollerModel

-(void)setTitlesArr:(NSArray *)titlesArr
{
    _titlesArr = titlesArr;
    
    NSMutableArray * titlesLength = [NSMutableArray array];
    
    //按钮宽度的计算方式
    NSInteger titleSizeW = 0;
    for (NSString * title in titlesArr) { //44就是顶部的高度
        CGFloat titleW = [title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, TitleViewH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:TitleViewFontSize]} context:nil].size.width;
        [titlesLength addObject:@(titleW)];
        titleSizeW += (titleW + TitleMargin);
    }
    self.titlesLength = titlesLength.copy;//这个是文字宽度
    self.titleContentSizeW = titleSizeW; //这个是按钮宽度
    
}

-(UIColor *)lineColor
{
    if (_lineColor) {
        return _lineColor;
    }
    if (_selectColor) {
        return _selectColor;
    }
    return [UIColor redColor];
}

-(UIColor *)selectColor
{
    if (_selectColor) {
        return _selectColor;
    }
    return [UIColor redColor];
}

-(UIColor *)defaultColor
{
    if (_defaultColor) {
        return _defaultColor;
    }
   return [UIColor darkTextColor];
}

-(NSArray *)line_Scaling_colors
{
    if ([_line_Scaling_colors.firstObject isKindOfClass:[UIColor class]]) {
        NSMutableArray * array = [NSMutableArray array];
        for (UIColor *color in _line_Scaling_colors) {
            [array addObject:(id)color.CGColor];
        }
        _line_Scaling_colors = array.copy;
        return array.copy;
    }
    
    if (_line_Scaling_colors) {
        return _line_Scaling_colors;
    }else{
        
        NSMutableArray * randomColors = [NSMutableArray array];
        for (int i = 0; i < self.titlesArr.count; i++) {
            [randomColors addObject:(id)RandomColor.CGColor];
        }
        return randomColors.copy;
    }
}

-(NSInteger)selectIndex
{
    if (_selectIndex && _selectIndex < self.titlesArr.count) {
       return  _selectIndex;
    }
    return 0;
}

@end
