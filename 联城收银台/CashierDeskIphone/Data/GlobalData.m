//
//  GlobalData.m
//  CashierDeskIphone
//
//  Created by mac on 13-8-30.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "GlobalData.h"
static GlobalData* _shareInstance = nil;
@implementation GlobalData
@synthesize dicprotocol = _dicprotocol;
@synthesize userInfo = _userInfo;
+ (GlobalData*)sharedInstance
{
    if (_shareInstance == nil) {
        _shareInstance = [[GlobalData alloc]init];
        return _shareInstance;
    }
    return _shareInstance;
}
@end
