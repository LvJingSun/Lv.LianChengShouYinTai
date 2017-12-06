//
//  AppDelegate.h
//  CashierDeskIphone
//
//  Created by mac on 13-8-27.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

#define Appdelegate  ((AppDelegate*)[[UIApplication sharedApplication] delegate])

@interface AppDelegate : UIResponder <UIApplicationDelegate,UINavigationControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController* nav;

@property (assign, nonatomic) int  m_type;

@property (assign, nonatomic) BOOL  m_isFirst;

// 版本检测的请求
- (void)versionRequest;

// 判断网络不好
- (BOOL)isConnectionAvailable;

@end
