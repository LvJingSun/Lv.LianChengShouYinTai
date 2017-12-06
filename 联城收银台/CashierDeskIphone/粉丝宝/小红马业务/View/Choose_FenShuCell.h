//
//  Choose_FenShuCell.h
//  CashierDeskIphone
//
//  Created by mac on 2017/8/2.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Choose_FenShuFrame;

@interface Choose_FenShuCell : UITableViewCell

+ (instancetype)Choose_FenShuCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) Choose_FenShuFrame *frameModel;

@end
