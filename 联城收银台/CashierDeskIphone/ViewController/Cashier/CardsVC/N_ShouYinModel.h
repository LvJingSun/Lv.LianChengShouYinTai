//
//  N_ShouYinModel.h
//  CashierDeskIphone
//
//  Created by mac on 2017/10/18.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface N_ShouYinModel : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, copy) NSString *Amount;

@property (nonatomic, copy) NSString *Date;

@property (nonatomic, copy) NSString *TransactionType;

@property (nonatomic, copy) NSString *stylename;

- (instancetype)initWithDict:(NSDictionary *)dic;

@end
