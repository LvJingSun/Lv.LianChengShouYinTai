//
//  FSB_RechargeViewController.m
//  CashierDeskIphone
//
//  Created by mac on 2017/6/16.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "FSB_RechargeViewController.h"
#import "FSB_Header.h"
#import "PersonInfoHeadView.h"
#import "UIImageView+AFNetworking.h"
#import "ErWeiMaView.h"
#import "FSB_TranInfoModel.h"
#import "FSB_InPutFrame.h"
#import "FSB_InPutCell.h"

#import "RedCopiesAlertView.h"
#import "Choose_CopiesFrame.h"
#import "Choose_CopiesModel.h"

#import "StaffAlertView.h"
#import "Choose_StaffModel.h"
#import "Choose_StaffFrame.h"

#import "InPutNameController.h"
#import "SureView.h"
#import "FSB_UpLoadViewController.h"
#import "FSB_ListViewController.h"

@interface FSB_RechargeViewController () <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,FSB_InPutDelegate> {

    NSString *checkPhone;
    
    //最低消费金额
    NSString *zuidixiaofei;
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) PersonInfoHeadView *headview;

@property (nonatomic, strong) NSMutableArray *array;

@property (nonatomic, strong) NSMutableArray *staffArr;

@property (nonatomic, strong) NSMutableArray *copiesArr;

@end

@implementation FSB_RechargeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"粉丝宝";
    
    [self allocWithTableview];
    
    [self requestErWeiMa];
    
    [self requestForCopies];
    
    [self requestForStaff];
    
    [self requestZuiDi];
    
    self.array = [NSMutableArray array];
    
    NSMutableArray *mut = [NSMutableArray array];
    
    FSB_InPutFrame *frame = [[FSB_InPutFrame alloc] init];
    
    FSB_TranInfoModel *model = [[FSB_TranInfoModel alloc] init];
    
    model.redType = @"1";
    
    model.merchantRedType = @"1";
    
    frame.tranModel = model;
    
    [mut addObject:frame];
    
    self.array = mut;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    self.navigationItem.rightBarButtonItem = [self SetNavigationBarRightTitle:@"明细" andaction:@selector(RechargeListClick)];
    
}

