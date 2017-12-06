//
//  MoreViewController.m
//  CashierDeskIphone
//
//  Created by mac on 13-9-8.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "MoreViewController.h"
#import "UserInfoView.h"
#import "ModifierPSWViewController.h"
#import "AboutViewController.h"
#import "HelpViewController.h"
#import "CommonUtil.h"
#import "UIImageView+AFNetworking.h"
#import "RefreshData.h"
#import "HttpClientRequest.h"
#import "SVProgressHUD.h"
#import "Configuration.h"
#import "MyCoderViewController.h"

@interface MoreViewController ()

@property(nonatomic,weak)IBOutlet UITableView* tableView;
@end

@implementation MoreViewController


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

    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // 版本判断
//    if ( isIOS7 ) {
//        
//        if ( iPhone5 ) {
//            
//             [self.tableView setFrame:CGRectMake(0, 20, 320, [[UIScreen mainScreen]bounds].size.height - 20 - 20)];
//        }else{
//            
//             [self.tableView setFrame:CGRectMake(0, 20, 320, [[UIScreen mainScreen]bounds].size.height + 48)];
//        }
//        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    
        label.backgroundColor = [UIColor blackColor];
        
        [self.view addSubview:label];
//
//    }else{
    
        [self.tableView setFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 68)];
