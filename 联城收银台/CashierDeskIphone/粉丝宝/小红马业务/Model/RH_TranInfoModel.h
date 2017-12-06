//
//  RH_TranInfoModel.h
//  CashierDeskIphone
//
//  Created by mac on 2017/6/16.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RH_TranInfoModel : NSObject

//汽车ID
@property (nonatomic, copy) NSString *carID;

//汽车名字
@property (nonatomic, copy) NSString *carName;

//红包金额
@property (nonatomic, copy) NSString *redCount;

//红包份数ID
@property (nonatomic, copy) NSString *redCopiesID;

//红包份数名称
@property (nonatomic, copy) NSString *redCopiesName;

//红包比例
@property (nonatomic, copy) NSString *redProportion;

//红包比例ID
@property (nonatomic, copy) NSString *redProportionID;

//金种子数量
@property (nonatomic, copy) NSString *goldCount;

//促销员ID
@property (nonatomic, copy) NSString *staffID;

//促销员名字
@property (nonatomic, copy) NSString *staffName;

@end
