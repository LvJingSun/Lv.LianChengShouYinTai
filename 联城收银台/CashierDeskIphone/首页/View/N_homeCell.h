//
//  N_homeCell.h
//  CashierDeskIphone
//
//  Created by mac on 2017/3/8.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface N_homeCell : UITableViewCell

+ (instancetype)N_homeCellWithTableview:(UITableView *)tableview;

@property (nonatomic, weak) UIButton *button;

@property (nonatomic, assign) CGFloat height;

@end
