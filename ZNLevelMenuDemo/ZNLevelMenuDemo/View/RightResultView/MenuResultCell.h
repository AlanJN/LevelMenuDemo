//
//  MenuResultCell.h
//  ZNLevelMenuDemo
//
//  Created by 李梓楠 on 15/9/19.
//  Copyright (c) 2015年 Alan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataModel,MenuResultCell;

typedef NS_ENUM(NSInteger, FoodStatus){
    FoodStatusAdd = 1,
    FoodStatusMinus = 2,
};

@protocol MenuResultCellDelegate <NSObject>

@end

@interface MenuResultCell : UITableViewCell

@property (nonatomic ,strong) DataModel * cellData;
@property (nonatomic ,weak) id<MenuResultCellDelegate>delegate;
@property (nonatomic ,copy) void (^ChangeFoodBlock)(DataModel * model,UIButton * button,FoodStatus status);

/**
 *  类方法 初始化Cell
 *
 *  @param tableView 列表
 *
 *  @return MenuResultCell
 */
+(instancetype)cellForTableView:(UITableView *)tableView;

@end
