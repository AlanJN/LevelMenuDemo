//
//  ZNRightResultView.m
//  ZNLevelMenuDemo
//
//  Created by 李梓楠 on 15/9/19.
//  Copyright (c) 2015年 Alan. All rights reserved.
//

#import "ZNRightResultView.h"
#import "MenuResultCell.h"
#import "Header.h"

@interface ZNRightResultView ()<UITableViewDelegate,UITableViewDataSource,MenuResultCellDelegate>

@end

@implementation ZNRightResultView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    self = [super initWithFrame:frame style:style];
    
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = ColorRGBA(246, 246, 246, 1.f);
        [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        self.showsVerticalScrollIndicator = NO;
    }
    
    return self;
}


#pragma mark - setter

- (void)setFoodsArray:(NSArray *)foodsArray {
    _foodsArray = foodsArray;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.foodsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MenuResultCell * cell = [MenuResultCell cellForTableView:tableView];
    cell.cellData = self.foodsArray[indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark - UITableViewDelegate

#pragma mark - MenuResultCellDelegate

- (void)tableViewCell:(MenuResultCell *)cell addButtonClick:(UIButton *)button{
    if ([_foodViewDelegate respondsToSelector:@selector(foodCell:addFood:)]) {
        [self.foodViewDelegate foodCell:cell addFood:button];
    }
    
}


@end
