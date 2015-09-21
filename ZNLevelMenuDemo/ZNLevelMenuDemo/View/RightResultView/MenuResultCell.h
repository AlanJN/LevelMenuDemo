//
//  MenuResultCell.h
//  ZNLevelMenuDemo
//
//  Created by 李梓楠 on 15/9/19.
//  Copyright (c) 2015年 Alan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataModel,MenuResultCell;

@protocol MenuResultCellDelegate <NSObject>

- (void)tableViewCell:(MenuResultCell *)cell addButtonClick:(UIButton *)button;
@end

@interface MenuResultCell : UITableViewCell

@property (nonatomic ,strong) DataModel * cellData;
@property (nonatomic ,weak) id<MenuResultCellDelegate>delegate;

/**
 *  类方法 初始化Cell
 *
 *  @param tableView 列表
 *
 *  @return MenuResultCell
 */
+(instancetype)cellForTableView:(UITableView *)tableView;

@end
