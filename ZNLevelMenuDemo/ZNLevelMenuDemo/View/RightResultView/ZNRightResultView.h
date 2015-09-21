//
//  ZNRightResultView.h
//  ZNLevelMenuDemo
//
//  Created by 李梓楠 on 15/9/19.
//  Copyright (c) 2015年 Alan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuResultCell.h"

@class DataModel;

@protocol ZNRightResultViewDelegate <NSObject>

/**
 *  增删食物数量
 *
 *  @param model  食物Model
 *  @param button 增减按钮
 */
- (void)foodCellChangeFoodModel:(DataModel *) model button:(UIButton *)button changeStatus:(FoodStatus)status;
@end

@interface ZNRightResultView : UITableView

@property (nonatomic ,strong) NSArray * foodsArray;
@property (nonatomic ,weak) id<ZNRightResultViewDelegate>foodViewDelegate;
@end
