//
//  upcardchoseViewController.m
//  CashierDeskIphone
//
//  Created by 冯海强 on 15-4-20.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "upcardchoseViewController.h"
#import "PrepaidrecordsViewController.h"
#import "HuaHuaRecordsController.h"
@interface upcardchoseViewController ()

@end

@implementation upcardchoseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.translucent = NO;
    
    if ([self.type isEqualToString:@"huiyuan"]) {
        
        self.titlelab.text = @"会员卡充值";
        
        self.saomiaoBtn.hidden = NO; 
        
    }else if ([self.type isEqualToString:@"huahua"]) {
    
        self.titlelab.text = @"花花充值";
        
        self.saomiaoBtn.hidden = YES;
        
    }

    // 版本判断
    if ( isIOS7 ) {
        
        [self.m_titleVIew setFrame:CGRectMake(0, 20, 320, 48)];
        
        if ( iPhone5 ) {
            
            [self.m_tempView setFrame:CGRectMake(0, 68, 320, [[UIScreen mainScreen]bounds].size.height - 20 - 48)];
            
        }else{
            
            [self.m_tempView setFrame:CGRectMake(0, 68, 320, [[UIScreen mainScreen]bounds].size.height)];
            
        }
        
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
        label.backgroundColor = [UIColor blackColor];
        
        [self.view addSubview:label];
        
    }else{
        
        [self.m_titleVIew setFrame:CGRectMake(0, 0, 320, 48)];
        
        [self.m_tempView setFrame:CGRectMake(0, 48, 320, self.view.frame.size.height - 48)];
        
    }
    
    self.m_confirmView.layer.masksToBounds = YES;
    self.m_confirmView.layer.cornerRadius = 8.0;
    
    self.m_photoView.layer.masksToBounds = YES;
    self.m_photoView.layer.cornerRadius = 30.0;
    
    phonetextfield.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated
{
    [phonetextfield resignFirstResponder];
}

- (IBAction)backLastView:(id)sender {
    
    [self goBack];
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField;
{
    [self hideNumberPadKeyboard:nil];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    [textField resignFirstResponder];
    return YES;
}
#define myDotNumbers     @"0123456789.\n"
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    //输入字符限制
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:myDotNumbers]invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    if (filtered.length == 0 ) {
        //支持删除键
        if (textField.text.length ==11) {
            self.m_namelabel.text = @"--";
            self.m_moneylabel.text = @"￥--";
            self.m_photoView.image = [UIImage imageNamed:@"moren.png"];
        }
        return [string isEqualToString:@""];
    }else if (textField.text.length ==10){

        textField.text = [NSString stringWithFormat:@"%@%@",textField.text,string];
        
        if ([self.type isEqualToString:@"huiyuan"]) {
            
            [self initcardrequestSubmit:[NSString stringWithFormat:@"%@",phonetextfield.text] andqrCode:@""];
            
        }else if ([self.type isEqualToString:@"huahua"]) {
        
            [self yanzhengPhone:[NSString stringWithFormat:@"%@",phonetextfield.text] andqrCode:@""];
            
        }
        

    }else if (string.length ==11)
    {
        textField.text = [NSString stringWithFormat:@"%@%@",textField.text,string];
//        [self initcardrequestSubmit:[NSString stringWithFormat:@"%@",phonetextfield.text] andqrCode:@""];
        if ([self.type isEqualToString:@"huiyuan"]) {
            
            [self initcardrequestSubmit:[NSString stringWithFormat:@"%@",phonetextfield.text] andqrCode:@""];
            
        }else if ([self.type isEqualToString:@"huahua"]) {
            
            [self yanzhengPhone:[NSString stringWithFormat:@"%@",phonetextfield.text] andqrCode:@""];
            
        }
    }

    return YES;
}

- (NSString *)ittemDisposeIdcardNumber:(NSString *)idcardNumber {
    //星号字符串
    NSString *xinghaoStr = @"";
    //动态计算星号的个数
    for (int i  = 0; i < idcardNumber.length - 7; i++) {
        xinghaoStr = [xinghaoStr stringByAppendingString:@"*"];
    }
    //身份证号取前3后四中间以星号拼接
    idcardNumber = [NSString stringWithFormat:@"%@%@%@",[idcardNumber substringToIndex:3],xinghaoStr,[idcardNumber substringFromIndex:idcardNumber.length-4]];
    //返回处理好的身份证号
    return idcardNumber;
}

