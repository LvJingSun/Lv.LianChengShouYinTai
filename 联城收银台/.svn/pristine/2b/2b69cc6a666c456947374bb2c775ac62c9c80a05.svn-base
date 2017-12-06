//
//  NotificationDetailViewController.m
//  CashierDeskIphone
//
//  Created by mac on 13-9-13.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "NotificationDetailViewController.h"

#import "NotificationData.h"

@interface NotificationDetailViewController ()

@end

@implementation NotificationDetailViewController

@synthesize m_timeLabel;

@synthesize m_titleLabel;

@synthesize m_noticeId;

@synthesize m_navTitle;

@synthesize m_webView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationController.navigationBar.translucent = NO;

    // 版本判断
    if ( isIOS7 ) {
        
        [self.m_titleView setFrame:CGRectMake(0, 20, 320, 48)];
        
        if ( iPhone5 ) {
            
            [self.m_tempView setFrame:CGRectMake(0, 68, 320, [[UIScreen mainScreen]bounds].size.height - 80)];
            
            [self.m_webView setFrame:CGRectMake(10, 95, 300, [[UIScreen mainScreen]bounds].size.height - 200)];

        }else{
            
            [self.m_tempView setFrame:CGRectMake(0, 68, 320, [[UIScreen mainScreen]bounds].size.height)];
            
            [self.m_webView setFrame:CGRectMake(10, 95, 300, [[UIScreen mainScreen]bounds].size.height - 110)];

        }
        
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
        label.backgroundColor = [UIColor blackColor];
        
        [self.view addSubview:label];
        
    }else{
        
        [self.m_titleView setFrame:CGRectMake(0, 0, 320, 48)];
        
        [self.m_tempView setFrame:CGRectMake(0, 48, 320, self.view.frame.size.height - 48)];
        
        if ( iPhone5 ) {
            
             [self.m_webView setFrame:CGRectMake(10, 95, 300, [[UIScreen mainScreen]bounds].size.height - 180)];
            
        }else{
            
             [self.m_webView setFrame:CGRectMake(10, 95, 300, [[UIScreen mainScreen]bounds].size.height - 100)];
        }
    }
    
    self.m_webView.delegate = self;
    
    // 设置webView 的背景颜色为clearColor
    self.m_webView.backgroundColor = [UIColor clearColor];

    // 设置webView的背景不透明属性
    [self.m_webView setOpaque:NO];
    
    // 设置webview的上拉下拉的背景为透明的
    [self hideGradientBackground:self.m_webView];

    // 请求数据
    [self requestSubmit];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)BackLastView:(id)sender {
    
    [self goBack];
}

- (void)requestSubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
        
    // 刷新请求数据接口
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId, @"cashierAccountId",
                                key,@"key",
                                self.m_noticeId,@"noticeId",nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [requstClient request:CDHTTPRequestNotificationDetail parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        NoticeDetailData *noticeDetailData = [[NoticeDetailData alloc]initWithJsonObject:handlJson];
              
        NSLog(@"handlJson = %@",handlJson);
        
        BOOL success = [noticeDetailData.status boolValue];
        
        if (success) {
            
            // 赋值            
            self.m_titleLabel.text = [NSString stringWithFormat:@"%@",noticeDetailData.Title];
            
            self.m_timeLabel.text = [NSString stringWithFormat:@"%@",noticeDetailData.ModifyDate];
                        
            // webView加载内容
            [self.m_webView loadHTMLString:noticeDetailData.Content baseURL:nil];
            
            [SVProgressHUD dismiss];
            
        }else
        {
            
            [SVProgressHUD showErrorWithStatus:noticeDetailData.msg];
            
        }
    } failured:^(NSError* error)
     {
         NSLog(@"error:%@",error.description);
         
         [SVProgressHUD showErrorWithStatus:error.description];
     }];
}

#pragma mark - UIwebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
	// report the error inside the webview
	NSString* errorString = [NSString stringWithFormat:
							 @"<html><center><font size=+5 color='red'>An error occurred:<br>%@</font></center></html>",
							 error.localizedDescription];
	[self.m_webView loadHTMLString:errorString baseURL:nil];
}

- (void)viewDidUnload {
    [self setM_titleLabel:nil];
    [self setM_timeLabel:nil];
    [self setM_navTitle:nil];
    [super viewDidUnload];
}
@end
