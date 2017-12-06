//
//  MemberShipRechargeViewController.m
//  CashierDeskIphone
//
//  Created by mac on 2017/10/11.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "MemberShipRechargeViewController.h"
#import "FSB_Header.h"
#import "Member_RechargeModel.h"
#import "Member_RechargeFrame.h"
#import "Member_RechargeCell.h"
#import "Member_RecordsViewController.h"
#import "CommonUtil.h"
#import "SVProgressHUD.h"

@interface MemberShipRechargeViewController () <UITableViewDelegate,UITableViewDataSource,MemberShipRechargeDelegate,UITextFieldDelegate>

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation MemberShipRechargeViewController

-(NSArray *)dataArr {
    
    if (_dataArr == nil) {
        
        Member_RechargeModel *model = [[Member_RechargeModel alloc] init];
        
        model.rechargeType = @"1";
        
        model.name = @"--";
        
        model.balance = @"0.00";
        
        model.jifen = @"0.00";
        
        Member_RechargeFrame *frame = [[Member_RechargeFrame alloc] init];
        
        frame.rechargeModel = model;
        
        NSMutableArray *mut = [NSMutableArray array];
        
        [mut addObject:frame];
        
        _dataArr = mut;
        
    }
    
    return _dataArr;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.title = @"会员充值";
    
    [self allocWithTableview];
    
    self.navigationItem.rightBarButtonItem = [self SetNavigationBarRightTitle:@"记录" andaction:@selector(recordsClick)];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
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

- (void)recordsClick {
    
    Member_RecordsViewController *vc = [[Member_RecordsViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)allocWithTableview {
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = BGColor;
    
    [self.view addSubview:tableview];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Member_RechargeFrame *frame = self.dataArr[indexPath.row];
    
    Member_RechargeCell *cell = [[Member_RechargeCell alloc] init];
    
    cell.frameModel = frame;
    
    cell.yueBlock = ^{

        frame.rechargeModel.rechargeType = @"1";

        [tableView reloadData];

    };

    cell.jifenBlock = ^{

        frame.rechargeModel.rechargeType = @"2";

        [tableView reloadData];

    };

    cell.delegate = self;
    
    cell.phoneField.delegate = self;
    
    cell.sureBlock = ^{
        
        [self checkData];
        
    };
    
    return cell;
    
}

- (BOOL)isBlankString:(NSString *)string {
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

- (void)checkData {
    
    Member_RechargeFrame *frame = self.dataArr[0];

    if ([self isBlankString:frame.rechargeModel.phone]) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        
    }else if ([self isBlankString:frame.rechargeModel.VipCardRecordId]) {
        
        [SVProgressHUD showErrorWithStatus:@"请完善用户信息"];
        
    }else if ([self isBlankString:frame.rechargeModel.count]) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入充值数量"];
        
    }else if ([self isBlankString:frame.rechargeModel.beizhu]) {
        
        [SVProgressHUD showErrorWithStatus:@"请填写充值原因"];
        
    }else {
        
        [self pushData];
        
    }
    
}

- (void)pushData {
    
    Member_RechargeFrame *frame = self.dataArr[0];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         frame.rechargeModel.VipCardRecordId,@"cardid",
                         [CommonUtil getValueByKey:MEMBER_ID],@"shouyin",
                         frame.rechargeModel.rechargeType,@"type",
                         frame.rechargeModel.count,@"number",
                         frame.rechargeModel.beizhu,@"desc",
                         nil];
    
    HttpClientRequest *request = [HttpClientRequest sharedInstance];
    
    [SVProgressHUD showWithStatus:@"充值中"];
    
    [request request:@"Member_recharge.ashx" parameters:dic successed:^(JSONDecoder *jsonDecoder, id responseObject) {
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [jsonDecoder objectWithData:data];
        
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }else {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
        }
        
    } failured:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:error.description];
        
    }];
    
}

#define myDotNumbers     @"0123456789.\n"
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    //输入字符限制
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:myDotNumbers]invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    if (filtered.length == 0 ) {
        //支持删除键
        if (textField.text.length ==11) {

//            for (Member_RechargeFrame *frame in self.dataArr) {
//
//                frame.rechargeModel.iconUrl = @"";
//
//                frame.rechargeModel.name = @"--";
//
//                frame.rechargeModel.balance = @"0.00";
//
//            }
//
//            NSLog(@"11%@",textField.text);
//
////            [self.tableview reloadData];
            
        }
        return [string isEqualToString:@""];
    }else if (textField.text.length ==10){
        
        textField.text = [NSString stringWithFormat:@"%@%@",textField.text,string];
        
        [self yanzhengPhone:[NSString stringWithFormat:@"%@",textField.text] andqrCode:@""];
        
        [textField resignFirstResponder];
        
    }else if (string.length ==11)
    {
        textField.text = [NSString stringWithFormat:@"%@%@",textField.text,string];
            
        [self yanzhengPhone:[NSString stringWithFormat:@"%@",textField.text] andqrCode:@""];
        
        [textField resignFirstResponder];

    }
    
    return YES;
}

- (void)yanzhengPhone:(NSString *)phone andqrCode:(NSString *)qrcode {
    
    for (Member_RechargeFrame *frame in self.dataArr) {
        
        frame.rechargeModel.phone = phone;
        
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    NSString *key = [CommonUtil getServerKey];
    
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"cashierAccountID",
                                phone,@"account",
                                qrcode,@"qrCode",
                                key,@"key",
                                nil];
    
    [SVProgressHUD showWithStatus:@"信息检测中..."];
    
    [requstClient request:@"VipCardSerchPhone.ashx" parameters:parameters successed:^(JSONDecoder *jsonDecoder, id responseObject) {
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [jsonDecoder objectWithData:data];
        
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            
            for (Member_RechargeFrame *frame in self.dataArr) {
                
                frame.rechargeModel.iconUrl = [NSString stringWithFormat:@"%@",handlJson[@"PhotoBigUrl"]];
                
                frame.rechargeModel.name = [NSString stringWithFormat:@"%@",handlJson[@"RealName"]];
                
                frame.rechargeModel.balance = [NSString stringWithFormat:@"%@",handlJson[@"balance"]];
                
                frame.rechargeModel.jifen = [NSString stringWithFormat:@"%@",handlJson[@"jifen"]];
                
                frame.rechargeModel.VipCardRecordId = [NSString stringWithFormat:@"%@",handlJson[@"VipCardRecordId"]];
                
            }
            
            [self.tableview reloadData];
            
            [SVProgressHUD dismiss];
            
        }else {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
        }
        
    } failured:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:error.description];
        
    }];
    
}

- (void)CountFieldChange:(UITextField *)field {

    for (Member_RechargeFrame *frame in self.dataArr) {

        frame.rechargeModel.count = [NSString stringWithFormat:@"%@",field.text];

    }

}

- (void)BeiZhuFieldChange:(UITextField *)field {

    for (Member_RechargeFrame *frame in self.dataArr) {

        frame.rechargeModel.beizhu = [NSString stringWithFormat:@"%@",field.text];

    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Member_RechargeFrame *frame = self.dataArr[indexPath.row];
    
    return frame.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
