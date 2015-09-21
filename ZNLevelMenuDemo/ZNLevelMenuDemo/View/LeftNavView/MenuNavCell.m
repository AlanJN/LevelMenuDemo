//
//  MenuNavCell.m
//  ZNLevelMenuDemo
//
//  Created by 李梓楠 on 15/9/19.
//  Copyright (c) 2015年 Alan. All rights reserved.
//

#import "MenuNavCell.h"
#import "Header.h"

@implementation MenuNavCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = ColorRGBA(236, 236, 236, 1.f);
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 50)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.font = [UIFont systemFontOfSize:16.f];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.titleLabel];
        
        _selectedView = [[UIView alloc]initWithFrame:(CGRect){0,0,2,50}];
        self.selectedView.backgroundColor = [UIColor redColor];
        self.selectedView.hidden = YES;
        [self.contentView addSubview:self.selectedView];
    }
    return self;
}

+(instancetype)cellForTableView:(UITableView *)tableView{

    static NSString * cellIdentifier = @"NavIdentifier";
    MenuNavCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[MenuNavCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

@end
