//
//  AboutViewController.m
//  CashierDeskIphone
//
//  Created by mac on 13-9-13.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "AboutViewController.h"

#import "AboutData.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

@synthesize m_myWebView;

@synthesize m_titleLabel;

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
            
               [self.m_myWebView setFrame:CGRectMake(0, 68, 320, [[UIScreen mainScreen]bounds].size.height - 20 - 48)];
        }else{
            
               [self.m_myWebView setFrame:CGRectMake(0, 68, 320, [[UIScreen mainScreen]bounds].size.height)];
        }
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
        label.backgroundColor = [UIColor blackColor];
        
        [self.view addSubview:label];
        
        
    }else{
        
        [self.m_titleView setFrame:CGRectMake(0, 0, 320, 48)];
        
        [self.m_myWebView setFrame:CGRectMake(0, 48, 320, self.view.frame.size.height - 48)];
    }
    
    self.m_myWebView.delegate = self;
    
//    [self.m_myWebView setOpaque:NO];

    [self hideGradientBackground:self.m_myWebView];

    [self requestSubmit];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backLastView:(id)sender {
    
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
                                @"54",@"infoId",nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [requstClient request:CDHTTPRequestMore parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        AboutData *aboutData = [[AboutData alloc]initWithJsonObject:handlJson];
                        
        BOOL success = [aboutData.status boolValue];
        
        if (success) {
            
            // 赋值
            self.m_titleLabel.text = [NSString stringWithFormat:@"%@",aboutData.Title];
            // 加载webView数据
            [self.m_myWebView loadHTMLString:aboutData.Content baseURL:nil];
            
            [SVProgressHUD dismiss];
            
        }else
        {
                 
            [SVProgressHUD showErrorWithStatus:aboutData.msg];
            
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
    
    [SVProgressHUD showWithStatus:@"数据加载中"];

}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    [SVProgressHUD dismiss];

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

    [SVProgressHUD dismiss];

	// report the error inside the webview
	NSString* errorString = [NSString stringWithFormat:
							 @"<html><center><font size=+5 color='red'>An error occurred:<br>%@</font></center></html>",
							 error.localizedDescription];
	[m_myWebView loadHTMLString:errorString baseURL:nil];
}

- (void)viewDidUnload {
    [self setM_titleLabel:nil];
    [super viewDidUnload];
}

@end
