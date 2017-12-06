//
//  RH_RechargeViewController.m
//  CashierDeskIphone
//
//  Created by mac on 2017/6/16.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_RechargeViewController.h"
#import "FSB_Header.h"
#import "PersonInfoHeadView.h"
#import "UIImageView+AFNetworking.h"
#import "RH_InPutFrame.h"
#import "RH_InPutCell.h"
#import "RH_TranInfoModel.h"
#import "FenShuAlertView.h"
#import "Choose_FenShuModel.h"
#import "Choose_FenShuFrame.h"

#import "StaffAlertView.h"
#import "Choose_StaffModel.h"
#import "Choose_StaffFrame.h"

#import "InPutNameController.h"
#import "ChooseCarModel.h"
#import "Choose_CarFrame.h"
#import "CarAlertView.h"

#import "ProportionAlertView.h"
#import "Choose_ProportionModel.h"
#import "Choose_ProportionFrame.h"
#import "SureView.h"

#import "RH_ListViewController.h"

@interface RH_RechargeViewController () <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,RH_InPutDelegate> {

    //被检测人手机号
    NSString *checkPhone;
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) PersonInfoHeadView *headview;

@property (nonatomic, strong) NSMutableArray *array;

@property (nonatomic, strong) NSMutableArray *carArr;

@property (nonatomic, strong) NSMutableArray *proportionArr;

@property (nonatomic, strong) NSMutableArray *staffArr;

@property (nonatomic, strong) NSMutableArray *copiesArr;

@end

@implementation RH_RechargeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.title = @"养车宝";
    
    [self allocWithTableview];
    
    [self requestForCopies];
    
//    [self requestForStaff];
    
    NSMutableArray *mut = [NSMutableArray array];
    
    RH_InPutFrame *frame = [[RH_InPutFrame alloc] init];
    
    RH_TranInfoModel *model = [[RH_TranInfoModel alloc] init];
    
    frame.tranModel = model;
    
    [mut addObject:frame];
    
    self.array = mut;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    self.navigationItem.rightBarButtonItem = [self SetNavigationBarRightTitle:@"明细" andaction:@selector(MingXiClick)];
    
}

