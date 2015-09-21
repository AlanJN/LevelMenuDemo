//
//  MenuNavCell.h
//  ZNLevelMenuDemo
//
//  Created by 李梓楠 on 15/9/19.
//  Copyright (c) 2015年 Alan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuNavCell : UITableViewCell

@property (nonatomic ,strong) UILabel * titleLabel;                 //标题
@property (nonatomic ,strong) UIView * selectedView;                //选中cell后 左侧2像素的选中背景

/**
 *  类方法 初始化Cell
 *
 *  @param tableView 列表
 *
 *  @return MenuNavCell
 */

+(instancetype)cellForTableView:(UITableView *)tableView;

@end
