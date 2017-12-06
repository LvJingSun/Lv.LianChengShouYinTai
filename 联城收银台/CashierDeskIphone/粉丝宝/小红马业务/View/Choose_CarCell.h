//
//  Choose_CarCell.h
//  CashierDeskIphone
//
//  Created by mac on 2017/8/2.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Choose_CarFrame;

@interface Choose_CarCell : UITableViewCell

+ (instancetype)Choose_CarCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) Choose_CarFrame *frameModel;

@end
