//
//  Q_DanJuViewController.h
//  CashierDeskIphone
//
//  Created by mac on 2017/2/21.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Q_DanJuViewController : UIViewController

//手机号码
@property (nonatomic, copy) NSString *phone;

//姓名
@property (nonatomic, copy) NSString *name;

//商品名称
@property (nonatomic, copy) NSString *productName;

//交易金额
@property (nonatomic, copy) NSString *tranCount;

//全返金额
@property (nonatomic, copy) NSString *fanCount;

//金种子数量
@property (nonatomic, copy) NSString *count;

//返利周期
@property (nonatomic, copy) NSString *cycle;

//返利周期名字
@property (nonatomic, copy) NSString *cycleName;

//促销员
@property (nonatomic, copy) NSString *staff;

//促销员名字
@property (nonatomic, copy) NSString *staffName;

@property (nonatomic, copy) NSString *CashierAccountID;

@end