//    }
        
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    // 请求数据刷新用户信息
    [self refreshData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableviewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ( section == 3 ) {
        
        return 4;
        
    }else{
        
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( indexPath.section == 0 ) {
        
        static NSString* identifier = @"cellIdentifier";
        
        UserInfoView *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil) {
            
            NSArray* bundles = [[NSBundle mainBundle]loadNibNamed:@"UserInfoView" owner:self options:nil];
            
            cell = (UserInfoView *)[bundles objectAtIndex:0];
            
            cell.backgroundColor = [UIColor clearColor];
            
            // 设置cell的背景图片
            UIImageView *image = [[UIImageView alloc]initWithFrame:cell.frame];
            image.image = [UIImage imageNamed:@"more_head_panel.png"];
            
            cell.backgroundView = image;
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        // cell上按钮触发的事件
        [cell.m_logoutBtn addTarget:self action:@selector(loginOut) forControlEvents:UIControlEventTouchUpInside];
        
        // 赋值
        cell.m_userNameLabel.text = [CommonUtil getValueByKey:NICK];
                
        cell.m_timeLabel.text = [NSString stringWithFormat:@"上次登录：%@",[CommonUtil getValueByKey:LASTLOGINTIME]];
        
        cell.m_nameLabel.text = [CommonUtil getValueByKey:MCTNAME];
        
        cell.m_areaLabel.text = [CommonUtil getValueByKey:SHOPNAME];
        
        cell.m_addressLabel.text = [CommonUtil getValueByKey:ADDRESS];
        
        cell.m_userNameLabel.text = [NSString stringWithFormat:@"%@（%@）",[CommonUtil getValueByKey:NICK],[CommonUtil getValueByKey:PHONE]];
                
        // 对图片赋值
        [cell setValue];

        return cell;
        
    }else if ( indexPath.section == 1 ){
        
        static NSString* identifier = @"ReceivablesCellIdentifier";
        
        ReceivablesCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil) {
            
            NSArray* bundles = [[NSBundle mainBundle]loadNibNamed:@"UserInfoView" owner:self options:nil];
            
            cell = (ReceivablesCell *)[bundles objectAtIndex:1];
            
            cell.backgroundColor = [UIColor clearColor];
            
            // 设置cell的背景图片
            UIImageView *image = [[UIImageView alloc]initWithFrame:cell.frame];
            image.image = [UIImage imageNamed:@"more_mid_panel.png"];
            
            cell.backgroundView = image;
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

        }
        
        // 刷新数据
        [cell.m_RefreshBtn addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventTouchUpInside];

        // 赋值
        cell.m_timeLabel.text = [NSString stringWithFormat:@"统计时间：%@",[CommonUtil getValueByKey:STATISTDATE]];
        
        cell.m_todayLabel.text = [NSString stringWithFormat:@"今日收款%@笔",[CommonUtil getValueByKey:DAYCOUNT]];
        
        cell.m_todayPrice.text = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:DAYMONEY]];
        
        cell.m_weekLabel.text = [NSString stringWithFormat:@"本周收款%@笔",[CommonUtil getValueByKey:WEEKCOUNT]];
        
        cell.m_weekPrice.text = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:WEEKMONEY]];
        
        cell.m_monthLabel.text = [NSString stringWithFormat:@"本月收款%@笔",[CommonUtil getValueByKey:MONTHCOUNT]];
        
        cell.m_monthPrice.text = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:MONTHMONEY]];
                
        return cell;

        
    }else if ( indexPath.section == 3 ){
        
//        if ( indexPath.row == 4 ) {
//            
//            
//            static NSString* identifier = @"versionCellIdentifier";
//            
//            VersionCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//            
//            if (cell == nil) {
//                
//                NSArray* bundles = [[NSBundle mainBundle]loadNibNamed:@"UserInfoView" owner:self options:nil];
//                
//                cell = (VersionCell *)[bundles objectAtIndex:3];
//                                
//                // 设置cell的背景图片
//                UIImageView *image = [[UIImageView alloc]initWithFrame:cell.frame];
//               
//                image.image = [UIImage imageNamed:@"cell_foot.png"];
//                
//                cell.backgroundView = image;
//                
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//               
//            }
//            
//            // 版本升级
//            [cell.m_updateBtn addTarget:self action:@selector(updateVersion) forControlEvents:UIControlEventTouchUpInside];
//            
//            // 将本身的版本与服务器端请求的数据进行比较，若相同则不升级；反之升级
//            NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
//            
//            cell.m_versionLabel.text = [NSString stringWithFormat:@"当前版本：%@",version];
//            
//
//            if ( [version isEqualToString:[CommonUtil getValueByKey:VERSION]] ) {
//                
//                cell.m_newVersionLabel.text = @"此版本为最新版本";
//                
//                cell.m_updateBtn.enabled = NO;
//                
//            }else{
//                
//                cell.m_newVersionLabel.text = @"已有新版本，可立即升级";
//                
//                cell.m_updateBtn.enabled = YES;
//                
//            }
//            
//                    
//             return cell;
//            
//        }else{
        
            static NSString* identifier = @"customCellIdentifier";
            
            CommonCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            
            if (cell == nil) {
                
                NSArray* bundles = [[NSBundle mainBundle]loadNibNamed:@"UserInfoView" owner:self options:nil];
                
                cell = (CommonCell *)[bundles objectAtIndex:2];
                
                // 设置cell的背景图片
                UIImageView *image = [[UIImageView alloc]initWithFrame:cell.frame];
                
                if ( indexPath.row == 0 ) {
                    
                    image.image = [UIImage imageNamed:@"cell_head.png"];

                }else{
                    
                    image.image = [UIImage imageNamed:@"cell_body_repeat.png"];
                    
                    // 设置分割线的坐标大小
                    if ( isIOS7 ) {
                        
                        
                        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 49, 320, 0.5)];
                        
                        imgV.image = [UIImage imageNamed:@"cell_line_repeat.png"];
                        
                        [cell.contentView addSubview:imgV];
                        
                    }else{
                        
                        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(-1, 49, 302, 0.5)];
                        
                        imgV.image = [UIImage imageNamed:@"cell_line_repeat.png"];
                        
                        [cell.contentView addSubview:imgV];
                        
                    }

                }
                
                cell.backgroundView = image;
                
        }
            
            if ( indexPath.row == 0 ) {
                
                cell.selectionStyle = UITableViewCellSelectionStyleGray;

                cell.m_nameLabel.text = @"修改登录密码";
                
                cell.m_accessImgV.hidden = NO;
                
                cell.accessoryView = nil;

           
            }else if ( indexPath.row == 1 ){
                
                cell.selectionStyle = UITableViewCellSelectionStyleGray;

                cell.m_nameLabel.text = @"关于我们";
                
                cell.m_accessImgV.hidden = NO;
                
                cell.accessoryView = nil;

            }else if ( indexPath.row == 2 ){
                
                cell.selectionStyle = UITableViewCellSelectionStyleGray;
                
                cell.m_nameLabel.text = @"帮助";
                
                cell.m_accessImgV.hidden = NO;
                
                cell.accessoryView = nil;

            }else if ( indexPath.row == 3 ){
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.m_nameLabel.text = @"其他App";
                
                cell.m_accessImgV.hidden = YES;
                
                // 添加其他的app，点击进入下载的地址
                UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
                view.backgroundColor = [UIColor clearColor];
                
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.backgroundColor = [UIColor clearColor];
                btn.frame = CGRectMake(0, 0, 44, 44);
                btn.tag = 11;
                [btn setImage:[UIImage imageNamed:@"logo_more.png"] forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(goAppStore:) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:btn];
                
                UIButton *huihuiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                huihuiBtn.backgroundColor = [UIColor clearColor];
                [huihuiBtn setImage:[UIImage imageNamed:@"logo_huihui.png"] forState:UIControlStateNormal];
                huihuiBtn.frame = CGRectMake(30, 0, 44, 44);
                huihuiBtn.tag = 12;
                [huihuiBtn addTarget:self action:@selector(goAppStore:) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:huihuiBtn];
                
                UIButton *bossBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                bossBtn.backgroundColor = [UIColor clearColor];
                [bossBtn setImage:[UIImage imageNamed:@"logo_boss.png"] forState:UIControlStateNormal];
                bossBtn.frame = CGRectMake(60, 0, 44, 44);
                bossBtn.tag = 13;
                [bossBtn addTarget:self action:@selector(goAppStore:) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:bossBtn];
                
                cell.accessoryView = view;
                
            }
            
                        
            return cell;
            
        
