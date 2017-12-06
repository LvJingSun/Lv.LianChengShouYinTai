//
//  N_CycleType.m
//  CashierDeskIphone
//
//  Created by mac on 2017/4/12.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "N_CycleType.h"

@implementation N_CycleType

- (instancetype)initWithDict:(NSDictionary *)dic {

    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
        
    }
    
    return self;
    
}

+ (instancetype)N_CycleTypeWithDict:(NSDictionary *)dic {

    return [[self alloc] initWithDict:dic];
    
}

@end
