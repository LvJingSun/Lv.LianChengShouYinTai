//
//  Member_RechargeCell.h
//  CashierDeskIphone
//
//  Created by mac on 2017/10/11.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Member_RechargeFrame;

@protocol MemberShipRechargeDelegate <NSObject>

- (void)CountFieldChange:(UITextField *)field;

- (void)BeiZhuFieldChange:(UITextField *)field;

@end

@interface Member_RechargeCell : UITableViewCell

+ (instancetype)Member_RechargeCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) Member_RechargeFrame *frameModel;

@property (nonatomic, weak) UITextField *phoneField;

@property (nonatomic, copy) dispatch_block_t yueBlock;

@property (nonatomic, copy) dispatch_block_t jifenBlock;

@property (nonatomic, copy) dispatch_block_t sureBlock;

@property (nonatomic, strong) id<MemberShipRechargeDelegate> delegate;

@end