- (void)RechargeListClick {

    FSB_ListViewController *vc = [[FSB_ListViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark 键盘出现
- (void)keyboardWillShow:(NSNotification *)note {
    
    CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    self.tableview.contentInset = UIEdgeInsetsMake(0, 0, keyBoardRect.size.height, 0);
    
}

#pragma mark 键盘消失
- (void)keyboardWillHide:(NSNotification *)note {
    
    self.tableview.contentInset = UIEdgeInsetsZero;
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];

    [self requestYuE];
    
}

- (void)allocWithTableview {
    
    PersonInfoHeadView *headview = [[PersonInfoHeadView alloc] init];
    
    headview.frame = CGRectMake(0, 0, SCREENWIDTH, headview.height);
    
    self.headview = headview;
    
    headview.phoneField.delegate = self;
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64)];
    
    self.tableview = tableview;
    
    tableview.tableHeaderView = headview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = BGColor;
    
    [self.view addSubview:tableview];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.array.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FSB_InPutFrame *frame = self.array[indexPath.row];
    
    FSB_InPutCell *cell = [[FSB_InPutCell alloc] init];
    
    cell.frameModel = frame;
    
    cell.delegate = self;
    
    cell.productBlock = ^{
        
        InPutNameController *vc = [[InPutNameController alloc] init];
        
        [vc returnName:^(NSString *name) {
            
            frame.tranModel.productName = name;
            
            [self.tableview reloadData];
            
        }];
        
        [self presentViewController:vc animated:YES completion:nil];
        
    };
    
    cell.type_merchantBlock = ^{
        
        frame.tranModel.redType = @"1";
        
        [self.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
        
    };
    
    cell.type_pingtaiBlock = ^{
        
        frame.tranModel.redType = @"0";
        
        [self.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
        
    };
    
    cell.merchant_huiyuankaBlock = ^{
        
        frame.tranModel.merchantRedType = @"1";
        
        [self.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
        
    };
    
    cell.merchant_tixianBlock = ^{
        
        frame.tranModel.merchantRedType = @"2";
        
        [self.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
        
    };
    
    cell.redCopiesBlock = ^{
        
        //红包份数点击
        for (FSB_InPutFrame *frame in self.array) {
            
            if (![self isNULLString:frame.tranModel.redCopiesID]) {
                
                for (Choose_CopiesFrame *ff in self.copiesArr) {
                    
                    if ([ff.copiesmodel.CycleType isEqualToString:frame.tranModel.redCopiesID]) {
                        
                        ff.copiesmodel.isChoose = @"1";
                        
                    }else {
                        
                        ff.copiesmodel.isChoose = @"0";
                        
                    }
                    
                }
                
            }
            
        }
        
        RedCopiesAlertView *alert = [[RedCopiesAlertView alloc] init];
        
        alert.array = self.copiesArr;
        
        alert.choosecopies = ^(Choose_CopiesModel *copiesModel) {
            
            frame.tranModel.redCopiesID = copiesModel.CycleType;
            
            frame.tranModel.redCopiesName = copiesModel.length;
            
            [self.tableview reloadData];
            
            for (FSB_InPutFrame *frame in self.array) {
                
                if (![self isNULLString:frame.tranModel.redCount]) {
                    
                    //计算金种子
                    [self requestForJinCount];
                    
                }
                
            }
            
        };
        
        [alert showInView:self.view];
        
    };
    
    cell.staffBlock = ^{
        
        //促销员点击
        for (FSB_InPutFrame *frame in self.array) {
        
            if (![self isNULLString:frame.tranModel.staffID]) {
                
                for (Choose_StaffFrame *ff in self.staffArr) {
                    
                    if ([ff.staffmodel.CashierAccountID isEqualToString:frame.tranModel.staffID]) {
                        
                        ff.staffmodel.isChoose = @"1";
                        
                    }else {
                    
                        ff.staffmodel.isChoose = @"0";
                        
                    }
                    
                }
                
            }
            
        }
        
        StaffAlertView *alert = [[StaffAlertView alloc] init];
        
        alert.array = self.staffArr;
        
        alert.choosestaff = ^(Choose_StaffModel *staffModel) {
            
            frame.tranModel.staffID = staffModel.CashierAccountID;
            
            frame.tranModel.staffName = staffModel.RealName;
            
            [self.tableview reloadData];
            
        };
        
        [alert showInView:self.view];
        
    };
    
    cell.sureBlock = ^{
        
        //确认点击
        [self checkInPutInfo];
        
    };
    
    return cell;
    
}

//检查信息是否填写完整
- (void)checkInPutInfo {

    FSB_InPutFrame *frame = self.array[0];
    
    if ([self isNULLString:frame.tranModel.acount]) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入手机号检测"];
        
    }else if ([self isNULLString:frame.tranModel.productName]) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入商品信息"];
        
    }else if ([self isNULLString:frame.tranModel.tranCount]) {
    
        [SVProgressHUD showErrorWithStatus:@"请完善交易信息"];
        
    }else if ([self isNULLString:frame.tranModel.redCount]) {
        
        [SVProgressHUD showErrorWithStatus:@"请完善交易信息"];
        
    }else if ([self isNULLString:frame.tranModel.redCopiesID]) {
        
        [SVProgressHUD showErrorWithStatus:@"请完善交易信息"];
        
    }else if ([self isNULLString:frame.tranModel.goldCount]) {
        
        [SVProgressHUD showErrorWithStatus:@"请完善交易信息"];
        
    }else if ([self isNULLString:frame.tranModel.staffID]) {
        
        [SVProgressHUD showErrorWithStatus:@"请完善促销员信息"];
        
    }else {
    
        if ([frame.tranModel.redCount floatValue] >= [zuidixiaofei floatValue]) {
            
            FSB_UpLoadViewController *vc = [[FSB_UpLoadViewController alloc] init];
            
            vc.tranModel = frame.tranModel;
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }else {
        
            SureView *sureview = [[SureView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
            
            sureview.phoneLab.text = [NSString stringWithFormat:@"账户号码：%@",frame.tranModel.acount];
            
            sureview.productLab.text = [NSString stringWithFormat:@"商品名称：%@",frame.tranModel.productName];
            
            sureview.jineLab.text = [NSString stringWithFormat:@"红包金额：%@",frame.tranModel.redCount];
            
            sureview.zhouqiLab.text = [NSString stringWithFormat:@"红包份数：%@",frame.tranModel.redCopiesName];
            
            if ([frame.tranModel.redType isEqualToString:@"1"]) {
                
                sureview.countLab.text = [NSString stringWithFormat:@"积分：%@",frame.tranModel.jifen];
                
            }else if ([frame.tranModel.redType isEqualToString:@"0"]) {
                
                sureview.countLab.text = [NSString stringWithFormat:@"金种子数：%@",frame.tranModel.goldCount];
                
            }
            
            [sureview.sureBtn addTarget:self action:@selector(SendGoldForFSB) forControlEvents:UIControlEventTouchUpInside];
            
            [[[UIApplication sharedApplication].windows firstObject] addSubview:sureview];
            
        }
        
    }
    
}

//赠送金种子红包
- (void)SendGoldForFSB {
    
    FSB_InPutFrame *frame = self.array[0];
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];

    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                frame.tranModel.acount,@"phone",
                                memberId,@"CashierAccountID",
                                frame.tranModel.goldCount,@"jinzhongzi",
                                frame.tranModel.redCopiesID,@"CycleType",
                                frame.tranModel.redCopiesName,@"part",
                                frame.tranModel.tranCount,@"TranAccount",
                                frame.tranModel.productName,@"goodsname",
                                frame.tranModel.staffID,@"yuangong",
                                @"1",@"status",
                                frame.tranModel.redCount,@"allaccount",
                                frame.tranModel.redType,@"Types",
                                frame.tranModel.merchantRedType,@"mctMode",
                                frame.tranModel.jifen,@"Jifen",
                                nil];
    
    [SVProgressHUD showWithStatus:@"赠送中..."];
    
    [requstClient request:@"FansBusinessNew.ashx" parameters:parameters successed:^(JSONDecoder*json,id responseObject){
     
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
            [self saveProductName];
            
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
            
        }else
        {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
        }
        
    } failured:^(NSError* error)
     {
         
         [SVProgressHUD showErrorWithStatus:error.description];
         
     }];

    
}

//保存商品名
- (void)saveProductName {
    
    FSB_InPutFrame *frame = self.array[0];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSArray *lastArray = [defaults valueForKey:@"productNameArray"];
    
    NSMutableArray *productNameArray = [NSMutableArray array];
    
    [productNameArray addObjectsFromArray:lastArray];
    
    BOOL isContain = [lastArray containsObject:frame.tranModel.productName];
    
    if (!isContain) {
        
        [productNameArray addObject:frame.tranModel.productName];
        
    }
    
    [defaults setObject:productNameArray forKey:@"productNameArray"];
    
    [defaults synchronize];
    
}

- (BOOL)isNULLString:(NSString *)string {
    
    if (string == nil || string == NULL) {
        
        return YES;
        
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        
        return YES;
        
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        
        return YES;
        
    }
    
    return NO;
    
}

//商品名代理
- (void)ProductFieldChange:(UITextField *)field {

    for (FSB_InPutFrame *frame in self.array) {
        
        frame.tranModel.productName = [NSString stringWithFormat:@"%@",field.text];
        
    }
    
}

//积分代理
- (void)JiFenCountFieldChange:(UITextField *)field {
    
    for (FSB_InPutFrame *frame in self.array) {
        
        frame.tranModel.jifen = [NSString stringWithFormat:@"%@",field.text];
    }
    
}

//消费金额代理
- (void)TranCountFieldChange:(UITextField *)field {

    for (FSB_InPutFrame *frame in self.array) {
        
        frame.tranModel.tranCount = [NSString stringWithFormat:@"%@",field.text];
        
    }
    
}

//红包金额代理
- (void)RedCountFieldChange:(UITextField *)field {

    for (FSB_InPutFrame *frame in self.array) {
        
        frame.tranModel.redCount = [NSString stringWithFormat:@"%@",field.text];
        
    }
    
}

//红包金额输入完成代理
- (void)RedCountFieldEndChange:(UITextField *)field {

    for (FSB_InPutFrame *frame in self.array) {
    
        if (![self isNULLString:frame.tranModel.redCopiesID]) {
            
            //计算金种子
            [self requestForJinCount];
            
        }
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FSB_InPutFrame *frame = self.array[indexPath.row];
    
    CGFloat height = [frame getCellHeight];
    
    return height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

//获取最低消费金额
- (void)requestZuiDi{
    
    // 刷新请求数据接口
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    
    [requstClient request:@"ApplyAccount.ashx" parameters:[[NSDictionary alloc] init] successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            
            zuidixiaofei = [handlJson objectForKey:@"Totalnum"];
            
        }else
        {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
        }
    } failured:^(NSError* error)
     {
         
         [SVProgressHUD showErrorWithStatus:error.description];
         
     }];
    
}

//手机号输入11位自动检测
#define myDotNumbers     @"0123456789"
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
        
    //输入字符限制
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:myDotNumbers]invertedSet];
    
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    
    if (filtered.length == 0 ) {
        //支持删除键
        if (textField.text.length ==11) {
            
        }
        
        return [string isEqualToString:@""];
        
    }else if (textField.text.length ==10){
        
        textField.text = [NSString stringWithFormat:@"%@%@",textField.text,string];
        
        [self yanzhengPhone:[NSString stringWithFormat:@"%@",textField.text]];
        
    }else if (string.length ==11)
    {
        textField.text = [NSString stringWithFormat:@"%@%@",textField.text,string];
        
        [self yanzhengPhone:[NSString stringWithFormat:@"%@",textField.text]];
        
    }
    
    return YES;
    
}

