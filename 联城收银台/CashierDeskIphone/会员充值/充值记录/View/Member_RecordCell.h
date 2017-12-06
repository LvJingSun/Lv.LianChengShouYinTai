//
//  Member_RecordCell.h
//  CashierDeskIphone
//
//  Created by mac on 2017/10/11.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Member_RecordFrame;

@interface Member_RecordCell : UITableViewCell

+ (instancetype)Member_RecordCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) Member_RecordFrame *frameModel;

@end
