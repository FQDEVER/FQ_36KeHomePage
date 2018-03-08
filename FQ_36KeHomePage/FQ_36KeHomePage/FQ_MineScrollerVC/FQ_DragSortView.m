//
//  FQ_DragSortView.m
//  FQ_MineScrollerVC
//
//  Created by mac on 2017/9/4.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "FQ_DragSortView.h"
#import "FQ_MineTagCell.h"
#import "FQ_MineModel.h"
#import "FQ_MineLayout.h"

static NSString *IdentifierStr = @"TestCollectionView";

@interface FQ_DragSortView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) UIVisualEffectView *bottomView;

@property (strong, nonatomic) FQ_DragCollectionView *collectionView;

@property (strong, nonatomic) FQ_MineLayout *layout;


@end


@implementation FQ_DragSortView

-(instancetype)init
{
    if (self = [super init]) {
        //初始化界面
        [self creatUI];
    }
    return self;
}


-(void)creatUI
{
    //分为两个部分.一个是向下滑动.一个是隐出
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SJScrrenW, TitleViewH)];
    topView.backgroundColor = [UIColor whiteColor];
    
    //添加按钮
    UIButton * clearBtn = [[UIButton alloc]initWithFrame:CGRectMake(SJScrrenW - 45, 0, 45, TitleViewH)];
    clearBtn.backgroundColor = [UIColor clearColor];
    [clearBtn setImage:[UIImage imageNamed:@"错号"] forState:UIControlStateNormal];
    [clearBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:clearBtn];
    [self addSubview:topView];

    //下面一部分做各个标题的修改.开始设定为
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView * effectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
    effectView.frame = CGRectMake(0, TitleViewH, SJScrrenW, 0);
    [self insertSubview:effectView belowSubview:topView];
    self.bottomView = effectView;

}

-(void)setLenghts:(NSMutableArray *)lenghts
{
    _lenghts = lenghts;
    [self.bottomView.contentView addSubview:self.collectionView];
}

-(void)setModes:(NSMutableArray *)modes
{
    _modes = modes;
    self.collectionView.dataSourceArr = modes;
    [self.collectionView reloadData];
}

-(void)dismiss
{
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.bottomView.frame = CGRectMake(0, TitleViewH, self.bounds.size.height, 0);
        self.alpha = 0.0f;
    } completion:nil];

}

-(void)showWithSelectIndex:(NSIndexPath *)index
{
    
    [self.collectionView reloadItemsAtIndexPaths:@[index]];
    self.alpha = 0.0f;
    CGFloat bottomH = self.bounds.size.height - TitleViewH;

    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.bottomView.frame = CGRectMake(0, TitleViewH, self.bounds.size.width, bottomH);
        self.alpha = 1.0f;
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark ============ UICollectionView代理 ==============


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  self.modes.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FQ_MineTagCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:IdentifierStr forIndexPath:indexPath];
    cell.mineModel = self.modes[indexPath.row];
    return cell;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(20, 10, 20, 10);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    FQ_MineModel * mineModel = self.modes[indexPath.row];
    mineModel.isSelect = YES;
    FQ_MineModel*oldModel = self.modes[self.selectIndex];
    oldModel.isSelect = NO;
    self.selectIndex = indexPath.row;
    [collectionView reloadData];
    if (_dragViewBlock) {
        _dragViewBlock(self.modes.copy);
    }
}

-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumLineSpacing = 15;
        flowLayout.minimumInteritemSpacing = 5;
        flowLayout.itemSize = CGSizeMake(SJScrrenW * 0.3, 35);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[FQ_DragCollectionView alloc] initWithFrame:CGRectMake(0, 0, SJScrrenW, self.bounds.size.height - TitleViewH) collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.dataSourceArr = self.modes;
        _collectionView.noShakingArr = @[[NSIndexPath indexPathForRow:0 inSection:0],[NSIndexPath indexPathForRow:1 inSection:0]];
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[FQ_MineTagCell class] forCellWithReuseIdentifier:IdentifierStr];
        __weak typeof(self)weakSelf = self;
        _collectionView.moveItemEndBlock = ^(NSArray *dataArr) {
            weakSelf.modes = [NSMutableArray arrayWithArray:dataArr];
            //移动结束.获取最新的选中索引.并且返回
            [weakSelf.collectionView reloadData];
            
            //回调最新的选中索引
            [weakSelf updateCurrentIndex];
        };
    }
    return _collectionView;
}

//更新索引.
-(void)updateCurrentIndex{
    if (_dragViewBlock) {
        _dragViewBlock(self.modes.copy);
    }
}


@end
