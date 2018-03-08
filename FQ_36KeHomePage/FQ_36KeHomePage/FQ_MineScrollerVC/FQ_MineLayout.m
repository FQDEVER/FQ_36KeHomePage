//
//  FQ_MineLayout.m
//  FQ_MineScrollerVC
//
//  Created by mac on 2017/9/5.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "FQ_MineLayout.h"

#define DefaultMargin 10
#define CollectionViewW  [UIScreen mainScreen].bounds.size.width - 2 * DefaultMargin
#define TextAddLenght 20

//static 只在当前作用域使用 const 不可修改的
static const UIEdgeInsets DefaultInsets={20,10,10,10};

@interface FQ_MineLayout ()

@property(nonatomic,strong)NSMutableArray *cellArr;

@property (assign, nonatomic) CGFloat tagW;

@property (assign, nonatomic) CGFloat sumY;

@end


@implementation FQ_MineLayout

- (void)prepareLayout{
    [super prepareLayout];
    
    [self.cellArr removeAllObjects];
    
    _tagW = 0;
    _sumY = DefaultInsets.top;
    
    NSInteger count=[self.collectionView numberOfItemsInSection:0];
    
    for (int i=0; i<count; i++) {
        
        NSIndexPath *indexPath=[NSIndexPath indexPathForItem:i inSection:0];
        
        UICollectionViewLayoutAttributes *attrs=[self layoutAttributesForItemAtIndexPath:indexPath];
        
        [self.cellArr addObject:attrs];
    }
    NSLog(@"====================移动");
}

-(void)setLenghts:(NSArray *)lenghts
{
    NSMutableArray * muArr = [NSMutableArray array];
    for (int i = 0; i < lenghts.count; i++) {
        [muArr addObject:@([lenghts[i] floatValue] + TextAddLenght)];
    }
    _lenghts = muArr.copy;
}

//也要更新这个长度的排列即可

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attr=[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat width= [self.lenghts[indexPath.row] floatValue];
    
    CGFloat height=30;
    CGFloat x = 0.0f;
    CGFloat y = _sumY;
    

    CGFloat sumW = _tagW + DefaultInsets.left + width + DefaultInsets.right;
    if (sumW > CollectionViewW) {
        _sumY += (30 + DefaultInsets.top);
        _tagW = width + DefaultInsets.left;
        x = DefaultInsets.left;
        y = _sumY;
    }else{
        x = _tagW + DefaultInsets.left;
        _tagW = _tagW + DefaultInsets.left + width;
    }
    
    attr.frame=CGRectMake(x, y, width, height);
    return attr;
}

#pragma mark -- 设置collectionView的范围 contentSize
- (CGSize)collectionViewContentSize{
    
    return CGSizeMake(0, _sumY + DefaultInsets.top + DefaultInsets.bottom + 30);
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    return self.cellArr;
}


- (NSMutableArray *)cellArr{
    if (!_cellArr) {
        _cellArr =[NSMutableArray array];
    }
    
    return _cellArr;
}


@end
