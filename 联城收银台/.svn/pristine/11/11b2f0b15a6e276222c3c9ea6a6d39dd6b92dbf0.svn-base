//
//  BaseViewController.h
//  CashierDeskIphone
//
//  Created by mac on 13-8-30.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Configuration.h"

#import "CommonUtil.h"

#import "HttpClientRequest.h"

#import "SVProgressHUD.h"

#import "AppDelegate.h"


#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)


#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)


#define isIOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)

#define WindowSizeWidth [UIScreen mainScreen].bounds.size.width

@interface BaseViewController : UIViewController
{
    BOOL keyboardShow;
}
@property(strong, nonatomic) UIButton *doneInKeyboardButton;
@property(weak, nonatomic) UITextField *activeField;
@property(assign, nonatomic) BOOL needHiddenDone;


- (void)goBack;

// 显示完成按钮
- (IBAction)showNumberPadKeyboard:(id)sender;

- (IBAction)hideNumberPadKeyboard:(id)sender;


// 用于设置webView的上拉下拉的背景-设置为白色的
- (void) hideGradientBackground:(UIView*)theView;

// 用于判断网络不好
- (BOOL)isConnectionAvailable;



@end
