//
//  LoginViewController.m
//  CashierDeskIphone
//
//  Created by mac on 13-8-30.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "LoginViewController.h"
#import "checkBox.h"
#import "Configuration.h"
#import "ImageResource.h"
#import "CommonMethods.h"
#import "SVProgressHUD.h"
#import "HttpClientRequest.h"
#import "RootViewController.h"
#import "DateUtil.h"
#import "CommonUtil.h"
#import "JPUSHService.h"
#import "AppHttpClient.h"

@interface LoginViewController ()
@property(nonatomic,weak)IBOutlet UITextField* loginName;
@property(nonatomic,weak)IBOutlet UITextField* password;
@property(nonatomic,weak)IBOutlet checkBox* rememberName;
@property(nonatomic,weak)IBOutlet checkBox* rememberPwd;
@end

@implementation LoginViewController

@synthesize isCheckedUserName;

@synthesize isCheckedPassWord;


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
    
    self.navigationController.navigationBar.translucent = NO;

    
    self.loginName.delegate = self;
    self.password.delegate = self;
    
    // 判断是否保存了用户名和密码
    [self isValue];
    
    
    // 版本判断
    if ( isIOS7 ) {
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
        label.backgroundColor = [UIColor blackColor];
        
        [self.view addSubview:label];
        
    }else{
        
    }
    
      
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    // 判断用户名和密码是否保存，保存的话则从保存的内容里面取出，反之则赋值为空
    NSString *checkAccount = [CommonUtil getValueByKey:CHECK_ACCOUNT];
    
    if ([@"1" isEqualToString:checkAccount]) {
        
        [self.loginName setText:[CommonUtil getValueByKey:ACCOUNT]];
        
    } else {
        
        [self.loginName setText:@""];
    }
    
    NSString *checkPsssword = [CommonUtil getValueByKey:CHECK_PWD];
    
    if ([@"1" isEqualToString:checkPsssword]) {
        
        [self.password setText:[CommonUtil getValueByKey:PWD]];
        
    } else {
        
        [self.password setText:@""];
        
    }
}

- (void)isValue{
    
    NSString *checkAccount = [CommonUtil getValueByKey:CHECK_ACCOUNT];
    
    if ([@"1" isEqualToString:checkAccount]) {
        
        [self.loginName setText:[CommonUtil getValueByKey:ACCOUNT]];
        [self.rememberName setImage:[UIImage imageNamed:@"check_box_selected.png"] forState:UIControlStateNormal];
        [self.rememberName setTag:1001];
        
    } else {
        
        [self.loginName setText:@""];
        
        [self.rememberName setImage:[UIImage imageNamed:@"check_box_def.png"] forState:UIControlStateNormal];
        [self.rememberName setTag:1000];
    }
    
    NSString *checkPsssword = [CommonUtil getValueByKey:CHECK_PWD];
    
    if ([@"1" isEqualToString:checkPsssword]) {
        
        [self.password setText:[CommonUtil getValueByKey:PWD]];
        [self.rememberPwd setImage:[UIImage imageNamed:@"check_box_selected.png"] forState:UIControlStateNormal];
        [self.rememberPwd setTag:2001];
        
    } else {
        
        [self.password setText:@""];
        
        [self.rememberPwd setImage:[UIImage imageNamed:@"check_box_def.png"] forState:UIControlStateNormal];
        [self.rememberPwd setTag:2000];
    }
    
}

-(IBAction)login:(id)sender
{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString* userName = self.loginName.text;
    if (userName.length <= 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入用户名"];
        return;
    }
    NSString* password = self.password.text;
    if (password.length <= 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
  
    
//    保智付:PalyApple、保智付:PalyAndroid、保智付收银台:PalyCashierApple、保智付收银台:PalyCashierAndroid
    
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                userName, @"cashAccount",
                                password,@"cashPassword",
                                @"PalyCashierApple",@"versionType",nil];
    
    [SVProgressHUD showWithStatus:@"登录中"];
    
    [requstClient request:CDHTTPRequestLogin parameters:parameters successed:^(JSONDecoder*json,id responseObject){
      
        NSData* data = [NSData dataWithData:responseObject];
                
        NSDictionary* handlJson = [json objectWithData:data];
        
        UserInfoData *userInfoData = [[UserInfoData alloc]initWithJsonObject:handlJson];
        
        BOOL success = [userInfoData.status boolValue];
        
        if (success) {
            
            // 保存商户是点单模式还是美容模式 1表示点单 0表示美容模式
            [CommonUtil addValue:userInfoData.IsSelectSeat andKey:ISSELECTSEAT];
                       
            [self save:userInfoData withTime:userInfoData.sDatetime];
            
            [self loadRootViewController];
            [SVProgressHUD dismiss];
            
            [self addRegistrationID];
            
        }else
        {
            
            [CommonUtil addValue:self.loginName.text andKey:ACCOUNT];
            
            [CommonUtil addValue:self.password.text andKey:PWD];

            [SVProgressHUD showErrorWithStatus:userInfoData.msg];
            
        }
    } failured:^(NSError* error)
    {

        [SVProgressHUD showErrorWithStatus:error.description];
    }];
    
}