//明细点击
- (void)MingXiClick {

    RH_ListViewController *vc = [[RH_ListViewController alloc] init];
    
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
    
    RH_InPutFrame *frame = self.array[indexPath.row];

    RH_InPutCell *cell = [[RH_InPutCell alloc] init];

    cell.frameModel = frame;
    
    cell.delegate = self;
    
    cell.chooseCarBlock = ^{
        
        //选择汽车点击
        if ([self isNULLString:checkPhone]) {
            
            [SVProgressHUD showErrorWithStatus:@"请先检测手机号"];
            
        }else {
            
            if (self.carArr.count == 0) {
                
                [SVProgressHUD showErrorWithStatus:@"该用户暂无汽车列表"];
                
            }else {
            
                for (RH_InPutFrame *frame in self.array) {
                    
                    if (![self isNULLString:frame.tranModel.carID]) {
                        
                        for (Choose_CarFrame *ff in self.carArr) {
                            
                            if ([ff.carmodel.CarID isEqualToString:frame.tranModel.carID]) {
                                
                                ff.carmodel.isChoose = @"1";
                                
                            }else {
                                
                                ff.carmodel.isChoose = @"0";
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
                CarAlertView *alert = [[CarAlertView alloc] init];
                
                alert.array = self.carArr;
                
                alert.choosecar = ^(ChooseCarModel *carModel) {
                    
                    frame.tranModel.carID = carModel.CarID;
                    
                    frame.tranModel.carName = carModel.BrandName;
                    
                    [self.tableview reloadData];
                    
                };
                
                [alert showInView:self.view];
                
            }
            
        }
        
    };

    cell.redCopiesBlock = ^{

        //红包份数点击
        //红包份数点击
        for (RH_InPutFrame *frame in self.array) {
            
            if (![self isNULLString:frame.tranModel.redCopiesID]) {
                
                for (Choose_FenShuFrame *ff in self.copiesArr) {
                    
                    if ([ff.fenshumodel.RedID isEqualToString:frame.tranModel.redCopiesID]) {
                        
                        ff.fenshumodel.isChoose = @"1";
                        
                    }else {
                        
                        ff.fenshumodel.isChoose = @"0";
                        
                    }
                    
                }
                
            }
            
        }
        
        FenShuAlertView *alert = [[FenShuAlertView alloc] init];
        
        alert.array = self.copiesArr;
        
        alert.choosefenshu = ^(Choose_FenShuModel *fenshuModel) {
            
            frame.tranModel.redCopiesID = fenshuModel.RedID;
            
            frame.tranModel.redCopiesName = fenshuModel.RedPNum;
            
            [self.tableview reloadData];
            
            for (RH_InPutFrame *frame in self.array) {
                
                if (![self isNULLString:frame.tranModel.redCount]) {
                    
                    //计算金种子
                    [self requestForJinCount];
                    
                }
                
            }
            
        };
        
        [alert showInView:self.view];

    };
    
    cell.redProportionBlock = ^{
        
        if ([self isNULLString:checkPhone]) {
            
            [SVProgressHUD showErrorWithStatus:@"请先检测手机号"];
            
        }else {
            
            if (self.proportionArr.count == 0) {
                
                [SVProgressHUD showErrorWithStatus:@"该用户暂无到账比例"];
                
            }else {
                
                //红包比例点击
                for (RH_InPutFrame *frame in self.array) {
                    
                    if (![self isNULLString:frame.tranModel.redProportionID]) {
                        
                        for (Choose_ProportionFrame *ff in self.proportionArr) {
                            
                            if ([ff.proportionmodel.CommID isEqualToString:frame.tranModel.redProportionID]) {
                                
                                ff.proportionmodel.isChoose = @"1";
                                
                            }else {
                                
                                ff.proportionmodel.isChoose = @"0";
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
                ProportionAlertView *alert = [[ProportionAlertView alloc] init];
                
                alert.array = self.proportionArr;
                
                alert.chooseproportion = ^(Choose_ProportionModel *proportionModel) {
                    
                    frame.tranModel.redProportionID = proportionModel.CommID;
                    
                    frame.tranModel.redProportion = proportionModel.CommName;
                    
                    [self.tableview reloadData];
                    
                };
                
                [alert showInView:self.view];
            
            }
        
        }
        
    };

//    cell.staffBlock = ^{
//
//        //促销员点击
//        //促销员点击
//        for (RH_InPutFrame *frame in self.array) {
//            
//            if (![self isNULLString:frame.tranModel.staffID]) {
//                
//                for (Choose_StaffFrame *ff in self.staffArr) {
//                    
//                    if ([ff.staffmodel.CashierAccountID isEqualToString:frame.tranModel.staffID]) {
//                        
//                        ff.staffmodel.isChoose = @"1";
//                        
//                    }else {
//                        
//                        ff.staffmodel.isChoose = @"0";
//                        
//                    }
//                    
//                }
//                
//            }
//            
//        }
//        
//        StaffAlertView *alert = [[StaffAlertView alloc] init];
//        
//        alert.array = self.staffArr;
//        
//        alert.choosestaff = ^(Choose_StaffModel *staffModel) {
//            
//            frame.tranModel.staffID = staffModel.CashierAccountID;
//            
//            frame.tranModel.staffName = staffModel.RealName;
//            
//            [self.tableview reloadData];
//            
//        };
//        
//        [alert showInView:self.view];
//
//    };

    cell.sureBlock = ^{

        //确认点击
        [self checkRequestData];

    };

    return cell;
    
}

//信息确认
- (void)checkRequestData {
    
    RH_InPutFrame *frame = self.array[0];

    if ([self isNULLString:checkPhone]) {
        
        [SVProgressHUD showErrorWithStatus:@"请检测手机号"];
        
    }else if ([self isNULLString:frame.tranModel.carID]) {
    
        [SVProgressHUD showErrorWithStatus:@"请选择汽车"];
        
    }else if ([self isNULLString:frame.tranModel.redCount]) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入红包金额"];
        
    }else if ([self isNULLString:frame.tranModel.redCopiesID]) {
        
        [SVProgressHUD showErrorWithStatus:@"请选择红包份数"];
        
    }else if ([self isNULLString:frame.tranModel.redProportionID]) {
        
        [SVProgressHUD showErrorWithStatus:@"请选择到账比例"];
        
    }else if ([self isNULLString:frame.tranModel.goldCount]) {
        
        [SVProgressHUD showErrorWithStatus:@"服务费计算失败，请重试"];
        
    }else {
    
        SureView *sureview = [[SureView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
        
        sureview.phoneLab.text = [NSString stringWithFormat:@"账户：%@",checkPhone];
        
        sureview.productLab.text = [NSString stringWithFormat:@"汽车：%@",frame.tranModel.carName];
        
        sureview.jineLab.text = [NSString stringWithFormat:@"红包金额：%@",frame.tranModel.redCount];
        
        sureview.zhouqiLab.text = [NSString stringWithFormat:@"红包份数：%@",frame.tranModel.redCopiesName];
        
        sureview.countLab.text = [NSString stringWithFormat:@"服务费：%@",frame.tranModel.goldCount];
        
        [sureview.sureBtn addTarget:self action:@selector(SureSend) forControlEvents:UIControlEventTouchUpInside];
        
        [[[UIApplication sharedApplication].windows firstObject] addSubview:sureview];
        
    }
    
}

//确认赠送
- (void)SureSend {

    RH_InPutFrame *frame = self.array[0];
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    // 刷新请求数据接口
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"CashierAccountID",
                                checkPhone,@"Phone",
                                frame.tranModel.goldCount,@"Num",
                                frame.tranModel.redProportionID,@"CycleType",
                                frame.tranModel.redCopiesID,@"Part",
                                frame.tranModel.carID,@"CarInfo",
                                frame.tranModel.redCount,@"Allaccount",
                                nil];
    
    NSLog(@"%@",parameters);
    
    [requstClient request:@"RedHorseBusiness.ashx" parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        } else {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
        }
        
    } failured:^(NSError* error) {
        
        [SVProgressHUD showErrorWithStatus:error.description];
        
    }];
    
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

//红包金额代理
- (void)RedCountFieldChange:(UITextField *)field {

    for (RH_InPutFrame *frame in self.array) {
        
        frame.tranModel.redCount = [NSString stringWithFormat:@"%@",field.text];
        
    }
    
}

//红包金额输入完成代理
- (void)RedCountFieldEndChange:(UITextField *)field {
    
    for (RH_InPutFrame *frame in self.array) {
        
        if (![self isNULLString:frame.tranModel.redCopiesID]) {
            
            //计算金种子
            [self requestForJinCount];
            
        }
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RH_InPutFrame *frame = self.array[indexPath.row];

    return frame.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

//计算金种子请求
- (void)requestForJinCount {
    
    RH_InPutFrame *frame = self.array[0];
    
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                frame.tranModel.redCopiesID,@"RedID",
                                frame.tranModel.redCount,@"Account",
                                nil];
    
    [requstClient request:@"CountAmount.ashx" parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            
            NSString *dd = [NSString stringWithFormat:@"%@",handlJson[@"Num"]];
            
            frame.tranModel.goldCount = dd;
            
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
                                memberId,@"CashierAccountID",
                                nil];
    
    [requstClient request:@"MemCommissionRito.ashx" parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            
            NSArray *tempArr = handlJson[@"listRPacket"];
            
            NSMutableArray *mut = [NSMutableArray array];
            
            for (NSDictionary *dd in tempArr) {
                
                Choose_FenShuModel *model = [[Choose_FenShuModel alloc] init];
                
                model.RedID = [NSString stringWithFormat:@"%@",dd[@"RedID"]];
                
                model.RedPNum = [NSString stringWithFormat:@"%@",dd[@"RedPNum"]];
                
                model.Ratio = [NSString stringWithFormat:@"%@",dd[@"Ratio"]];
                
                model.isChoose = @"0";
                
                Choose_FenShuFrame *frame = [[Choose_FenShuFrame alloc] init];
                
                frame.fenshumodel = model;
                
                [mut addObject:frame];
                
            }
            
            self.copiesArr = mut;
            
        } else {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
        }
        
    } failured:^(NSError* error) {
         
         [SVProgressHUD showErrorWithStatus:error.description];
         
    }];
    
}

////请求促销员数据
//- (void)requestForStaff {
//    
//    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
//    
//    NSString *memberId = [userDefau objectForKey:@"memberId"];
//    
//    // 刷新请求数据接口
//    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
//    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
//                                memberId,@"cashierAccountID",
//                                nil];
//    
//    [requstClient request:@"MctYuanGongList.ashx" parameters:parameters successed:^(JSONDecoder*json,id responseObject){
//        
//        NSData* data = [NSData dataWithData:responseObject];
//        
//        NSDictionary* handlJson = [json objectWithData:data];
//        
//        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
//        
//        if (success) {
//            
//            NSArray *tempArr = handlJson[@"ybtrList"];
//            
//            NSMutableArray *mut = [NSMutableArray array];
//            
//            for (NSDictionary *dd in tempArr) {
//                
//                Choose_StaffModel *model = [[Choose_StaffModel alloc] init];
//                
//                model.RealName = [NSString stringWithFormat:@"%@",dd[@"RealName"]];
//                
//                model.CashierAccountID = [NSString stringWithFormat:@"%@",dd[@"CashierAccountID"]];
//                
//                model.isChoose = @"0";
//                
//                Choose_StaffFrame *frame = [[Choose_StaffFrame alloc] init];
//                
//                frame.staffmodel = model;
//                
//                [mut addObject:frame];
//                
//            }
//            
//            self.staffArr = mut;
//            
//        }else
//        {
//            
//            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
//            
//        }
//    } failured:^(NSError* error)
//     {
//         
//         [SVProgressHUD showErrorWithStatus:error.description];
//         
//     }];
//    
//}

//请求余额
- (void)requestYuE{
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    // 刷新请求数据接口
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"CashierAccountID",
                                nil];
    
    [requstClient request:@"XHMMctTotal.ashx" parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            NSString *dic = [NSString stringWithFormat:@"%@",handlJson[@"Total"]];
            
            self.headview.countLab.text = [NSString stringWithFormat:@"%@",dic];
            
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

//检测手机号
- (void)yanzhengPhone:(NSString *)account {
    
    if ([self.headview.phoneField isFirstResponder]) {
        
        [self.headview.phoneField resignFirstResponder];
        
    }
    
    // 刷新请求数据接口
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                account,@"phone",
                                nil];
    
    [SVProgressHUD showWithStatus:@"信息检测中..."];
    
    [requstClient request:@"RedHorseCheckPhone.ashx" parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            checkPhone = account;
            
            self.headview.nameLab.text = [NSString stringWithFormat:@"%@(%@)",[handlJson objectForKey:@"NickName"],[handlJson objectForKey:@"RealName"]];

            [self.headview.iconImg setImageWithURL:[NSURL URLWithString:[handlJson objectForKey:@"PhotoImg"]] placeholderImage:[UIImage imageNamed:@"FSB_头像.png"]];
            
            NSArray *tempArr = handlJson[@"ListCar"];
            
            NSMutableArray *mut = [NSMutableArray array];
            
            for (NSDictionary *dd in tempArr) {
                
                ChooseCarModel *model = [[ChooseCarModel alloc] init];
                
                model.CarID = [NSString stringWithFormat:@"%@",dd[@"CarID"]];
                
                model.BrandName = [NSString stringWithFormat:@"%@",dd[@"BrandName"]];
                
                model.CarNo = [NSString stringWithFormat:@"%@",dd[@"CarNo"]];
                
                model.CarIcon = [NSString stringWithFormat:@"%@",dd[@"CarIcon"]];
                
                model.isChoose = @"0";
                
                Choose_CarFrame *frame = [[Choose_CarFrame alloc] init];
                
                frame.carmodel = model;
                
                [mut addObject:frame];
                
            }
            
            self.carArr = mut;
            
            NSArray *mutArr = handlJson[@"listComm"];
            
            NSMutableArray *mm = [NSMutableArray array];
            
            for (NSDictionary *dd in mutArr) {
                
                Choose_ProportionModel *model = [[Choose_ProportionModel alloc] init];
                
                model.CommID = [NSString stringWithFormat:@"%@",dd[@"CommID"]];
                
                model.CommName = [NSString stringWithFormat:@"%@",dd[@"CommName"]];
                
                model.OtherCommName = [NSString stringWithFormat:@"%@",dd[@"OtherCommName"]];
                
                model.isChoose = @"0";
                
                Choose_ProportionFrame *frame = [[Choose_ProportionFrame alloc] init];
                
                frame.proportionmodel = model;
                
                [mm addObject:frame];
                
            }
            
            self.proportionArr = mm;
            
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

}

@end
