//
//  InPutCell.h
//  CashierDeskIphone
//
//  Created by mac on 2016/11/2.
//  Copyright © 2016年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InPutCell : UITableViewCell

+ (instancetype)InPutCellWithTableview:(UITableView *)tableview;

@property (nonatomic, weak) UILabel *titleLab;

@property (nonatomic, assign) CGFloat height;

@end
