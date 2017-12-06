//
//  CommonMethods.m
//  CashierDeskIphone
//
//  Created by mac on 13-9-7.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "CommonMethods.h"

NSString* const checkUserNameStatus = @"checkUserNameStatus";

NSString* const checkUserName = @"checkUsername";

NSString* const checkPassword = @"checkPassword";

NSString* const checkPassWordStatus = @"checkPasswordStatus";

@implementation CommonMethods

+ (id)getValueFromUserDefaultForKey:(NSString *)key
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    if (defaults) {
        id object = [defaults objectForKey:key];
        return object;
    }
    return nil;
}

+ (void)setUserDefaultToValue:(id)Object byKey:(NSString*)key
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    if (defaults) {
        [defaults setObject:Object forKey:key];
    }
}



@end
