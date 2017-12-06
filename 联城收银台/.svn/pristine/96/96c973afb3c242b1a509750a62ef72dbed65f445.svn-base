//
//  ValidateResultViewController.m
//  CashierDeskIphone
//
//  Created by mac on 13-9-12.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "ValidateResultViewController.h"

#import "ValidateCell.h"

#import "KeyValidateData.h"

#import "BaseData.h"

@interface ValidateResultViewController ()

@end

@implementation ValidateResultViewController

@synthesize m_titleLabel;

@synthesize m_typeString;

@synthesize m_HeaderView;

@synthesize m_tableView;

@synthesize m_footerView;

@synthesize m_validateData;

@synthesize m_numberCount;

@synthesize m_usedKey;

@synthesize m_validateArray;

@synthesize m_keyCode;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_validateArray = [[NSMutableArray alloc]initWithCapacity:0];
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
            
              [self.m_tableView setFrame:CGRectMake(0, 68, 320, [[UIScreen mainScreen]bounds].size.height - 20 - 48)];
        }else{
            
              [self.m_tableView setFrame:CGRectMake(0, 68, 320, [[UIScreen mainScreen]bounds].size.height)];
        }
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
        label.backgroundColor = [UIColor blackColor];
        
        [self.view addSubview:label];
        
    }else{
        
        [self.m_titleView setFrame:CGRectMake(0, 0, 320, 48)];
        
        [self.m_tableView setFrame:CGRectMake(0, 48, 320, self.view.frame.size.height - 48)];
    }
    
    
    self.m_tableView.tableHeaderView = self.m_HeaderView;
    
    self.m_tableView.tableFooterView = self.m_footerView;
    
    self.m_tableView.hidden = YES;
    
    if ( [self.m_typeString isEqualToString:@"1"] ) {
        
        self.m_titleLabel.text = @"手动收银";
        
        // 对tableView进行赋值
        [self setTableViewValue];
   
    }else{
        
        self.m_titleLabel.text = @"快速收银";
        
        NSLog(@"m_keyCode = %@",self.m_keyCode);
        
        // 二维码扫描的结果-请求数据
        [self requestScanSubmit];
        
    }
    
}

- (void) setTableViewValue{
    
    self.m_tableView.hidden = NO;
    
    // 赋值
    self.m_numberCount.text = [NSString stringWithFormat:@"%i",[self.m_validateData.memberKey count]];
    
    self.m_usedKey.text = [NSString stringWithFormat:@"%i",self.m_validateData.NormalCount];
    
    if ( self.m_validateData.NormalCount == 0 ) {
        
        self.m_sureBtn.enabled = NO;
        
    }else{
        
        self.m_sureBtn.enabled = YES;
        
    }
    
    // 判断将有效的key值加入数组
    for (int i = 0; i < [self.m_validateData.memberKey count]; i ++) {
        
        ValidateData *data = (ValidateData *)[self.m_validateData.memberKey objectAtIndex:i];
        
        if ( data.Status == 0 ) {
            
            [self.m_validateArray addObject:data.KeyCode];
            
        }
    }
    
    [self.m_tableView reloadData];
    
    NSLog(@"count = %i",self.m_validateArray.count);
    
}
// 二维码验证key值的数据请求
- (void)requestScanSubmit{
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
        
    // 刷新请求数据接口
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId, @"cashierAccountId",
                                key,@"key",
                                self.m_keyCode,@"keyCode",nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [requstClient request:CDHTTPRequestKeyValidate parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        KeyValidateData *keyData = [[KeyValidateData alloc]initWithJsonObject:handlJson];
        
        NSLog(@"handlJson = %@",handlJson);
                
        BOOL success = [keyData.status boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            self.m_validateData = keyData;
            
            
            // 赋值
            [self setTableViewValue];
            
            
        }else
        {
            
            [SVProgressHUD showErrorWithStatus:keyData.msg];
            
        }
    } failured:^(NSError* error)
     {
         NSLog(@"error:%@",error.description);
         
         [SVProgressHUD showErrorWithStatus:error.description];
     }];
 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backLastView:(id)sender {
    
    [self goBack];
}

