//
//  FQ_MineModel.h
//  FQ_MineScrollerVC
//
//  Created by mac on 2017/9/5.
//  Copyright © 2017年 mac. All rights reserved.
//

//设定一个单例.专门管理所有的标签处理

#import <Foundation/Foundation.h>

@interface FQ_MineModel : NSObject

//标题文本
@property (copy, nonatomic) NSString *titleStr;

//是否选中
@property (assign, nonatomic) BOOL isSelect;

//能否移动
@property (assign, nonatomic) BOOL isMoveing;


@end