-(IBAction)SurePay:(id)sender
{
    if (phonetextfield.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"输入充值的手机号"];
        return;
    }else if (phonetextfield.text.length !=11){
        [SVProgressHUD showErrorWithStatus:@"请正确输入手机号"];
        return;
    }else if ([self.m_namelabel.text isEqualToString:@""]){
        if ([self.type isEqualToString:@"huiyuan"]) {
            
            [self initcardrequestSubmit:[NSString stringWithFormat:@"%@",phonetextfield.text] andqrCode:@""];
            
        }else if ([self.type isEqualToString:@"huahua"]) {
        
            [self yanzhengPhone:[NSString stringWithFormat:@"%@",phonetextfield.text] andqrCode:@""];
            
        }
    }else if ([firstmoney isEqualToString:@""]){
        [self Manuallyenter];
    }
    if ([self.type isEqualToString:@"huiyuan"]) {
        
        [self realycardrequestSubmit];
        
    }else if ([self.type isEqualToString:@"huahua"]) {
    
        [self huahuachongzhi];
        
    }
}

- (void)setphoto:(NSString *)path{
    
    
    UIImage *reSizeImage = [self.imageCache getImage:path];
    
    if (reSizeImage != nil) {
        self.m_photoView.image = reSizeImage;
        return;
    }
    
    // 图片加载
    [self.m_photoView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:path]] placeholderImage:[UIImage imageNamed:@"moren.png"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        
        self.m_photoView.image = image;
        
        [self.imageCache addImage:image andUrl:path];
        
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        
        self.m_photoView.image = [UIImage imageNamed:@"moren.png"];
    }];
    
}

//花花充值验证接口
- (void)yanzhengPhone:(NSString *)accountt andqrCode:(NSString *)qrCode{
    
    [phonetextfield resignFirstResponder];
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
//    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
//    NSString *key = [CommonUtil getServerKey];
    
    // 刷新请求数据接口
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                accountt,@"phone",
                                memberId,@"CashierAccountID",
                                nil];
    
    NSLog(@"验证：%@",parameters);
    
    [SVProgressHUD showWithStatus:@"信息检测中..."];
    
    [requstClient request:@"NewVerifymember.ashx" parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            self.m_namelabel.text = [handlJson objectForKey:@"RealName"];
//            VipCardRecordId = [handlJson objectForKey:@"VipCardRecordId"];
            [self setphoto:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"PhotoBigUrl"]]];
            phonetextfield.text = accountt;
            [self Manuallyenter];
            
        }else
        {
            self.m_namelabel.text = @"--";
            self.m_moneylabel.text = @"￥--";
            self.m_photoView.image = [UIImage imageNamed:@"moren.png"];
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
        }
    } failured:^(NSError* error)
     {
         self.m_namelabel.text = @"--";
         self.m_moneylabel.text = @"￥--";
         self.m_photoView.image = [UIImage imageNamed:@"moren.png"];
         [SVProgressHUD showErrorWithStatus:error.description];
     }];
    
}


//会员卡充值验证接口
- (void)initcardrequestSubmit:(NSString *)accountt andqrCode:(NSString *)qrCode{
    
    [phonetextfield resignFirstResponder];
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    // 刷新请求数据接口
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"cashierAccountID",
                                accountt,@"account",
                                @"",@"amount",
                                qrCode,@"qrCode",
                                key,@"key",nil];
    
    [SVProgressHUD showWithStatus:@"信息检测中..."];
    
    [requstClient request:@"VIPCardRechargeCheck.ashx" parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            self.m_namelabel.text = [handlJson objectForKey:@"RealName"];
            VipCardRecordId = [handlJson objectForKey:@"VipCardRecordId"];
            [self setphoto:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"PhotoBigUrl"]]];
            phonetextfield.text = [NSString stringWithFormat:@"%@",[handlJson objectForKey:@"Account"]];
            [self Manuallyenter];

        }else
        {
            self.m_namelabel.text = @"--";
            self.m_moneylabel.text = @"￥--";
            self.m_photoView.image = [UIImage imageNamed:@"moren.png"];
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
        }
    } failured:^(NSError* error)
     {
         self.m_namelabel.text = @"--";
         self.m_moneylabel.text = @"￥--";
         self.m_photoView.image = [UIImage imageNamed:@"moren.png"];
         [SVProgressHUD showErrorWithStatus:error.description];
     }];
    
}

