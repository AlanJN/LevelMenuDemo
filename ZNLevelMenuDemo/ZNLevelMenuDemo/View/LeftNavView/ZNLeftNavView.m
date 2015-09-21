//
//  ZNLeftNavView.m
//  ZNLevelMenuDemo
//
//  Created by 李梓楠 on 15/9/19.
//  Copyright (c) 2015年 Alan. All rights reserved.
//

#import "ZNLeftNavView.h"
#import "MenuNavCell.h"
#import "Header.h"

@interface ZNLeftNavView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) NSIndexPath * lastIndexPath;              //记录上一个选中的Cell
@property (nonatomic) BOOL isSelected;
@end

@implementation ZNLeftNavView

- (id) initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    self = [super initWithFrame:frame style:style];
    
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = ColorRGBA(246, 246, 246, 1.f);
        self.showsVerticalScrollIndicator = NO;
        //分割线左对齐
        if (IOS7) {
            if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
                [self setSeparatorInset:UIEdgeInsetsZero];
            }
            if ([self respondsToSelector:@selector(setLayoutMargins:)])  {
                [self setLayoutMargins:UIEdgeInsetsZero];
            }
        }
    }
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    if(!_isSelected)
    {
        NSInteger selectedIndex = 0;
        NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
        [self tableView:self didSelectRowAtIndexPath:selectedIndexPath];
        _isSelected=YES;
    }
}

#pragma mark - setter

- (void)setMenuArray:(NSArray *)menuArray{
    _menuArray = menuArray;
}

#pragma mark - UITableViewDataSource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.menuArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MenuNavCell * cell = [MenuNavCell cellForTableView:tableView];
    
    cell.titleLabel.text = self.menuArray[indexPath.row][@"navName"];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_lastIndexPath != nil) {
        MenuNavCell *cell = (MenuNavCell *)[tableView cellForRowAtIndexPath:_lastIndexPath];
        cell.backgroundColor = ColorRGBA(236, 236, 236, 1.f);
        cell.titleLabel.textColor = [UIColor blackColor];
        cell.selectedView.hidden = YES;
    }
    
    //当点击的index 与保存的 index不相等时候 则执行下面代理
    if (self.lastIndexPath != indexPath) {
        if ([_leftNavDelegate respondsToSelector:@selector(navMenuClickIndexPathRow:lastIndexPath:currentIndexPath:)])
        {
            [self.leftNavDelegate navMenuClickIndexPathRow:self.menuArray[indexPath.row][@"foods"] lastIndexPath:self.lastIndexPath currentIndexPath:indexPath];
        }
    }
    
    //恢复原状态
    MenuNavCell *cell = (MenuNavCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.titleLabel.textColor = [UIColor redColor];
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectedView.hidden = NO;
    _lastIndexPath = indexPath;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if (IOS7) {
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
    }
}

@end
