//
//  QuanquanData.h
//  CashierDeskIphone
//
//  Created by mac on 13-9-16.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "BaseData.h"

@interface QuanquanData : BaseData

@property (nonatomic,readonly) NSString *status;
@property (nonatomic,readonly) NSString *msg;

@property (nonatomic,readonly) NSString *KeyStatus;
@property (nonatomic,readonly) NSString *KeyValue;
@property (nonatomic,readonly) NSString *VouchersID;

@property (nonatomic,readonly) NSString *AllName;
@property (nonatomic,readonly) NSString *Description;
@property (nonatomic,readonly) NSString *LogoMidUrl;
@property (nonatomic,readonly) NSString *MaxDateTime;
@property (nonatomic,readonly) NSString *MinDateTime;
@property (nonatomic,readonly) NSString *Title;
@property (nonatomic,readonly) NSArray  *VouMctShopList;

@end


@interface QuanquanShopData : BaseData

@property (nonatomic,readonly) NSString *MctShopID;
@property (nonatomic,readonly) NSString *MctShopName;


@end

