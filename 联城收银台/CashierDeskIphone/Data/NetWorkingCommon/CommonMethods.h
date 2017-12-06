//
//  CommonMethods.h
//  CashierDeskIphone
//
//  Created by mac on 13-9-7.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 *  用户设置
 *  edit by lvwei
 */
extern NSString* const checkUserNameStatus;
extern NSString* const checkPassWordStatus;
extern NSString* const checkPassword;
extern NSString* const checkUserName;


@interface CommonMethods : NSObject

+(id)getValueFromUserDefaultForKey:(NSString*)key;

+(void)setUserDefaultToValue:(id)Object byKey:(NSString*)key;

@end
