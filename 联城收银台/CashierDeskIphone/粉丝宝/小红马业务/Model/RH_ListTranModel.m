//
//  RH_ListTranModel.m
//  CashierDeskIphone
//
//  Created by mac on 2017/8/4.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_ListTranModel.h"

@implementation RH_ListTranModel

- (instancetype)initWithDict:(NSDictionary *)dic {

    if (self = [super init]) {
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"TranID"]] forKey:@"TranID"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"CarNo"]] forKey:@"CarNo"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"Brandname"]] forKey:@"Brandname"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"Memberid"]] forKey:@"Memberid"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"MerchantID"]] forKey:@"MerchantID"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"TotalPart"]] forKey:@"TotalPart"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"Goodsname"]] forKey:@"Goodsname"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"CashierAccountID"]] forKey:@"CashierAccountID"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"Num"]] forKey:@"Num"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"Allaccount"]] forKey:@"Allaccount"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"CreateDate"]] forKey:@"CreateDate"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"MerchantDesc"]] forKey:@"MerchantDesc"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"TranStatus"]] forKey:@"TranStatus"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"CarInvoiceImg"]] forKey:@"CarInvoiceImg"];
        
    }
    
    return self;
    
}

+ (instancetype)RH_ListTranModelWithDict:(NSDictionary *)dic {

    return [[self alloc] initWithDict:dic];
    
}

@end
