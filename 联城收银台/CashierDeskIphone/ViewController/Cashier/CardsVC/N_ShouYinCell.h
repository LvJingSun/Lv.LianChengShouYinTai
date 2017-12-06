//
//  N_ShouYinCell.h
//  CashierDeskIphone
//
//  Created by mac on 2017/10/18.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class N_ShouYinFrame;

@interface N_ShouYinCell : UITableViewCell

+ (instancetype)N_ShouYinCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) N_ShouYinFrame *frameModel;

@end
