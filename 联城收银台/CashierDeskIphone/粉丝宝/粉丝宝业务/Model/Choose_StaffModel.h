//
//  Choose_StaffModel.h
//  CashierDeskIphone
//
//  Created by mac on 2017/6/17.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Choose_StaffModel : NSObject

@property (nonatomic, copy) NSString *CashierAccountID;

@property (nonatomic, copy) NSString *RealName;

@property (nonatomic, copy) NSString *isChoose;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)Choose_StaffModelWithDict:(NSDictionary *)dic;

@end
