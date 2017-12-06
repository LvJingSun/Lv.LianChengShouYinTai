//
//  AboutData.m
//  CashierDeskIphone
//
//  Created by mac on 13-9-16.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "AboutData.h"

@implementation AboutData

- (NSString *)msg{
    
    return [mDictionary objectForKey:@"msg"];
    
}

- (NSString *)status{
    
    return [mDictionary objectForKey:@"status"];
    
}

- (NSString *)InfoId{
    
    return [[mDictionary getDictionary:@"infoAbout"] objectForKey:@"InfoId"];
    
}

- (NSString *)Title{
    
    return [[mDictionary getDictionary:@"infoAbout"] objectForKey:@"Title"];
    
}

- (NSString *)Content{
    
    return [[mDictionary getDictionary:@"infoAbout"] objectForKey:@"Content"];
    
}


@end
