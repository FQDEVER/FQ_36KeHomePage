//
//  FQ_DragCollectionView.m
//  FQ_DragView
//
//  Created by mac on 2017/12/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "FQ_DragCollectionView.h"

#define angelToRandian(x)  ((x)/180.0*M_PI)
#define ScreenH [UIScreen mainScreen].bounds.size.height
#define ScreenW [UIScreen mainScreen].bounds.size.width

typedef NS_ENUM(NSInteger, FQ_DragCollectionViewScrollDirectionType){
    FQ_DragCollectionViewScrollDirectionType_Top,
    FQ_DragCollectionViewScrollDirectionType_Bottom,
    FQ_DragCollectionViewScrollDirectionType_Left,
    FQ_DragCollectionViewScrollDirectionType_Right,
    FQ_DragCollectionViewScrollDirectionType_None,
};



@interface FQ_DragCollectionView()

//临时移动的cell.
@property (strong, nonatomic) UIView *tempCellView;
@property (strong, nonatomic) UICollectionViewCell * selectCell;
@property (assign, nonatomic) UICollectionViewScrollDirection scrollDirection;
@property (nonatomic,strong)NSMutableArray *cellAttributesArray;
//开启一个滚动定时器
@property (strong, nonatomic) CADisplayLink *edgeTimer; //开启一个定时器
@property (strong, nonatomic) NSIndexPath *currentIndex;


@end

@implementation FQ_DragCollectionView

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        //添加长按手势
        [self addGesture];
        
        //获取当前layout的方向
        UICollectionViewFlowLayout *currentLayout = (UICollectionViewFlowLayout*)layout;
        self.scrollDirection = currentLayout.scrollDirection;
    }
    return self;
}


//添加手势
-(void)addGesture{
    UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressGestureAction:)];
    longPress.minimumPressDuration = 0.5f;
    [self addGestureRecognizer:longPress];
}

-(void)longPressGestureAction:(UILongPressGestureRecognizer *)longPressGesture
{
    switch (longPressGesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            [self longPressBeganed:longPressGesture];
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            [self longPressChanged:longPressGesture];
            break;
        }
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
        {
            [self longPressEnded:longPressGesture];
            break;
        }
        default:
            break;
    }
}


//长按手势开始
-(void)longPressBeganed:(UILongPressGestureRecognizer *)longPressGesture
{
    //查看那些是不需要长按的手势
    CGPoint gesturePoint = [longPressGesture locationInView:self];
    NSIndexPath * selectIndex = [self indexPathForItemAtPoint:gesturePoint];
    if (self.noShakingArr.count && [self.noShakingArr containsObject:selectIndex]) {
        return;
    }
    
    //手势开始需要做的是.获取当前cell.并且添加一个一样的cellview.隐藏原cell.并且让其他所有cell摇晃
    [self.cellAttributesArray removeAllObjects];
    for (int i = 0; i < self.dataSourceArr.count; i++) {
        [self.cellAttributesArray addObject:[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]]];
    }
    //开启定时器
    [self startEdgeTimer];
    UICollectionViewCell * cell = [self cellForItemAtIndexPath:selectIndex];
    self.selectCell  = cell;
    //开启图形上下文.获取tempCellView
    UIView * tempCellView = [[UIView alloc]initWithFrame:cell.frame];
    UIGraphicsBeginImageContext(cell.frame.size);
    [cell.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *tempImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    tempCellView.layer.contents = (id)tempImg.CGImage;
    self.tempCellView = tempCellView;
    //隐藏源cell
    cell.hidden = YES;
    [self addSubview:tempCellView];
    //让其他所有的cell全部摇晃起来
    [self startShakeAllCell];
}

//长按手势正在移动
-(void)longPressChanged:(UILongPressGestureRecognizer *)longPressGesture
{
    //关键一步就是这里了
    CGPoint currentPoint = [longPressGesture locationInView:self];
    self.tempCellView.center = currentPoint;
    
    //根据当前的位置获取该位置的index
    NSIndexPath * currentIndex = [self indexPathForItemAtPoint:currentPoint];
    NSIndexPath * selectIndex  = [self indexPathForCell:self.selectCell];
    
    BOOL isContainsPoint = NO;
    for (UICollectionViewLayoutAttributes *attributes in self.cellAttributesArray) {
        if (CGRectContainsPoint(attributes.frame, currentPoint) && selectIndex != attributes.indexPath && ![self.noShakingArr containsObject:attributes.indexPath]) {
            isContainsPoint = YES;
        }
    }
    if (isContainsPoint) {
        id selectData = self.dataSourceArr[selectIndex.row];
        [self.dataSourceArr removeObjectAtIndex:selectIndex.row];
        [self.dataSourceArr insertObject:selectData atIndex:currentIndex.row];
        [self moveItemAtIndexPath:selectIndex toIndexPath:currentIndex];
        self.currentIndex = currentIndex;
    }
    
}

