//
//  FSB_TranInfoModel.h
//  CashierDeskIphone
//
//  Created by mac on 2017/6/16.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSB_TranInfoModel : NSObject

//账号
@property (nonatomic, copy) NSString *acount;

//名字
@property (nonatomic, copy) NSString *name;

//ID
@property (nonatomic, copy) NSString *acountID;

//商品名称
@property (nonatomic, copy) NSString *productName;

//交易金额
@property (nonatomic, copy) NSString *tranCount;

//红包金额
@property (nonatomic, copy) NSString *redCount;

//红包份数ID
@property (nonatomic, copy) NSString *redCopiesID;

//红包份数名称
@property (nonatomic, copy) NSString *redCopiesName;

//金种子数量
@property (nonatomic, copy) NSString *goldCount;

//促销员ID
@property (nonatomic, copy) NSString *staffID;

//促销员名字
@property (nonatomic, copy) NSString *staffName;

//发票图片
@property (nonatomic, copy) UIImage *InvoiceImg;

//购车发票图片链接
@property (nonatomic, copy) NSString *InvoiceImgUrl;

//红包类型 1-商户 0-平台
@property (nonatomic, copy) NSString *redType;

//商户红包分类 1-会员卡余额 2-会员卡红包
@property (nonatomic, copy) NSString *merchantRedType;

@property (nonatomic, copy) NSString *jifen;

@end