//计算金种子请求
- (void)requestForJinCount {
    
    FSB_InPutFrame *frame = self.array[0];

    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                frame.tranModel.redCopiesID,@"CycleType",
                                frame.tranModel.redCount,@"account",
                                nil];
    
    [requstClient request:@"NewCountGld_1.ashx" parameters:parameters successed:^(JSONDecoder*json,id responseObject){
     
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            
            NSDictionary *dd = handlJson[@"ybtrList"];
            
            frame.tranModel.goldCount = [NSString stringWithFormat:@"%@",dd[@"Jinzhongzi"]];
            
            frame.tranModel.jifen = [NSString stringWithFormat:@"%.2f",[frame.tranModel.redCount floatValue] * 0.5];
            
            [self.tableview reloadData];
            
        }else {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
        }
        
    } failured:^(NSError* error){
         
         [SVProgressHUD showErrorWithStatus:error.description];
         
     }];
    
}

//请求红包份数数据
- (void)requestForCopies {
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    // 刷新请求数据接口
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"cashierAccountID",
                                nil];
    
    [requstClient request:@"Cycletype.ashx" parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            
            NSArray *tempArr = handlJson[@"ybtrList"];
            
            NSMutableArray *mut = [NSMutableArray array];
            
            for (NSDictionary *dd in tempArr) {
                
                Choose_CopiesModel *model = [[Choose_CopiesModel alloc] init];
                
                model.CycleType = [NSString stringWithFormat:@"%@",dd[@"CycleType"]];
                
                model.Rite = [NSString stringWithFormat:@"%@",dd[@"Rite"]];
                
                model.Name = [NSString stringWithFormat:@"%@",dd[@"Name"]];
                
                model.length = [NSString stringWithFormat:@"%@",dd[@"length"]];
                
                model.isChoose = @"0";
                
                Choose_CopiesFrame *frame = [[Choose_CopiesFrame alloc] init];
                
                frame.copiesmodel = model;
                
                [mut addObject:frame];
                
            }
            
            self.copiesArr = mut;
            
        }else
        {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
        }
    } failured:^(NSError* error)
     {
         
         [SVProgressHUD showErrorWithStatus:error.description];
         
     }];
    
}

