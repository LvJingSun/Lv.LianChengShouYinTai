//
//  ModifierPSWViewController.h
//  CashierDeskIphone
//
//  Created by mac on 13-9-11.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//  修改密码的页面

#import "BaseViewController.h"

@interface ModifierPSWViewController : BaseViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *m_originalTextField;

@property (weak, nonatomic) IBOutlet UITextField *m_newPSWTextField;

@property (weak, nonatomic) IBOutlet UITextField *m_againTextField;

@property (weak, nonatomic) IBOutlet UIView *m_titleVIew;

@property (weak, nonatomic) IBOutlet UIScrollView *m_scrollerView;

// 保存修改的密码触发的事件
- (IBAction)savePSWClicked:(id)sender;

// 返回按钮触发的事件
- (IBAction)BackLastView:(id)sender;

// 请求数据
- (void)requestSubmit;

@end


