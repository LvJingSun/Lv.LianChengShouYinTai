//
//  RefreshData.h
//  CashierDeskIphone
//
//  Created by mac on 13-9-16.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "BaseData.h"

@interface RefreshData : BaseData

@property (nonatomic,readonly)NSString *msg;
@property (nonatomic,readonly)NSString *status;

@property (nonatomic,readonly)NSString *DayReceivablesCount;
@property (nonatomic,readonly)NSString *DayReceivablesMoney;
@property (nonatomic,readonly)NSString *WorkReceivablesCount;
@property (nonatomic,readonly)NSString *WeekReceivablesMoney;
@property (nonatomic,readonly)NSString *MonthReceivablesCount;
@property (nonatomic,readonly)NSString *MonthReceivablesMoney;
@property (nonatomic,readonly)NSString *StatisticalDate;


@end
