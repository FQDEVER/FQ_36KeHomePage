//
//  FQ_MineTagCell.m
//  FQ_MineScrollerVC
//
//  Created by mac on 2017/9/4.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "FQ_MineTagCell.h"
#import "FQ_MineModel.h"

@interface FQ_MineTagCell()

@property (strong, nonatomic) UILabel *tagLabel;

@end

@implementation FQ_MineTagCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.tagLabel = [[UILabel alloc]initWithFrame:self.bounds];
        self.tagLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.tagLabel];
        self.tagLabel.layer.masksToBounds = YES;
        self.tagLabel.layer.cornerRadius = 13.0f;
        self.tagLabel.font = [UIFont systemFontOfSize:13];
        self.tagLabel.textColor = [UIColor blackColor];
        self.tagLabel.backgroundColor = [UIColor lightTextColor];
    }
    return self;
}

-(void)setMineModel:(FQ_MineModel *)mineModel
{
    _mineModel = mineModel;
    self.tagLabel.text = mineModel.titleStr;
    self.tagLabel.textColor = mineModel.isSelect ? [UIColor redColor] : [UIColor blackColor];
    self.tagLabel.backgroundColor = mineModel.isMoveing ? [UIColor lightTextColor] : [UIColor clearColor];
//    self.userInteractionEnabled = mineModel.isMoveing;
    
}


@end
