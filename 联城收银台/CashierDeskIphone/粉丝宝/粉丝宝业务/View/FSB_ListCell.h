//
//  FSB_ListCell.h
//  CashierDeskIphone
//
//  Created by mac on 2017/7/5.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FSB_ListFrame;

@interface FSB_ListCell : UITableViewCell

+ (instancetype)FSB_ListCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) FSB_ListFrame *frameModel;

@end
