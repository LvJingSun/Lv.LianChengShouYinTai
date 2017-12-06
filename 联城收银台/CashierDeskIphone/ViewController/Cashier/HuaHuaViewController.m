//
//  HuaHuaViewController.m
//  CashierDeskIphone
//
//  Created by mac on 16/8/1.
//  Copyright © 2016年 MaxLinksTec. All rights reserved.
//

#import "HuaHuaViewController.h"

#import "CommonUtil.h"

#import "HttpClientRequest.h"

#import "SVProgressHUD.h"

#import "Configuration.h"


@interface HuaHuaViewController ()

@property (nonatomic, weak) UITextField *phoneField;

@property (nonatomic, weak) UITextField *countField;

@property (nonatomic, weak) UILabel *yuelab;

@end

@implementation HuaHuaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"花花充值";
    
    [self setTheView];
    
    [self requestYuE];
    
}

- (void)setTheView {
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    UILabel *yue = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 30)];
    
    self.yuelab = yue;
    
    yue.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:yue];

    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(width * 0.132, 50, width * 0.268, 40)];
    
    lab1.text = @"手机号：";
    
    lab1.font = [UIFont systemFontOfSize:15];
    
    [self.view addSubview:lab1];
    
    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(width * 0.132, CGRectGetMaxY(lab1.frame) + 20, width * 0.268, 40)];
    
    lab2.text = @"金额：";
    
    lab2.font = [UIFont systemFontOfSize:15];
    
    [self.view addSubview:lab2];
    
    UITextField *phoneField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lab1.frame), 50, width * 0.4, 40)];
    
    self.phoneField = phoneField;
    
    phoneField.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:phoneField];
    
    UITextField *countField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lab1.frame), CGRectGetMaxY(phoneField.frame) + 20, width * 0.4, 40)];
    
    self.countField = countField;
    
    countField.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:countField];
    
    UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake((width - 200) * 0.5, CGRectGetMaxY(countField.frame) + 50, 200, 40)];
    
    [sureBtn setBackgroundImage:[UIImage imageNamed:@"button_confirm.png"] forState:UIControlStateNormal];
    
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:sureBtn];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    if ([self.phoneField isFirstResponder]) {
        
        [self.phoneField resignFirstResponder];
        
    }
    
    if ([self.countField isFirstResponder]) {
        
        [self.countField resignFirstResponder];
        
    }
    
}

- (void)sureBtnClick {
    
    if ([self.phoneField isFirstResponder]) {
        
        [self.phoneField resignFirstResponder];
        
    }
    
    if ([self.countField isFirstResponder]) {
        
        [self.countField resignFirstResponder];
        
    }

    if ([self.phoneField.text isEqualToString:@""]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请输入手机号" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        
        [alert show];
        
    }else if ([self.countField.text isEqualToString:@""]) {
    
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请输入充值数量" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        
        [alert show];
        
    }else {
    
        [self requestData];
        
    }
    
}

- (void)requestData{
    
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    // 刷新请求数据接口 ======== status 状态的值 ========
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                self.phoneField.text,@"phone",
                                memberId, @"cashierAccountId",
                                self.countField.text,@"huahua",
                                nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [requstClient request:@"PaymentCheck_huahua.ashx" parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
//        [SVProgressHUD dismiss];
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        BOOL success = [handlJson[@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD showSuccessWithStatus:handlJson[@"msg"]];
            
            self.countField.text = @"";
            
            [self requestYuE];
            
        }else {
        
            [SVProgressHUD showErrorWithStatus:handlJson[@"msg"]];
            
        }
        
    } failured:^(NSError* error)
     {
         
         [SVProgressHUD showErrorWithStatus:error.description];
     }];
    
    
}

- (void)requestYuE {

    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    // 刷新请求数据接口 ======== status 状态的值 ========
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId, @"CashierAccountID",
                                nil];
    
    NSLog(@"%@",parameters);
    
    [requstClient request:@"Gethuahuabalance.ashx" parameters:parameters successed:^(JSONDecoder*json,id responseObject){

        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        BOOL success = [handlJson[@"status"] boolValue];
        
        if (success) {
            
            self.yuelab.text = [NSString stringWithFormat:@"余额：%@",((NSDictionary *)(handlJson[@"yuEMore"]))[@"Balance"]];
            
        }else {
            
//            [SVProgressHUD showErrorWithStatus:handlJson[@"msg"]];
            
        }
        
    } failured:^(NSError* error)
     {
         NSLog(@"%@",error.description);
//         [SVProgressHUD showErrorWithStatus:error.description];
     }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    self.navigationController.navigationBarHidden = NO;
    
    NSUserDefaults*pushJudge = [NSUserDefaults standardUserDefaults];
    if([[pushJudge objectForKey:@"push"]isEqualToString:@"push"]) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(rebackToRootViewAction)];
        
        self.navigationItem.rightBarButtonItems = nil;
        
    }
    
}

- (void)rebackToRootViewAction {
    NSUserDefaults * pushJudge = [NSUserDefaults standardUserDefaults];
    [pushJudge setObject:@""forKey:@"push"];
    [pushJudge synchronize];//记得立即同步
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
