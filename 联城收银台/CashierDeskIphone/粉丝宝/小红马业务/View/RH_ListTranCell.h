//
//  RH_ListTranCell.h
//  CashierDeskIphone
//
//  Created by mac on 2017/8/4.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RH_ListTranFrame;

@interface RH_ListTranCell : UITableViewCell

+ (instancetype)RH_ListTranCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) RH_ListTranFrame *frameModel;

@end
