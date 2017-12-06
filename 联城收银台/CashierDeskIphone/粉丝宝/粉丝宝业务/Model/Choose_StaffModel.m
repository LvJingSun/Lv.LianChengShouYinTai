//
//  Choose_StaffModel.m
//  CashierDeskIphone
//
//  Created by mac on 2017/6/17.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "Choose_StaffModel.h"

@implementation Choose_StaffModel

- (instancetype)initWithDict:(NSDictionary *)dic {

    if (self = [super init]) {
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"CashierAccountID"]] forKey:@"CashierAccountID"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"RealName"]] forKey:@"RealName"];
        
    }
    
    return self;
    
}

+ (instancetype)Choose_StaffModelWithDict:(NSDictionary *)dic {

    return [[self alloc] initWithDict:dic];
    
}

@end
