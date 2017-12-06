//
//  ConsumerData.m
//  CashierDeskIphone
//
//  Created by mac on 13-9-16.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "ConsumerData.h"

@implementation ConsumerData

- (NSString *)msg{
    
    return [mDictionary objectForKey:@"msg"];
    
}

- (NSString *)status{
    
    return [mDictionary objectForKey:@"status"];
    
}

- (NSArray *)confirmCashRecognized{
    
    NSMutableArray *retArray = [[NSMutableArray alloc] init];
    
    NSArray *items = [mDictionary getArray:@"confirmCashRecognized"];
        
    for (NSDictionary *dic in items) {
        
        ConsumerDetailData *item = [[ConsumerDetailData alloc] initWithJsonObject:dic];
        
        [retArray addObject:item];
        
    }
    
    return retArray;
    
}


@end

@implementation ConsumerDetailData


- (NSString *)CashRegisterRecordId{
    
    return [mDictionary objectForKey:@"CashRegisterRecordId"];
    
}

- (NSString *)KeyCode{
    
    return [mDictionary objectForKey:@"KeyCode"];
    
}

- (NSString *)Amount{
    
    return [mDictionary objectForKey:@"Amount"];
    
}

- (NSString *)Phone{
    
    return [mDictionary objectForKey:@"Phone"];
    
}

- (NSString *)RealName{
    
    return [mDictionary objectForKey:@"RealName"];
    
}

- (NSString *)CreateDate{
    
    return [mDictionary objectForKey:@"CreateDate"];
    
}

@end
