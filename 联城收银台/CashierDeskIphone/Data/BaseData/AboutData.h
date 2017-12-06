//
//  AboutData.h
//  CashierDeskIphone
//
//  Created by mac on 13-9-16.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "BaseData.h"

@interface AboutData : BaseData

@property (nonatomic,readonly) NSString *status;
@property (nonatomic,readonly) NSString *msg;

@property (nonatomic,readonly) NSString *InfoId;
@property (nonatomic,readonly) NSString *Title;
@property (nonatomic,readonly) NSString *Content;

@end
