//
//  Member_RechargeModel.m
//  CashierDeskIphone
//
//  Created by mac on 2017/10/11.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "Member_RechargeModel.h"

@implementation Member_RechargeModel

- (instancetype)initWithDict:(NSDictionary *)dic {
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
        
    }
    
    return self;
    
}

+ (instancetype)Member_RechargeModelWithDict:(NSDictionary *)dic {
    
    return [[self alloc] initWithDict:dic];
    
}

@end