-(void)Manuallyenter{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"输入会员卡充值金额" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    UITextField *manualalt = [alert textFieldAtIndex:0];
    manualalt.keyboardType = UIKeyboardTypeNumberPad;
    alert.tag =111;
    [alert show];
    
}

-(void)AgainManuallyenter{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"再次确认金额" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    UITextField *manualalt = [alert textFieldAtIndex:0];
    manualalt.keyboardType = UIKeyboardTypeNumberPad;
    alert.tag =112;
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([alertView cancelButtonIndex] != buttonIndex) {
        UITextField *messageTextField = [alertView textFieldAtIndex:0];
        if (messageTextField.text.length > 0){
            if (alertView.tag ==111) {
                firstmoney = messageTextField.text;
                [self AgainManuallyenter];
            }else if (alertView.tag ==112){
                if ([firstmoney isEqualToString:messageTextField.text]) {
                    self.m_moneylabel.text = [NSString stringWithFormat:@"￥%@",messageTextField.text];
                }else{
                    firstmoney = @"";
                    [SVProgressHUD showErrorWithStatus:@"两次金额不一样"];
                }
            }
            
        }else
        {
            firstmoney = @"";
            [SVProgressHUD showErrorWithStatus:@"请输入金额"];
        }

    }else
    {
        firstmoney = @"";
     }
}

//充值花花
- (void)huahuachongzhi{
    
    [phonetextfield resignFirstResponder];
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
//    NSString *key = [CommonUtil getServerKey];
    
    // 刷新请求数据接口
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                phonetextfield.text,@"phone",
                                memberId, @"cashierAccountId",
                                firstmoney,@"huahua",
                                nil];
    
    [SVProgressHUD showWithStatus:@"花花充值中..."];
    
    [requstClient request:@"PaymentCheck_huahua.ashx" parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        NSDictionary* handlJson = [json objectWithData:data];
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(backLastView:) userInfo:nil repeats:NO];
            
            
        }else
        {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
        }
    } failured:^(NSError* error)
     {
         [SVProgressHUD showErrorWithStatus:error.description];
     }];
    
}


- (void)realycardrequestSubmit{
    
    [phonetextfield resignFirstResponder];
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    // 刷新请求数据接口
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"cashierAccountID",
                                firstmoney,@"amount",
                                VipCardRecordId,@"vipCardRecordId",
                                key,@"key",nil];
    
    [SVProgressHUD showWithStatus:@"会员卡充值中..."];
    
    [requstClient request:@"VIPCardRecharge.ashx" parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        NSDictionary* handlJson = [json objectWithData:data];
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(backLastView:) userInfo:nil repeats:NO];

            
        }else
        {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
        }
    } failured:^(NSError* error)
     {
         [SVProgressHUD showErrorWithStatus:error.description];
     }];
    
}


-(IBAction)sweep:(id)sender
{
    //扫描会员卡二维码 
    ZXingWidgetController *widController = [[ZXingWidgetController alloc] initWithDelegate:self showCancel:YES OneDMode:NO withType:3];
    
    NSMutableSet *readers = [[NSMutableSet alloc] init];
    QRCodeReader *qrcodeReader = [[QRCodeReader alloc] init];
    [readers addObject:qrcodeReader];
    widController.readers = readers;
    
    NSBundle *mainBundle = [NSBundle mainBundle];
    widController.soundToPlay = [NSURL fileURLWithPath:[mainBundle pathForResource:@"beep-beep" ofType:@"caf"] isDirectory:YES];
    
    [self.navigationController pushViewController:widController animated:YES];
}


#pragma mark ZxingDelegate
- (void)zxingController:(ZXingWidgetController*)controller didScanResult:(NSString *)result {
    
    [self initcardrequestSubmit:@"" andqrCode:result];

    [self.navigationController popViewControllerAnimated:YES];
        
}

- (void)zxingControllerDidCancel:(ZXingWidgetController*)controller {
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(IBAction)Cardrecordbtn:(id)sender{
    
//    if ([self.type isEqualToString:@"huiyuan"]) {
    
    PrepaidrecordsViewController *VC = [[PrepaidrecordsViewController alloc]initWithNibName:@"PrepaidrecordsViewController" bundle:nil];
    
    VC.type = self.type;
    
    [self.navigationController pushViewController:VC animated:YES];
        
//    }else if ([self.type isEqualToString:@"huahua"]) {
//    
//        HuaHuaRecordsController *vc = [[HuaHuaRecordsController alloc] init];
//        
//        [self.navigationController pushViewController:vc animated:YES];
//        
//    }

}


@end
