//
//  KeyValidateData.m
//  CashierDeskIphone
//
//  Created by mac on 13-9-16.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "KeyValidateData.h"

@implementation KeyValidateData

- (NSString *)msg{
    
    return [mDictionary objectForKey:@"msg"];
    
}

- (NSString *)status{
    
    return [mDictionary objectForKey:@"status"];
    
}

- (NSArray *)memberKey{
    
    NSMutableArray *retArray = [[NSMutableArray alloc] init];
    
    NSArray *items = [mDictionary getArray:@"memberKey"];
    
    for (NSDictionary *dic in items) {
        
        ValidateData *item = [[ValidateData alloc] initWithJsonObject:dic];
        
        [retArray addObject:item];
        
    }
    
    return retArray;
    
}

- (int)NormalCount{
    
    return [[mDictionary objectForKey:@"NormalCount"] intValue];
    
}


@end

@implementation ValidateData

- (NSString *)KeyCode{
    
    return [mDictionary objectForKey:@"KeyCode"];
    
}

- (int)Status{
    
    return [[mDictionary objectForKey:@"Status"] intValue];
    
}

- (NSString *)KeyDateS{
    
    return [mDictionary objectForKey:@"KeyDateS"];
    
}

- (NSString *)KeyDateE{
    
    return [mDictionary objectForKey:@"KeyDateE"];
    
}


@end
