//
//  Choose_StaffCell.h
//  CashierDeskIphone
//
//  Created by mac on 2017/6/17.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Choose_StaffFrame;

@interface Choose_StaffCell : UITableViewCell

+ (instancetype)Choose_StaffCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) Choose_StaffFrame *frameModel;

@end
