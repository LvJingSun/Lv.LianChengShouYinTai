//
//  QuanquanData.m
//  CashierDeskIphone
//
//  Created by mac on 13-9-16.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "QuanquanData.h"

@implementation QuanquanData

- (NSString *)msg{
    
    return [mDictionary objectForKey:@"msg"];
    
}

- (NSString *)status{
    
    return [mDictionary objectForKey:@"status"];
    
}

- (NSString *)KeyStatus{
    
    return [[mDictionary getDictionary:@"QuanKeySession"] objectForKey:@"KeyStatus"];

}

- (NSString *)KeyValue{
    
    return [[mDictionary getDictionary:@"QuanKeySession"] objectForKey:@"KeyValue"];
    
}


- (NSString *)VouchersID{
    
    return [[mDictionary getDictionary:@"QuanKeySession"] objectForKey:@"VouchersID"];
    
}

- (NSString *)AllName{
    
    return [[mDictionary getDictionary:@"QuanKeySession"] objectForKey:@"AllName"];
    
}

- (NSString *)Description{
    
    return [[mDictionary getDictionary:@"QuanKeySession"] objectForKey:@"Description"];
    
}


- (NSString *)LogoMidUrl{
    
    return [[mDictionary getDictionary:@"QuanKeySession"] objectForKey:@"LogoMidUrl"];
    
}

- (NSString *)MaxDateTime{
    
    return [[mDictionary getDictionary:@"QuanKeySession"] objectForKey:@"MaxDateTime"];
    
}

- (NSString *)MinDateTime{
    
    return [[mDictionary getDictionary:@"QuanKeySession"] objectForKey:@"MinDateTime"];
    
}


- (NSString *)Title{
    
    return [[mDictionary getDictionary:@"QuanKeySession"] objectForKey:@"Title"];
    
}

- (NSArray *)VouMctShopList{
    
    NSMutableArray *retArray = [[NSMutableArray alloc] init];
    
    NSArray *items = [[mDictionary getDictionary:@"QuanKeySession"] getArray:@"VouMctShopList"];
    
    for (NSDictionary *dic in items) {
        
        QuanquanShopData *item = [[QuanquanShopData alloc] initWithJsonObject:dic];
        
        [retArray addObject:item];
        
    }
    
    return retArray;
    
}



@end


@implementation QuanquanShopData

- (NSString *)MctShopID{
    
    return [mDictionary objectForKey:@"MctShopID"];
    
}

- (NSString *)MctShopName{
    
    return [mDictionary objectForKey:@"MctShopName"];
    
}


@end

