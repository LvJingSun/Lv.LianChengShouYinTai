//
//  FSB_DetailCell.h
//  CashierDeskIphone
//
//  Created by mac on 2017/7/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSB_DetailCell : UITableViewCell

+ (instancetype)FSB_DetailCellWithTableview:(UITableView *)tableview;

@property (nonatomic, weak) UILabel *titleLab;

@property (nonatomic, weak) UILabel *valueLab;

@property (nonatomic, assign) CGFloat height;

@end
