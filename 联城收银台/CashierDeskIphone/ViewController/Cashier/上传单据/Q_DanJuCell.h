//
//  Q_DanJuCell.h
//  CashierDeskIphone
//
//  Created by mac on 2017/2/21.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Q_DanJuCell : UITableViewCell

+ (instancetype)Q_DanJuCellWithTableview:(UITableView *)tableview;

@property (nonatomic, weak) UILabel *titleLab;

@property (nonatomic, weak) UILabel *valueLab;

@property (nonatomic, assign) CGFloat height;

@end
