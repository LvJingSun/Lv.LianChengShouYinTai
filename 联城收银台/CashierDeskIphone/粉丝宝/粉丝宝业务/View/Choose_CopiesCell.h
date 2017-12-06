//
//  Choose_CopiesCell.h
//  CashierDeskIphone
//
//  Created by mac on 2017/6/17.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Choose_CopiesFrame;

@interface Choose_CopiesCell : UITableViewCell

+ (instancetype)Choose_CopiesCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) Choose_CopiesFrame *frameModel;

@end
