//
//  QFFDetailCell.h
//  CashierDeskIphone
//
//  Created by mac on 16/8/24.
//  Copyright © 2016年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QFFDetailCell : UITableViewCell

+ (instancetype)QFFDetailCellWithTableview:(UITableView *)tableview;

@property (nonatomic, weak) UILabel *nameLab;

@property (nonatomic, weak) UILabel *timeLab;

@property (nonatomic, weak) UILabel *countLab;

@property (nonatomic, weak) UILabel *productLab;

@property (nonatomic, weak) UILabel *jineLab;

@property (nonatomic, weak) UILabel *yuangongLab;

@property (nonatomic, weak) UILabel *statusLab;

@property (nonatomic, assign) CGFloat height;

@end