//添加极光推送ID
- (void)addRegistrationID {

    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    NSDictionary *param1 = [NSDictionary dictionaryWithObjectsAndKeys:
                            [CommonUtil getValueByKey:MEMBER_ID], @"memberID",
                            @"PhoneType_1",@"phoneType",
                            [JPUSHService registrationID],@"registrationID",
                            nil];

    [httpClient request:@"ErpMerchantCenterAdd.ashx" parameters:param1 success:^(NSJSONSerialization* json){

    }failure:^(NSError *error){

    }];
    
}

- (void)save:(UserInfoData*)info withTime:(NSString*)dateTime
{ 
    // 将服务器返回的数据保存起来
    NSTimeInterval timeDiff = [DateUtil computerServerTimeDiff:dateTime];
    
    [CommonUtil addValue:[NSString stringWithFormat:@"%.0f", timeDiff] andKey:SERVER_TIME_DIFF];
    
    [CommonUtil addValue:[NSString stringWithFormat:@"%ld", (long)[info.CashierAccountId integerValue]] andKey:MEMBER_ID];
   
    [CommonUtil addValue:self.loginName.text andKey:ACCOUNT];
   
    [CommonUtil addValue:self.password.text andKey:PWD];
    
    [CommonUtil addValue:info.RealName andKey:NICK];
    
    [CommonUtil addValue:info.Account andKey:PHONE];

    [CommonUtil addValue:info.Address andKey:ADDRESS];

    [CommonUtil addValue:info.DayReceivablesCount andKey:DAYCOUNT];

    [CommonUtil addValue:info.DayReceivablesMoney andKey:DAYMONEY];

    [CommonUtil addValue:info.MctLogo andKey:MCTLOGO];

    [CommonUtil addValue:info.MctName andKey:MCTNAME];

    [CommonUtil addValue:info.MonthReceivablesCount andKey:MONTHCOUNT];
    
    [CommonUtil addValue:info.MonthReceivablesMoney andKey:MONTHMONEY];

    [CommonUtil addValue:info.ShopName andKey:SHOPNAME];
    
    [CommonUtil addValue:info.StatisticalDate andKey:STATISTDATE];

    [CommonUtil addValue:info.WeekReceivablesCount andKey:WEEKCOUNT];

    [CommonUtil addValue:info.WeekReceivablesMoney andKey:WEEKMONEY];
    
    [CommonUtil addValue:info.LastLoginDate andKey:LASTLOGINTIME];
    
    [CommonUtil addValue:info.VersionNumber andKey:VERSION];
    
    [CommonUtil addValue:info.AppPkgUrl andKey:APPURL];
}

- (void)loadRootViewController
{
    RootViewController* rootViewController = [[RootViewController alloc]initWithNibName:@"RootViewController" bundle:nil];
    [self.navigationController pushViewController:rootViewController animated:YES];
}

- (IBAction)Selector:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if (btn.tag == 1000) {
        [CommonUtil addValue:@"1" andKey:CHECK_ACCOUNT];
        [self.rememberName setImage:[UIImage imageNamed:@"check_box_selected.png"] forState:UIControlStateNormal];
        [self.rememberName setTag:1001];
    } else if (btn.tag == 1001) {
        [CommonUtil addValue:@"0" andKey:CHECK_ACCOUNT];
        [self.rememberName setImage:[UIImage imageNamed:@"check_box_def.png"] forState:UIControlStateNormal];
        [self.rememberName setTag:1000];
    } else if (btn.tag == 2000) {
        [CommonUtil addValue:@"1" andKey:CHECK_PWD];
        [self.rememberPwd setImage:[UIImage imageNamed:@"check_box_selected.png"] forState:UIControlStateNormal];
        [self.rememberPwd setTag:2001];
    } else if (btn.tag == 2001) {
        [CommonUtil addValue:@"0" andKey:CHECK_PWD];
        [self.rememberPwd setImage:[UIImage imageNamed:@"check_box_def.png"] forState:UIControlStateNormal];
        [self.rememberPwd setTag:2000];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)hidenKeyboard
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];//关闭键盘

    [self.password resignFirstResponder];
    [self.loginName resignFirstResponder];
    [self resumeView];
    
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSTimeInterval animationDuration=0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    CGRect rect=CGRectMake(0.0f,-40,width,height);
    self.view.frame=rect;
    [UIView commitAnimations];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.loginName) {
       
        [self.password becomeFirstResponder];
    
    }else if (textField == self.password)
    {
        [self.loginName resignFirstResponder];
        [self.password resignFirstResponder];
        
        [self resumeView];
        
        // 键盘点击完成后自动请求数据
        [self login:nil];
    }
    return YES;
}

//恢复原始视图位置
-(void)resumeView
{
    NSTimeInterval animationDuration=0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    float Y = 0.0f;
    CGRect rect=CGRectMake(0.0f,Y,width,height);
    self.view.frame=rect;
    [UIView commitAnimations];
    
}


@end