- (IBAction)consoleSure:(id)sender {
    
    // 确认收银
    [self requestSubmit];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.m_validateData.memberKey count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"ValidateCellIdentifier";
    
    ValidateCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ValidateCell" owner:self options:nil];
        
        cell = (ValidateCell *)[nib objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 设置cell的背景图片
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:cell.frame];
        imageView.image = [UIImage imageNamed:@"key_item_background.png"];
        
        cell.backgroundView = imageView;
    }
    
    // 赋值
    ValidateData *data = (ValidateData *)[self.m_validateData.memberKey objectAtIndex:indexPath.row];
   
    cell.m_keyValueLabel.text = [NSString stringWithFormat:@"%@",data.KeyCode];
    
    // 0可以用 1、已使用 2、已过期 3、不存在、4 非本商户KEY值、-1其他错误 5未开始
    
    if ( data.Status == 0 ) {
        
        cell.m_stateLabel.text = @"可以用";
        
        cell.m_imageView.image = [UIImage imageNamed:@"icon_key_vaild.png"];
        
        cell.m_leftLabel.hidden = YES;
        
        cell.m_rightLabel.hidden = YES;
        
        
//        cell.m_stateLabel.hidden = YES;
        
    }else{
        
        cell.m_leftLabel.hidden = YES;
        
        cell.m_rightLabel.hidden = YES;
        
//        cell.m_stateLabel.hidden = NO;
        
        cell.m_imageView.image = [UIImage imageNamed:@"icon_key_novaild.png"];

        
        if ( data.Status == 1 ) {
            
            cell.m_stateLabel.text = @"已使用";
                        
        }else if ( data.Status == 2 ) {
            
            cell.m_stateLabel.text = @"已过期";
                        
        }else if ( data.Status == 3 ) {
            
            cell.m_stateLabel.text = @"不存在";
                    
        }else if ( data.Status == 4 ){
            
            cell.m_stateLabel.text = @"非本商户KEY值";
        
        }else if ( data.Status == -1 ){
            // 其他错误
            cell.m_stateLabel.text = @"其他错误";
                        
        }else if ( data.Status == 5 ){
            // 未开始
            cell.m_stateLabel.text = [NSString stringWithFormat:@"KEY值有效期%@~%@",data.KeyDateS,data.KeyDateE];
            
        }else{
            
            
        }
        
    }
  
        
    return cell;
    
}

// 请求数据
- (void)requestSubmit{
    
    if ( self.m_validateArray.count == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"没有可用的KEY值"];
        
        return;
    }
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    
    NSMutableString *str = [[NSMutableString alloc]init];
    
    for (int i = 0; i < [self.m_validateArray count]; i ++) {
        
        
        NSString *string = [self.m_validateArray objectAtIndex:i];
        
        if ( i == [self.m_validateArray count] - 1 ) {
            
            [str appendString:[NSString stringWithFormat:@"%@",string]];
            
            
        }else{
            
            [str appendString:[NSString stringWithFormat:@"%@,",string]];
        }
        
    }
    
    NSLog(@"str = %@",str);
        
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    NSLog(@"%@,%@",[CommonUtil getValueByKey:MEMBER_ID],[CommonUtil getServerKey]);
    
    // 刷新请求数据接口
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId, @"cashierAccountId",
                                key,@"key",
                                str,@"keyCode",nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [requstClient request:CDHTTPRequestConfirm parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        BaseRetData *Data = [[BaseRetData alloc]initWithJsonObject:handlJson];
                
        BOOL success = [Data.status boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            // 收银成功后返回上两个页面
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示"
                                                               message:Data.msg
                                                              delegate:self
                                                     cancelButtonTitle:@"确定"
                                                     otherButtonTitles: nil];
            alertView.tag = 1000;
            
            [alertView show];
            
        }else
        {
            
            [SVProgressHUD showErrorWithStatus:Data.msg];
            
            
        }
    } failured:^(NSError* error)
     {
         NSLog(@"error:%@",error.description);
         
         [SVProgressHUD showErrorWithStatus:error.description];
     }];
    
    
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 1000 ) {
        
        if ( buttonIndex == 0 ) {
            
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count] - 3] animated:YES];
        }
    }
}

- (void)viewDidUnload {
    [self setM_numberCount:nil];
    [self setM_usedKey:nil];
    [self setM_tableView:nil];
    [self setM_HeaderView:nil];
    [self setM_footerView:nil];
    [super viewDidUnload];
}
@end