//        }

    }else{
        
        static NSString* identifier = @"customCellIdentifier";
        
        CommonCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil) {
            
            NSArray* bundles = [[NSBundle mainBundle]loadNibNamed:@"UserInfoView" owner:self options:nil];
            
            cell = (CommonCell *)[bundles objectAtIndex:2];
            
            // 设置cell的背景图片
            UIImageView *image = [[UIImageView alloc]initWithFrame:cell.frame];
            
            image.image = [UIImage imageNamed:@"cell_single.png"];
            
            cell.backgroundView = image;

            cell.selectionStyle = UITableViewCellSelectionStyleGray;
        }
        
        
        cell.m_nameLabel.text = @"我的二维码";
        
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ( indexPath.section == 3 ) {
        
        if ( indexPath.row == 0 ) {
            
            // 进入修改密码的页面            
            ModifierPSWViewController *viewController = [[ModifierPSWViewController alloc]initWithNibName:@"ModifierPSWViewController" bundle:nil];
            
            [self.navigationController pushViewController:viewController animated:YES];
        
        }else if ( indexPath.row == 1 ){
            
            // 进入关于页面
            AboutViewController *VC = [[AboutViewController alloc]initWithNibName:@"AboutViewController" bundle:nil];
            
            [self.navigationController pushViewController:VC animated:YES];

        }else if ( indexPath.row == 2 ){
            
            // 帮助页面
            HelpViewController *VC = [[HelpViewController alloc]initWithNibName:@"HelpViewController" bundle:nil];
            
            [self.navigationController pushViewController:VC animated:YES];
            
        }else if ( indexPath.row == 3 ){
             // 其他App的点击
            
            NSLog(@"其他App的点击");
            
        }else{
            
            
        }
    }else if ( indexPath.section == 2 ){
        
        if ( indexPath.row == 0 ) {
            
             // 进入我的二维码页面
            MyCoderViewController *viewController = [[MyCoderViewController alloc]initWithNibName:@"MyCoderViewController" bundle:nil];
            [self.navigationController pushViewController:viewController animated:YES];
            
        }
        
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if ( section == 0 ) {
        
        return 10.0f;
    
    }else{
        
        return 1.0f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return 145.0f;
        
    }else if ( indexPath.section == 1 ){
        
        return 115.0f;
        
    }else if ( indexPath.section == 2 ){
        
        return 50.0f;
   
    }else {
        
        if ( indexPath.row == 4 ) {
            
            return 65.0f;
            
        }else //if ( indexPath.row == 0  ){
            
            return 50.0f;
            
        }
}

#pragma mark - btn clicked
- (void)loginOut{
        
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@""
                                                       message:@"您确定退出账号？"
                                                      delegate:self
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:@"取消", nil];
    
    alertView.tag = 1234;
    
    [alertView show];
}
#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 1234 ) {
        
        if ( buttonIndex == 0 ) {
            
             [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
        }else{
            
            
        }
    }
}

- (void)refreshData{
        
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
        
    // 刷新请求数据接口
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId, @"cashierAccountId",
                                key,@"key",nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [requstClient request:CDHTTPRequestReshData parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
         RefreshData *reshData = [[RefreshData alloc]initWithJsonObject:handlJson];
                 
        BOOL success = [reshData.status boolValue];
        
        if (success) {
            
            // 保存数据，更新数据
          
            [CommonUtil addValue:reshData.DayReceivablesCount andKey:DAYCOUNT];
            
            [CommonUtil addValue:reshData.DayReceivablesMoney andKey:DAYMONEY];
            
            [CommonUtil addValue:reshData.MonthReceivablesCount andKey:MONTHCOUNT];
            
            [CommonUtil addValue:reshData.MonthReceivablesMoney andKey:MONTHMONEY];
            
            [CommonUtil addValue:reshData.WorkReceivablesCount andKey:WEEKCOUNT];
            
            [CommonUtil addValue:reshData.WeekReceivablesMoney andKey:WEEKMONEY];
            
            [CommonUtil addValue:reshData.StatisticalDate andKey:STATISTDATE];
            
            [self.tableView reloadData];
            
            [SVProgressHUD dismiss];
            
        }else
        {
            
            [SVProgressHUD showErrorWithStatus:reshData.msg];
            
        }
    } failured:^(NSError* error)
     {
         
         [SVProgressHUD showErrorWithStatus:error.description];
     }];
        
}

- (void)updateVersion{
        
    // 点击进入版本升级的url-appStore下载的地址
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[CommonUtil getValueByKey:APPURL]]];
}

// 点击图标进入appStore进行下载
- (void)goAppStore:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    if ( btn.tag == 11 ) {
        
        // 进入保智付的appStore的下载地址
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/bao-zhi-fu/id671424849?mt=8"]];
        
       
    }else if ( btn.tag == 12 ){
        
        // 点击进入诲诲的下载地址
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/hui-hui/id796827489?ls=1&mt=8"]];
   
    }else{
        
        // 点击进入老板驾驶舱的下载地址
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/lao-ban-jia-shi-cang/id789651951?ls=1&mt=8"]];
        
    }
    
 
}


@end
