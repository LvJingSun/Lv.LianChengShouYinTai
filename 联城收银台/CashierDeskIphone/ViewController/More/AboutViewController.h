//
//  AboutViewController.h
//  CashierDeskIphone
//
//  Created by mac on 13-9-13.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"

@interface AboutViewController : BaseViewController<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *m_myWebView;

@property (weak, nonatomic) IBOutlet UILabel *m_titleLabel;

@property (weak, nonatomic) IBOutlet UIView *m_titleView;


- (IBAction)backLastView:(id)sender;


// 请求数据
- (void)requestSubmit;

@end
