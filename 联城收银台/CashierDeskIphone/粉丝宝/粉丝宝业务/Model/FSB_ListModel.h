//
//  FSB_ListModel.h
//  CashierDeskIphone
//
//  Created by mac on 2017/7/5.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSB_ListModel : NSObject

@property (nonatomic, copy) NSString *TranID; //订单号

@property (nonatomic, copy) NSString *TranNum; //迁移前订单号

@property (nonatomic, copy) NSString *Memberid; //会员ID

@property (nonatomic, copy) NSString *MerchantID; //商户ID

@property (nonatomic, copy) NSString *Part; //已领红包分数

@property (nonatomic, copy) NSString *TotalPart; //红包总分数

@property (nonatomic, copy) NSString *MerchantShopID; //店铺名

@property (nonatomic, copy) NSString *TranAccount; //交易金额

@property (nonatomic, copy) NSString *Num; //商户付出金种子数量

@property (nonatomic, copy) NSString *Goodsname; //商品名称

@property (nonatomic, copy) NSString *Yuangong; //促销员ID

@property (nonatomic, copy) NSString *CashierAccountID; //收银员ID

@property (nonatomic, copy) NSString *Allaccount; //红包总额度

@property (nonatomic, copy) NSString *fileUrlP; //发票

@property (nonatomic, copy) NSString *MerchantDesc; //商户交易说明

@property (nonatomic, copy) NSString *fileUrlN; //收据

@property (nonatomic, copy) NSString *CreateDate; //时间

@property (nonatomic, copy) NSString *Commit; // 是否提交

@property (nonatomic, copy) NSString *TranStatus; // 业务状态 1，启用 2，暂停 3,退回

@property (nonatomic, copy) NSString *type_name; //判断 商户红包、平台红包

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)FSB_ListModelWithDict:(NSDictionary *)dic;

@end
