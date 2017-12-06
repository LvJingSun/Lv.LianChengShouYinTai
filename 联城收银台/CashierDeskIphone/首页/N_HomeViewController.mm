//
//  N_HomeViewController.m
//  CashierDeskIphone
//
//  Created by mac on 2017/3/8.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "N_HomeViewController.h"
#import "N_homeHeadView.h"
#import "ConsoleHandViewController.h"
#import "ZXingWidgetController.h"
#import <QRCodeReader.h>
#import "QuanquanResultViewController.h"
#import "ValidateResultViewController.h"
#import "N_homeCell.h"
#import "N_chongzhiCell.h"
#import "upcardchoseViewController.h"
#import "RowNumberController.h"
#import "QFFController.h"
#import "FSB_TypeViewController.h"
#import "RH_RechargeViewController.h"
#import "FSB_RechargeViewController.h"
#import "MemberShipRechargeViewController.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface N_HomeViewController () <UITableViewDelegate,UITableViewDataSource,ZXingDelegate> {

    NSString *staffType;
    
}

@property (nonatomic, weak) UITableView *tableview;

@end

@implementation N_HomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initWithTableview];
    
    [self requestForStaffType];
    
}

-(void)viewWillAppear:(BOOL)animated {

    [self requestForStaffType];
    
}

//请求收银员类型
- (void)requestForStaffType {

    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    // 刷新请求数据接口
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"CashierAccountID",
                                nil];
    
    [requstClient request:@"HaveBussniess.ashx" parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            
            staffType = [NSString stringWithFormat:@"%@",[handlJson objectForKey:@"IsState"]];
            
        }else
        {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
        }
    } failured:^(NSError* error)
     {
         
         [SVProgressHUD showErrorWithStatus:error.description];
         
     }];
    
}

- (void)initWithTableview {
    
    UILabel *lla = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    
    lla.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:lla];

    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT - 68)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    N_homeHeadView *headview = [[N_homeHeadView alloc] init];
    
    [headview.saomiaoBtn addTarget:self action:@selector(quickCash) forControlEvents:UIControlEventTouchUpInside];
    
    [headview.shouyinBtn addTarget:self action:@selector(handCash) forControlEvents:UIControlEventTouchUpInside];
    
    headview.frame = CGRectMake(0, 0, SCREEN_WIDTH, headview.height);
    
    tableview.tableHeaderView = headview;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:tableview];
    
}

- (void)quickCash {

    ZXingWidgetController *widController = [[ZXingWidgetController alloc] initWithDelegate:self showCancel:YES OneDMode:NO withType:1];

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
        
    // test ========= 如果扫描出来的字符包含|的话，则表示是券券收银的二维码扫描
    if ( [result rangeOfString:@"|"].location != NSNotFound ) {
        
        // 请求成功后进入券券验证的页面 券券验证结果页面
        QuanquanResultViewController *VC = [[QuanquanResultViewController alloc]initWithNibName:@"QuanquanResultViewController" bundle:nil];
        VC.m_quanquanString = [NSString stringWithFormat:@"%@",result];
        [self.navigationController pushViewController:VC animated:YES];
        
        
    }else{
        
        
        // 将字符进行裁剪，取出需要用的字符
        // 判断扫描的字符是一个还是多个，判断是否以[开头
        if ( [result hasPrefix:@"["] ) {
            
            //        self.m_ScanString = [result substringFromIndex:1];
            
            self.m_ScanString = [result substringWithRange:NSMakeRange(1, result.length - 2)];
            
            // 将“, ”替换为“,”
            self.m_ScanString = [self.m_ScanString stringByReplacingOccurrencesOfString:@", " withString:@","];
            
        }else{
            
            self.m_ScanString = [NSString stringWithFormat:@"%@",result];
        }
        
        // 扫描成功进入二维码扫描成功界面
        ValidateResultViewController *VC = [[ValidateResultViewController alloc]initWithNibName:@"ValidateResultViewController" bundle:nil];
        VC.m_keyCode = self.m_ScanString;
        
        [self.navigationController pushViewController:VC animated:YES];
        
        
    }

}

- (void)zxingControllerDidCancel:(ZXingWidgetController*)controller {
    //    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)handCash {

    ConsoleHandViewController *viewController = [[ConsoleHandViewController alloc]initWithNibName:@"ConsoleHandViewController" bundle:nil];
    
    [self.navigationController pushViewController:viewController animated:YES];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 4;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        N_chongzhiCell *cell = [[N_chongzhiCell alloc] init];
        
        [cell.button setTitle:@"会员卡充值" forState:0];
        
        [cell.button addTarget:self action:@selector(huiyuan) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
        
    }else {
    
        N_homeCell *cell = [[N_homeCell alloc] init];
        
        if (indexPath.row == 1) {
            
            [cell.button setTitle:@"粉丝宝&养车宝" forState:0];
            
            [cell.button addTarget:self action:@selector(quanfanfu) forControlEvents:UIControlEventTouchUpInside];
            
        }else if (indexPath.row == 2) {
            
            [cell.button setTitle:@"花花充值" forState:0];
            
            [cell.button addTarget:self action:@selector(huahua) forControlEvents:UIControlEventTouchUpInside];
            
        }else if (indexPath.row == 3) {
            
            [cell.button setTitle:@"排号系统" forState:0];
            
            [cell.button addTarget:self action:@selector(paihao) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
        return cell;
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        N_chongzhiCell *cell = [[N_chongzhiCell alloc] init];
        
        return cell.height;
        
    }else {
    
        N_homeCell *cell = [[N_homeCell alloc] init];
        
        return cell.height;
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)huiyuan {

//    upcardchoseViewController *VC = [[upcardchoseViewController alloc]initWithNibName:@"upcardchoseViewController" bundle:nil];
//
//    VC.type = @"huiyuan";
//
//    [self.navigationController pushViewController:VC animated:YES];
    
    MemberShipRechargeViewController *vc = [[MemberShipRechargeViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)quanfanfu {
    
    if ([staffType isEqualToString:@"1"]) {
        
        RH_RechargeViewController *vc = [[RH_RechargeViewController alloc] init];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([staffType isEqualToString:@"2"]) {
    
        FSB_RechargeViewController *vc = [[FSB_RechargeViewController alloc] init];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([staffType isEqualToString:@"3"]) {
    
        FSB_TypeViewController *vc = [[FSB_TypeViewController alloc] init];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}

- (void)huahua {

    upcardchoseViewController *VC = [[upcardchoseViewController alloc]initWithNibName:@"upcardchoseViewController" bundle:nil];
    
    VC.type = @"huahua";
    
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (void)paihao {

    RowNumberController *staffvc = [[RowNumberController alloc] init];
    
    [self .navigationController pushViewController:staffvc animated:YES];
    
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
