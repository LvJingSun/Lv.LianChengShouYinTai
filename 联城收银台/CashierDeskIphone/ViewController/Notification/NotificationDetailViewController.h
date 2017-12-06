//
//  NotificationDetailViewController.h
//  CashierDeskIphone
//
//  Created by mac on 13-9-13.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"

@interface NotificationDetailViewController : BaseViewController<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *m_titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_timeLabel;

@property (nonatomic, strong) NSString        *m_noticeId;

@property (weak, nonatomic) IBOutlet UILabel *m_navTitle;

@property (weak, nonatomic) IBOutlet UIWebView *m_webView;

@property (weak, nonatomic) IBOutlet UIView *m_titleView;

@property (weak, nonatomic) IBOutlet UIView *m_tempView;


- (IBAction)BackLastView:(id)sender;

// 请求数据
- (void)requestSubmit;

@end



