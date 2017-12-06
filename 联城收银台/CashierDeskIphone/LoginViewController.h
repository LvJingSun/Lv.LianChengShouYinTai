//
//  LoginViewController.h
//  CashierDeskIphone
//
//  Created by mac on 13-8-30.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"

#import "UserInfoData.h"


@interface LoginViewController : BaseViewController
<
 UITextFieldDelegate
>

// BOOL用于判断是否记录密码和用户名
@property (nonatomic, assign) BOOL  isCheckedUserName;

@property (nonatomic, assign) BOOL  isCheckedPassWord;


// 保存服务器返回的数据
- (void)save:(UserInfoData*)info withTime:(NSString*)dateTime;

// 判断是否保存了用户名和密码
- (void)isValue;


@end
