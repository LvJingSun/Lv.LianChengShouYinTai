//
//  Member_RechargeModel.h
//  CashierDeskIphone
//
//  Created by mac on 2017/10/11.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Member_RechargeModel : NSObject

@property (nonatomic, copy) NSString *VipCardRecordId;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *iconUrl;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *balance;

@property (nonatomic, copy) NSString *jifen;

@property (nonatomic, copy) NSString *rechargeType; //1-余额充值 2-积分充值

@property (nonatomic, copy) NSString *count;

@property (nonatomic, copy) NSString *beizhu;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)Member_RechargeModelWithDict:(NSDictionary *)dic;

@end
