//
//  FSB_DetailImgCell.h
//  CashierDeskIphone
//
//  Created by mac on 2017/7/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSB_DetailImgCell : UITableViewCell

+ (instancetype)FSB_DetailImgCellWithTableview:(UITableView *)tableview;

@property (nonatomic, weak) UIImageView *iconImg;

@property (nonatomic, weak) UILabel *titleLab;

@property (nonatomic, assign) CGFloat height;

@end
