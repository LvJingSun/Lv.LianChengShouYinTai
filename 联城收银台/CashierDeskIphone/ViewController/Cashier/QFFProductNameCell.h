//
//  QFFProductNameCell.h
//  CashierDeskIphone
//
//  Created by mac on 2016/11/1.
//  Copyright © 2016年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QFFProductNameCell : UITableViewCell

@property (nonatomic, weak) UILabel *titleLab;

@property (nonatomic, weak) UITextField *valueField;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, weak) UIButton *nameBtn;

@end
