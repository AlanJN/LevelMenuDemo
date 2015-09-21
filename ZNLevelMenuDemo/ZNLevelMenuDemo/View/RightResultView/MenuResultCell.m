//
//  MenuResultCell.m
//  ZNLevelMenuDemo
//
//  Created by 李梓楠 on 15/9/19.
//  Copyright (c) 2015年 Alan. All rights reserved.
//

#import "MenuResultCell.h"
#import "DataModel.h"
#import "Header.h"

#define kCellWidth (kScreenWidth - 80)
static const CGFloat cellHeight = 130.f;

@interface MenuResultCell ()

@property (nonatomic ,strong) UIImageView * foodLogoImage;              //食物图片
@property (nonatomic ,strong) UILabel * foodTitleLabel;                 //食物名称
@property (nonatomic ,strong) UILabel * foodPriceLabel;                 //食物价格
@property (nonatomic ,strong) UILabel * salesNumberLabel;               //销量
@property (nonatomic ,strong) UILabel * currentNumberLabel;             //当前个数
@property (nonatomic ,strong) UIButton * addButton;                     //加号
@property (nonatomic ,strong) UIButton * minusButton;                   //减号

@end

@implementation MenuResultCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self initCellUI];
    }
    
    return self;
}

- (void)initCellUI{
    _foodLogoImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
    self.foodLogoImage.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.foodLogoImage];
    
    _foodTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.foodLogoImage.frame)+10, 15, kCellWidth-CGRectGetMaxX(self.foodLogoImage.frame)-20, 20)];
    self.foodTitleLabel.backgroundColor = [UIColor clearColor];
    self.foodTitleLabel.textColor = [UIColor blackColor];
    self.foodTitleLabel.font = [UIFont systemFontOfSize:14.f];
    [self.contentView addSubview:self.foodTitleLabel];
    
    _foodPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.foodLogoImage.frame)+30, 100, 20)];
    self.foodPriceLabel.backgroundColor = [UIColor clearColor];
    self.foodPriceLabel.textColor = [UIColor blackColor];
    self.foodPriceLabel.font = [UIFont systemFontOfSize:14.f];
    [self.contentView addSubview:self.foodPriceLabel];
    
    _salesNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(kCellWidth-150, CGRectGetMaxY(self.foodTitleLabel.frame)+5, 130, 20)];
    self.salesNumberLabel.textAlignment = NSTextAlignmentRight;
    self.salesNumberLabel.backgroundColor = [UIColor clearColor];
    self.salesNumberLabel.textColor = [UIColor blackColor];
    self.salesNumberLabel.font = [UIFont systemFontOfSize:12.f];
    [self.contentView addSubview:self.salesNumberLabel];
    
    _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addButton.frame = CGRectMake(kCellWidth-40, CGRectGetMaxY(self.foodLogoImage.frame)+25, 32, 32);
    [self.addButton setImage:[UIImage imageNamed:@"addImage"] forState:UIControlStateNormal];
    [self.addButton addTarget:self action:@selector(addFoodToCart:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.addButton];
    
    _currentNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.addButton.frame)-40, CGRectGetMinY(self.addButton.frame), 32, 32)];
    self.currentNumberLabel.textAlignment = NSTextAlignmentCenter;
    self.currentNumberLabel.backgroundColor = [UIColor clearColor];
    self.currentNumberLabel.textColor = [UIColor blackColor];
    self.currentNumberLabel.font = [UIFont systemFontOfSize:12.f];
    self.currentNumberLabel.text = @"0";
    [self.contentView addSubview:self.currentNumberLabel];
    
    _minusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.minusButton.frame = CGRectMake(CGRectGetMinX(self.currentNumberLabel.frame)-40, CGRectGetMinY(self.addButton.frame), 32, 32);
    [self.minusButton setImage:[UIImage imageNamed:@"minusImage"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.minusButton];
    
    
    //分割线
    UIView * dividingLine = [[UIView alloc] initWithFrame:CGRectMake(10, cellHeight-0.5, kCellWidth-20, 0.5)];
    dividingLine.backgroundColor = ColorRGBA(193, 193, 193, 1.f);
    [self.contentView addSubview:dividingLine];
}

#pragma mark - setter

- (void)setCellData:(DataModel *)cellData{
    _cellData = cellData;
    self.foodLogoImage.image = [UIImage imageNamed:_cellData.imageName];
    self.foodTitleLabel.text = _cellData.foodName;
    self.foodPriceLabel.text = [NSString stringWithFormat:@"￥%@",_cellData.foodPrice];
    if ([_cellData.salesNum integerValue] != 0) {
        self.salesNumberLabel.hidden = NO;
        self.salesNumberLabel.text = [NSString stringWithFormat:@"月售 %@ 份",_cellData.salesNum];
    }else{
        self.salesNumberLabel.hidden = YES;
    }
}

#pragma mark - 

- (void)addFoodToCart:(UIButton *)button{
    if ([_delegate respondsToSelector:@selector(tableViewCell:addButtonClick:)]) {
        [self.delegate tableViewCell:self addButtonClick:button];
    }
}

#pragma mark - Class Method

+(instancetype)cellForTableView:(UITableView *)tableView{
    
    static NSString * cellIdentifier = @"ResultIdentifier";
    MenuResultCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[MenuResultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

@end
