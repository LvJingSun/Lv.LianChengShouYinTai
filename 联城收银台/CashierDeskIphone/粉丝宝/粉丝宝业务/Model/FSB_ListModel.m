//
//  FSB_ListModel.m
//  CashierDeskIphone
//
//  Created by mac on 2017/7/5.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "FSB_ListModel.h"

@implementation FSB_ListModel

- (instancetype)initWithDict:(NSDictionary *)dic {

    if (self = [super init]) {
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"TranNum"]] forKey:@"TranNum"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"Memberid"]] forKey:@"Memberid"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"MerchantID"]] forKey:@"MerchantID"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"Part"]] forKey:@"Part"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"TotalPart"]] forKey:@"TotalPart"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"MerchantShopID"]] forKey:@"MerchantShopID"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"TranAccount"]] forKey:@"TranAccount"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"Num"]] forKey:@"Num"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"Goodsname"]] forKey:@"Goodsname"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"Yuangong"]] forKey:@"Yuangong"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"CashierAccountID"]] forKey:@"CashierAccountID"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"Allaccount"]] forKey:@"Allaccount"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"fileUrlP"]] forKey:@"fileUrlP"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"MerchantDesc"]] forKey:@"MerchantDesc"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"fileUrlN"]] forKey:@"fileUrlN"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"Commit"]] forKey:@"Commit"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"TranStatus"]] forKey:@"TranStatus"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"CreateDate"]] forKey:@"CreateDate"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"TranID"]] forKey:@"TranID"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"typename"]] forKey:@"type_name"];
        
    }
    
    return self;
    
}

+ (instancetype)FSB_ListModelWithDict:(NSDictionary *)dic {

    return [[self alloc] initWithDict:dic];
    
}

@end
