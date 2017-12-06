//
//  Member_RechargeFrame.h
//  CashierDeskIphone
//
//  Created by mac on 2017/10/11.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Member_RechargeModel;

@interface Member_RechargeFrame : NSObject

@property (nonatomic, assign) CGRect phoneF;

@property (nonatomic, assign) CGRect iconF;

@property (nonatomic, assign) CGRect nameF;

@property (nonatomic, assign) CGRect balanceF;

@property (nonatomic, assign) CGRect typeTitleF;

@property (nonatomic, assign) CGRect yueRechargeF;

@property (nonatomic, assign) CGRect jifenRechargeF;

@property (nonatomic, assign) CGRect countTitleF;

@property (nonatomic, assign) CGRect countF;

@property (nonatomic, assign) CGRect beizhuTitleF;

@property (nonatomic, assign) CGRect beizhuF;

@property (nonatomic, assign) CGRect bgF;

@property (nonatomic, assign) CGRect sureF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) Member_RechargeModel *rechargeModel;

@end
