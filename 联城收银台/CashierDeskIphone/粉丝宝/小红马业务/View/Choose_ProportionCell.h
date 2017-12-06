//
//  Choose_ProportionCell.h
//  CashierDeskIphone
//
//  Created by mac on 2017/8/2.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Choose_ProportionFrame;

@interface Choose_ProportionCell : UITableViewCell

+ (instancetype)Choose_ProportionCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) Choose_ProportionFrame *frameModel;

@end
