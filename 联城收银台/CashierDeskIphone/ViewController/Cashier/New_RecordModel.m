//
//  New_RecordModel.m
//  CashierDeskIphone
//
//  Created by mac on 2017/2/28.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "New_RecordModel.h"

@implementation New_RecordModel

- (instancetype)initWithDict:(NSDictionary *)dic {
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
        
    }
    
    return self;
    
}

+ (instancetype)Q_ljDetailRecordWithDict:(NSDictionary *)dic {
    
    return [[self alloc] initWithDict:dic];
    
}

@end