//请求促销员数据
- (void)requestForStaff {

    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    // 刷新请求数据接口
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"cashierAccountID",
                                nil];
    
    [requstClient request:@"MctYuanGongList.ashx" parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            
            NSArray *tempArr = handlJson[@"ybtrList"];
            
            NSMutableArray *mut = [NSMutableArray array];
            
            for (NSDictionary *dd in tempArr) {
                
                Choose_StaffModel *model = [[Choose_StaffModel alloc] init];
                
                model.RealName = [NSString stringWithFormat:@"%@",dd[@"RealName"]];
                
                model.CashierAccountID = [NSString stringWithFormat:@"%@",dd[@"CashierAccountID"]];
                
                model.isChoose = @"0";
                
                Choose_StaffFrame *frame = [[Choose_StaffFrame alloc] init];
                
                frame.staffmodel = model;
                
                [mut addObject:frame];
                
            }
            
            self.staffArr = mut;
            
        }else
        {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
        }
    } failured:^(NSError* error)
     {
         
         [SVProgressHUD showErrorWithStatus:error.description];
         
     }];
    
}

//检测手机号
- (void)yanzhengPhone:(NSString *)account {
    
    if ([self.headview.phoneField isFirstResponder]) {
        
        [self.headview.phoneField resignFirstResponder];
        
    }
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    // 刷新请求数据接口
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                account,@"phone",
                                memberId,@"CashierAccountID",
                                nil];
    
    [SVProgressHUD showWithStatus:@"信息检测中..."];
    
    [requstClient request:@"NewVerifymember.ashx" parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            for (FSB_InPutFrame *frame in self.array) {
                
                frame.tranModel.acount = account;
                
                frame.tranModel.acountID = [handlJson objectForKey:@"Memberid"];
                
                frame.tranModel.name = [handlJson objectForKey:@"RealName"];;
                
            }
            
            self.headview.nameLab.text = [handlJson objectForKey:@"RealName"];
            
            [self.headview.iconImg setImageWithURL:[NSURL URLWithString:[handlJson objectForKey:@"PhotoBigUrl"]] placeholderImage:[UIImage imageNamed:@"FSB_头像.png"]];
            
        }else
        {
            
            [SVProgressHUD dismiss];
            
            ErWeiMaView *erweima = [[ErWeiMaView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
            
            [[[UIApplication sharedApplication].windows firstObject] addSubview:erweima];
            
        }
    } failured:^(NSError* error)
     {
         
         [SVProgressHUD showErrorWithStatus:error.description];
         
     }];
    
}

//请求余额
- (void)requestYuE{
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    // 刷新请求数据接口
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"CashierAccountID",
                                nil];
    
    [requstClient request:@"GetGldbalance.ashx" parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            NSDictionary *dic = handlJson[@"yuEMore"];
            
            self.headview.countLab.text = [NSString stringWithFormat:@"%@",dic[@"Balance"]];
            
        }else
        {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
        }
    } failured:^(NSError* error)
     {
         
         [SVProgressHUD showErrorWithStatus:error.description];
         
     }];
    
}

//请求二维码
- (void)requestErWeiMa{
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    // 刷新请求数据接口
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"CashierAccountID",
                                nil];
    
    [requstClient request:@"PublicInvitePro.ashx" parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            
            NSDictionary *dic = handlJson[@"inviteCode"];
            
            [userDefau setObject:dic[@"MemberInviteCode"] forKey:@"erweima"];
            
        }else
        {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
        }
    } failured:^(NSError* error)
     {
         
         [SVProgressHUD showErrorWithStatus:error.description];
         
     }];
    
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
