//
//  New_RecordModel.h
//  CashierDeskIphone
//
//  Created by mac on 2017/2/28.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface New_RecordModel : NSObject

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)Q_ljDetailRecordWithDict:(NSDictionary *)dic;

@property (nonatomic, copy) NSString *TranRcdsid;

@property (nonatomic, copy) NSString *Jinzhongzi;

@property (nonatomic, copy) NSString *MerchantID;

@property (nonatomic, copy) NSString *Memberid;

@property (nonatomic, copy) NSString *TransactionType;

@property (nonatomic, copy) NSString *CashierAccountID;

@property (nonatomic, copy) NSString *MerchantShopID;

@property (nonatomic, copy) NSString *CreateDate;

@property (nonatomic, copy) NSString *TransactionDESC;

@property (nonatomic, copy) NSString *TranAccount;

@property (nonatomic, copy) NSString *goodsname;

@property (nonatomic, copy) NSString *yuangong;

@property (nonatomic, copy) NSString *pic1;

@property (nonatomic, copy) NSString *pic2;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *allaccount;

@end
