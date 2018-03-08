//
//  FQ_DragCollectionView.h
//  FQ_DragView
//
//  Created by mac on 2017/12/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FQ_DragCollectionView : UICollectionView


@property (strong, nonatomic) NSMutableArray *dataSourceArr;


@property (copy, nonatomic) void(^moveItemEndBlock)(NSArray *dataArr);


@property (strong, nonatomic) NSArray *noShakingArr;


@end