- (void)startEdgeTimer{
    if (!_edgeTimer) {
        _edgeTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(getScrollDirectionTypeWithCurrentPoint)];
        [_edgeTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
}

- (void)stopEdgeTimer{
    if (_edgeTimer) {
        [_edgeTimer invalidate];
        _edgeTimer = nil;
    }
}


-(void)getScrollDirectionTypeWithCurrentPoint{
    
    if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) { //水平方向
        
        if (self.tempCellView.frame.origin.x < self.contentOffset.x && self.tempCellView.frame.origin.x >= 0) {//一旦小于零
            //向左
            self.contentOffset = CGPointMake(self.contentOffset.x - 4, 0);
            self.tempCellView.center = CGPointMake(self.tempCellView.center.x - 4, self.tempCellView.center.y);
            
        }else if(self.tempCellView.frame.origin.x > self.contentOffset.x + ScreenW - self.selectCell.frame.size.width && self.contentOffset.x + ScreenW < self.contentSize.width){
            //向右
            self.contentOffset = CGPointMake(self.contentOffset.x + 4, 0);
            self.tempCellView.center = CGPointMake(self.tempCellView.center.x + 4, self.tempCellView.center.y);
        }
    }else{ //竖直方向
        
        if (self.tempCellView.frame.origin.y < self.contentOffset.y && self.tempCellView.frame.origin.y >= 0) {//一旦小于零
            //向上
            self.contentOffset = CGPointMake(0, self.contentOffset.y - 4);
            self.tempCellView.center = CGPointMake(self.tempCellView.center.x, self.tempCellView.center.y-4);
        }else if(self.tempCellView.frame.origin.y > self.contentOffset.y + ScreenH-self.selectCell.frame.size.height && self.contentOffset.y + ScreenH < self.contentSize.height){
            //向下
            self.contentOffset = CGPointMake(0, self.contentOffset.y + 4);
            self.tempCellView.center = CGPointMake(self.tempCellView.center.x, self.tempCellView.center.y+4);
        }
    }
    //并且让显示出来的进行动画
    [self startShakeAllCell];
}


//长按手势结束
-(void)longPressEnded:(UILongPressGestureRecognizer *)longPressGesture
{
    [UIView animateWithDuration:0.2f animations:^{
        self.tempCellView.center = self.selectCell.center;
    } completion:^(BOOL finished) {
        self.tempCellView.alpha =0;
        self.selectCell.hidden = NO;
        [self endShakeAllCell];
        [self stopEdgeTimer];
        [self.tempCellView removeFromSuperview];
        self.tempCellView = nil;
        if (_moveItemEndBlock) {
            _moveItemEndBlock(self.dataSourceArr);
        }
    }];
}


-(void)startShakeAllCell
{
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.rotation";
    animation.values = @[@((-4)/180.0*M_PI),@(4/180.0*M_PI),@((-4)/180.0*M_PI)];
    animation.duration = 0.2;
    animation.repeatCount = MAXFLOAT;
    for (UICollectionViewCell * cell in self.visibleCells) {
        NSIndexPath * cellIndex = [self indexPathForCell:cell];
        if (![self.noShakingArr containsObject:cellIndex]) {
            if (![cell.layer animationForKey:@"shake"]) {
                [cell.layer addAnimation:animation forKey:@"shake"];
            }
        }
    }
}

-(void)endShakeAllCell{
    
    for (UICollectionViewCell * cell in self.visibleCells) {
        if ([cell.layer animationForKey:@"shake"]) {
            [cell.layer removeAnimationForKey:@"shake"];
        }
    }
}

- (NSMutableArray *)cellAttributesArray {
    if(_cellAttributesArray == nil) {
        _cellAttributesArray = [[NSMutableArray alloc] init];
    }
    return _cellAttributesArray;
}

@end

