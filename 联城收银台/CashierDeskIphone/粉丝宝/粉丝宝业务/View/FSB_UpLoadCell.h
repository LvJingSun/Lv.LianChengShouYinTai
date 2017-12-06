//
//  FSB_UpLoadCell.h
//  CashierDeskIphone
//
//  Created by mac on 2017/6/24.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FSB_UpLoadFrame;

@interface FSB_UpLoadCell : UITableViewCell

+ (instancetype)FSB_UpLoadCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) FSB_UpLoadFrame *frameModel;

@property (nonatomic, copy) dispatch_block_t InvoiceBlock;

@property (nonatomic, copy) dispatch_block_t SureBlock;

@property (nonatomic, weak) UIButton *SureBtn;

@end
