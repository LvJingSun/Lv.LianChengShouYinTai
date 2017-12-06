//
//  N_ShouYinModel.m
//  CashierDeskIphone
//
//  Created by mac on 2017/10/18.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "N_ShouYinModel.h"

@implementation N_ShouYinModel

- (instancetype)initWithDict:(NSDictionary *)dic {
    
    if (self = [super init]) {
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"ID"]] forKey:@"ID"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"Title"]] forKey:@"Title"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"Amount"]] forKey:@"Amount"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"Date"]] forKey:@"Date"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"TransactionType"]] forKey:@"TransactionType"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"stylename"]] forKey:@"stylename"];
        
    }
    
    return self;
    
}

@end
