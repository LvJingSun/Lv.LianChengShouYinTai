//
//  FSB_InPutCell.h
//  CashierDeskIphone
//
//  Created by mac on 2017/6/16.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FSB_InPutFrame;

@protocol FSB_InPutDelegate <NSObject>

- (void)RedCountFieldEndChange:(UITextField *)field;

- (void)TranCountFieldChange:(UITextField *)field;

- (void)RedCountFieldChange:(UITextField *)field;

- (void)JiFenCountFieldChange:(UITextField *)field;

@end

@interface FSB_InPutCell : UITableViewCell

+ (instancetype)FSB_InPutCellWithTableview:(UITableView *)tableview;

@property (nonatomic, weak) FSB_InPutFrame *frameModel;

@property (nonatomic, copy) dispatch_block_t productBlock;

@property (nonatomic, copy) dispatch_block_t redCopiesBlock;

@property (nonatomic, copy) dispatch_block_t staffBlock;

@property (nonatomic, copy) dispatch_block_t sureBlock;

@property (nonatomic, copy) dispatch_block_t type_merchantBlock;

@property (nonatomic, copy) dispatch_block_t type_pingtaiBlock;

@property (nonatomic, copy) dispatch_block_t merchant_huiyuankaBlock;

@property (nonatomic, copy) dispatch_block_t merchant_tixianBlock;

@property (nonatomic, strong) id<FSB_InPutDelegate> delegate;

@end
