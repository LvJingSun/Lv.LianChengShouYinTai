//
//  ModifierPSWViewController.m
//  CashierDeskIphone
//
//  Created by mac on 13-9-11.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "ModifierPSWViewController.h"

#import "BaseData.h"

@interface ModifierPSWViewController ()

@end

@implementation ModifierPSWViewController

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
        
        [self.m_titleVIew setFrame:CGRectMake(0, 20, 320, 48)];
        
        [self.m_scrollerView setFrame:CGRectMake(0, 68, 320, [[UIScreen mainScreen]bounds].size.height - 20 - 48)];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
        label.backgroundColor = [UIColor blackColor];
        
        [self.view addSubview:label];
        
    }else{
        
        [self.m_titleVIew setFrame:CGRectMake(0, 0, 320, 48)];
        
        [self.m_scrollerView setFrame:CGRectMake(0, 48, 320, self.view.frame.size.height - 48)];
    }

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
        
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestSubmit{
    
    if ( self.m_originalTextField.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入原密码！"];

        return;
    }
    
    if ( self.m_newPSWTextField.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入新密码！"];
        
        return;
    }
    
    if ( self.m_againTextField.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入确认的新密码！"];
        
        return;
    }
    
    if ( ![self.m_newPSWTextField.text isEqualToString:self.m_againTextField.text] ) {
        
        [SVProgressHUD showErrorWithStatus:@"两次输入的密码不一致，请重新输入！"];
        
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
            
    // 刷新请求数据接口
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId, @"cashierAccountId",
                                key,@"key",
                                self.m_newPSWTextField.text,@"newPwd",
                                self.m_originalTextField.text,@"oriPwd",nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [requstClient request:CDHTTPRequestModify parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        BaseRetData *baseData = [[BaseRetData alloc]initWithJsonObject:handlJson];
                                
        BOOL success = [baseData.status boolValue];
        
        if (success) {
            
            [SVProgressHUD showSuccessWithStatus:baseData.msg];
            
            // 修改成功后2s自动返回上一级
            [NSTimer scheduledTimerWithTimeInterval:1.0
                                             target:self
                                           selector:@selector(BackLastView:)
                                           userInfo:nil
                                            repeats:NO];
                        
        }else
        {

            [SVProgressHUD showErrorWithStatus:baseData.msg];
            
        }
    } failured:^(NSError* error)
     {
         NSLog(@"error:%@",error.description);
         
         [SVProgressHUD showErrorWithStatus:error.description];
     }];
}

- (IBAction)savePSWClicked:(id)sender {
    
    [self.view endEditing:YES];
    
    // 请求服务器
    [self requestSubmit];
    
}

- (IBAction)BackLastView:(id)sender {
    
    [self goBack];
    
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField  resignFirstResponder];
    
    return YES;
}

@end
