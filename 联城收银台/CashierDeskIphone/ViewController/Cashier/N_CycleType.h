//
//  N_CycleType.h
//  CashierDeskIphone
//
//  Created by mac on 2017/4/12.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface N_CycleType : NSObject

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)N_CycleTypeWithDict:(NSDictionary *)dic;

@property (nonatomic, copy) NSString *CycleType;

@property (nonatomic, copy) NSString *length;

@end
