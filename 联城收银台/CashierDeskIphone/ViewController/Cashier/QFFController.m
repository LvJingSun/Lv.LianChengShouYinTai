//
//  QFFController.m
//  CashierDeskIphone
//
//  Created by mac on 16/8/24.
//  Copyright © 2016年 MaxLinksTec. All rights reserved.
//

#import "QFFController.h"
#import "QFFRecordsController.h"
#import "QFFCell1.h"
#import "QFFCell2.h"
#import "QFFCell3.h"
#import "QFFCell4.h"
#import "QFFCell5.h"
#import "QFFCell6.h"
#import "QFFProductNameCell.h"
#import "ChooseZhouQiView.h"
#import "SureView.h"
#import "ErWeiMaView.h"
#import "ProductNameViewController.h"
#import "InPutNameController.h"
#import "ChooseCuXiaoYuan.h"
#import "Q_DanJuViewController.h"

#import "SVProgressHUD.h"
#import "HttpClientRequest.h"
#import "AppHttpClient.h"

#import "N_CycleType.h"
// 屏幕宽度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

// 屏幕高度
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface QFFController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate> {

    NSString *phoneNumber;
    NSString *cashierID;
    NSString *productname;
    NSString *jinzhongzi;
//    NSString *cycle;
    
    N_CycleType *typeModel;
    
    //交易金额
    NSString *TranAccount;
    //全返金额
    NSString *account;
    NSString *cuxiaoyuan;
    
    NSString *kehuName;
    
    //最低消费金额
    NSString *zuidixiaofei;
    
}

@property (nonatomic, weak) UILabel *yueLab;

@property (nonatomic, weak) UITextField *phoneField;

@property (nonatomic, weak) UIImageView *iconImageview;

@property (nonatomic, weak) UILabel *nameLab;

@property (nonatomic, weak) UITextField *productNameField;

@property (nonatomic, weak) UITextField *amountField;

@property (nonatomic, weak) UITextField *qffCountField;

@property (nonatomic, weak) UITextField *jzzCountField;

@property (nonatomic, weak) UITextField *cuxiaoyuanField;

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, weak) UIButton *chooseBtn;

@property (nonatomic, weak) UITextField *zhouqiField;

@property (nonatomic, weak) UITableView *productNameTableview;

@property (nonatomic, weak) UIButton *nameBtn;

@end

@implementation QFFController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"全返付";
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    cashierID = memberId;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BJImage.png"]];
    
    [self setRightBtn];
    
    [self initWithTableview];
    
    [self requestZuiDi];
    
    [self requestErWeiMa];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    self.navigationItem.backBarButtonItem = backItem;
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    //15961078899 888888

}

-(void)viewWillAppear:(BOOL)animated {
    
    [self requestYuE];

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    self.navigationController.navigationBarHidden = NO;
    
}

- (void)initWithTableview {

    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:tableview];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 10;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellID = [NSString stringWithFormat:@"cellID%ld%ld",(long)indexPath.section,(long)indexPath.row];
    
    if (indexPath.row == 0) {
        
        QFFCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (cell == nil) {
            
            cell = [[QFFCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
        }
        
        self.yueLab = cell.countLab;
        
        return cell;
        
    }else if (indexPath.row == 1) {
    
        QFFCell2 *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (cell == nil) {
            
            cell = [[QFFCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
        }
        
        self.phoneField = cell.phoneField;
        
        cell.phoneField.tag = 1111;
        
        cell.phoneField.delegate = self;
        
        return cell;
        
    }else if (indexPath.row == 2) {
    
        QFFCell3 *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (cell == nil) {
            
            cell = [[QFFCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
        }
        
        self.iconImageview = cell.iconImageView;
        
        self.nameLab = cell.userNameLab;
        
        return cell;
        
    }else if (indexPath.row == 3) {
        
//        QFFCell4 *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        QFFProductNameCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (cell == nil) {
            
            cell = [[QFFProductNameCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
        }
        
        cell.titleLab.text = @"商品名称:";
        
        self.productNameField = cell.valueField;
        
        cell.valueField.tag = 2222;
        
        cell.valueField.delegate = self;
        
        cell.valueField.placeholder = @"输入商品名称";
        
        self.nameBtn = cell.nameBtn;
        
        [self.nameBtn addTarget:self action:@selector(inputName) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
        
    }else if (indexPath.row == 4) {
        
        QFFCell4 *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (cell == nil) {
            
            cell = [[QFFCell4 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
        }
        
        cell.titleLab.text = @"交易金额:";
        
        self.amountField = cell.valueField;
        
        cell.valueField.tag = 3333;
        
        cell.valueField.delegate = self;
        
        cell.valueField.keyboardType = UIKeyboardTypeNumberPad;
        
        cell.valueField.placeholder = @"输入交易金额";
        
        return cell;
        
    }else if (indexPath.row == 5) {
        
        QFFCell4 *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (cell == nil) {
            
            cell = [[QFFCell4 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
        }
        
        cell.titleLab.text = @"全返金额:";
        
        self.qffCountField = cell.valueField;
        
        cell.valueField.tag = 4444;
        
        cell.valueField.delegate = self;
        
        cell.valueField.keyboardType = UIKeyboardTypeNumberPad;
        
        cell.valueField.placeholder = @"输入全返金额";
        
        return cell;
        
    }else if (indexPath.row == 6) {
        
        QFFCell4 *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (cell == nil) {
            
            cell = [[QFFCell4 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
        }
        
        cell.titleLab.text = @"金种子:";
        
        self.jzzCountField = cell.valueField;
        
        cell.valueField.tag = 5555;
        
        cell.valueField.delegate = self;
        
        cell.valueField.userInteractionEnabled = NO;
        
        cell.valueField.placeholder = @"金种子数量";
        
        return cell;
        
    }else if (indexPath.row == 7) {
        
        QFFCell6 *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (cell == nil) {
            
            cell = [[QFFCell6 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
        }
        
        self.chooseBtn = cell.chooseBtn;
        
        cell.titleLab.text = @"返利周期:";
        
        cell.zhouqiField.placeholder = @"选择返利周期";
        
        [cell.chooseBtn addTarget:self action:@selector(chooseBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        
        self.zhouqiField = cell.zhouqiField;
        
        return cell;
        
    }else if (indexPath.row == 8) {
        
        QFFCell6 *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (cell == nil) {
            
            cell = [[QFFCell6 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
        }
        
        cell.titleLab.text = @"促销员:";
        
        cell.zhouqiField.placeholder = @"选择促销员";
        
        [cell.chooseBtn addTarget:self action:@selector(choosecuxiaoyuan) forControlEvents:UIControlEventTouchUpInside];
        
        self.cuxiaoyuanField = cell.zhouqiField;
        
        return cell;
        
    }else {
    
        QFFCell5 *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (cell == nil) {
            
            cell = [[QFFCell5 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
        }
        
        [cell.sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
        
    }
    
}

- (void)choosecuxiaoyuan {

    //选择促销员
    ChooseCuXiaoYuan *chooseView = [[ChooseCuXiaoYuan alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    [chooseView ReturnCuXiao:^(NSString *cuxiao, NSString *cuxiaoID) {
        
        self.cuxiaoyuanField.text = cuxiao;
        
        cuxiaoyuan = cuxiaoID;
        
    }];
    
    [[[UIApplication sharedApplication].windows firstObject] addSubview:chooseView];
    
}

- (void)inputName {

    InPutNameController *vc = [[InPutNameController alloc] init];

    [vc returnName:^(NSString *name) {
        
        self.productNameField.text = name;
        
        productname = name;
        
    }];
    
    [self presentViewController:vc animated:YES completion:nil];
    
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

- (void)requestYuE{
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    // 刷新请求数据接口
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"CashierAccountID",
                                nil];
    
    [SVProgressHUD showWithStatus:@"余额请求中..."];
    
    [requstClient request:@"GetGldbalance.ashx" parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];

            NSDictionary *dic = handlJson[@"yuEMore"];
            
            self.yueLab.text = dic[@"Balance"];
            
        }else
        {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
        }
    } failured:^(NSError* error)
     {
         
         [SVProgressHUD showErrorWithStatus:error.description];
         
     }];
    
}

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

- (void)textFieldDidEndEditing:(UITextField *)textField {

    if (textField.tag == 2222) {
        
        productname = textField.text;
        
    }else if (textField.tag == 3333) {
        
        TranAccount = textField.text;
    
    }else if (textField.tag == 4444) {
        
        if (![textField.text isEqualToString:@""]) {
            
            account = textField.text;

            if ([self.zhouqiField.text isEqualToString:@""]) {
        
                [self chooseBtnClicked];
                
            }else {
            
                [self requestJinZhongZi];
                
            }

        }
        
    }
}

#define myDotNumbers     @"0123456789.\n"
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField.tag == 1111) {
        
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
            
            [self yanzhengPhone:[NSString stringWithFormat:@"%@",textField.text] andqrCode:@""];

        }else if (string.length ==11)
        {
            textField.text = [NSString stringWithFormat:@"%@%@",textField.text,string];

            [self yanzhengPhone:[NSString stringWithFormat:@"%@",textField.text] andqrCode:@""];

        }
    }
    
    return YES;
}

- (void)yanzhengPhone:(NSString *)accountt andqrCode:(NSString *)qrCode{
    
    phoneNumber = accountt;
    
    if ([self.phoneField isFirstResponder]) {
        
        [self.phoneField resignFirstResponder];
        
    }
    
    // 刷新请求数据接口
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                accountt,@"phone",
                                cashierID,@"CashierAccountID",
                                nil];

    [SVProgressHUD showWithStatus:@"信息检测中..."];

    [requstClient request:@"NewVerifymember.ashx" parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            self.nameLab.text = [handlJson objectForKey:@"RealName"];
            
            kehuName = [handlJson objectForKey:@"RealName"];
            
            self.iconImageview.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[handlJson objectForKey:@"PhotoBigUrl"]]]];
   
        }else
        {

//            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
            [SVProgressHUD dismiss];
            
            ErWeiMaView *erweima = [[ErWeiMaView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            
            [[[UIApplication sharedApplication].windows firstObject] addSubview:erweima];
            
        }
    } failured:^(NSError* error)
     {

         [SVProgressHUD showErrorWithStatus:error.description];
         
     }];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        QFFCell1 *cell = [[QFFCell1 alloc] init];
        
        return cell.height;
        
    }else if (indexPath.row == 1) {
    
        QFFCell2 *cell = [[QFFCell2 alloc] init];
        
        return cell.height;
        
    }else if (indexPath.row == 2) {
        
        QFFCell3 *cell = [[QFFCell3 alloc] init];
        
        return cell.height;
        
    }else if (indexPath.row == 3) {
        
//        QFFCell4 *cell = [[QFFCell4 alloc] init];
        
        QFFProductNameCell *cell = [[QFFProductNameCell alloc] init];
        
        return cell.height;
        
    }else if (indexPath.row == 4) {
        
        QFFCell4 *cell = [[QFFCell4 alloc] init];
        
        return cell.height;
        
    }else if (indexPath.row == 5) {
        
        QFFCell4 *cell = [[QFFCell4 alloc] init];
        
        return cell.height;
        
    }else if (indexPath.row == 6) {
        
        QFFCell4 *cell = [[QFFCell4 alloc] init];
        
        return cell.height;
        
    }else if (indexPath.row == 7) {
        
        QFFCell6 *cell = [[QFFCell6 alloc] init];
        
        return cell.height;
        
    }else if (indexPath.row == 8) {
        
        QFFCell6 *cell = [[QFFCell6 alloc] init];
        
        return cell.height;
        
    }else {
    
        QFFCell5 *cell = [[QFFCell5 alloc] init];
        
        return cell.height;
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self.phoneField isFirstResponder]) {
        
        [self.phoneField resignFirstResponder];
        
    }
    
    if ([self.productNameField isFirstResponder]) {
        
        [self.productNameField resignFirstResponder];
        
    }
    
    if ([self.amountField isFirstResponder]) {
        
        [self.amountField resignFirstResponder];
        
    }
    
    if ([self.qffCountField isFirstResponder]) {
        
        [self.qffCountField resignFirstResponder];
        
    }
    
    if ([self.jzzCountField isFirstResponder]) {
        
        [self.jzzCountField resignFirstResponder];
        
    }
    
    if ([self.zhouqiField isFirstResponder]) {
        
        [self.zhouqiField resignFirstResponder];
        
    }
    
}

- (void)setRightBtn {
    
    UIButton *screenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    screenBtn.frame = CGRectMake(0, 0, 50, 20);
    
    [screenBtn setTitle:@"充值记录" forState:UIControlStateNormal];
    
    screenBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    
    [screenBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    [screenBtn addTarget:self action:@selector(screenBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *screenBarBtn=[[UIBarButtonItem alloc]initWithCustomView:screenBtn];
    
    self.navigationItem.rightBarButtonItem = screenBarBtn;
    
}

- (void)screenBtnClick {

    QFFRecordsController *vc = [[QFFRecordsController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)chooseBtnClicked {

    ChooseZhouQiView *chooseView = [[ChooseZhouQiView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    [chooseView ReturnZhouQi:^(N_CycleType *type) {
        
        typeModel = type;

        self.zhouqiField.text = [NSString stringWithFormat:@"%@年",type.length];
        
        if ([self.qffCountField.text isEqualToString:@""]) {
            
            jinzhongzi = @"0";
            
            self.jzzCountField.text = @"0";
            
            [SVProgressHUD showErrorWithStatus:@"请输入返利金额"];
            
        }else {
        
            [self requestJinZhongZi];
            
        }
        
    }];
    
    [[[UIApplication sharedApplication].windows firstObject] addSubview:chooseView];
    
}

- (void)requestJinZhongZi {
    
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                cashierID,@"memberId",
                                typeModel.CycleType,@"cycle",
                                account,@"account",
                                nil];
    
    [SVProgressHUD showWithStatus:@"计算金种子..."];
    
    [requstClient request:@"CountGld.ashx" parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            NSDictionary *dic = handlJson[@"ybtrList"];
            
            jinzhongzi = [NSString stringWithFormat:@"%@",dic[@"Jinzhongzi"]];
            
            self.jzzCountField.text = jinzhongzi;
            
        }else
        {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
        }
        
    } failured:^(NSError* error)
     {
         
         [SVProgressHUD showErrorWithStatus:error.description];
         
     }];

}

- (void)sureBtnClick {

    if ((productname.length == 0) || (productname.length == 0) || (TranAccount.length == 0) || (jinzhongzi.length == 0) || (typeModel.CycleType.length == 0) || (cuxiaoyuan.length == 0)) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请完善所填信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
        
    }else {
    
        if ([account floatValue] > [TranAccount floatValue]) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"全返金额不能大于消费金额" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [alert show];
            
        }else if ([account floatValue] > 1000000) {
        
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"全返金额超过100万元，请分批赠送" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [alert show];
            
        }else {
        
            if ([TranAccount intValue] >= [zuidixiaofei intValue]) {
                
                Q_DanJuViewController *vc = [[Q_DanJuViewController alloc] init];
                
                vc.phone = phoneNumber;
                
                vc.CashierAccountID = cashierID;
                
                vc.count = jinzhongzi;
                
                vc.cycle = typeModel.CycleType;
                
                vc.tranCount = TranAccount;
                
                vc.fanCount = account;
                
                vc.staff = cuxiaoyuan;
                
                vc.productName = productname;
                
                vc.name = kehuName;
                
                vc.cycleName = self.zhouqiField.text;
                
                vc.staffName = self.cuxiaoyuanField.text;
                
                [self.navigationController pushViewController:vc animated:YES];
                
            }else {
                
                SureView *sureview = [[SureView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
                
                sureview.phoneLab.text = [NSString stringWithFormat:@"账户号码：%@",phoneNumber];
                
                sureview.productLab.text = [NSString stringWithFormat:@"商品名称：%@",productname];
                
                sureview.jineLab.text = [NSString stringWithFormat:@"全返金额：%@",account];
                
                sureview.zhouqiLab.text = [NSString stringWithFormat:@"全返周期：%@",self.zhouqiField.text];
                
                sureview.countLab.text = [NSString stringWithFormat:@"金种子数：%@",jinzhongzi];
                
                [sureview.sureBtn addTarget:self action:@selector(requestData) forControlEvents:UIControlEventTouchUpInside];
                
                [[[UIApplication sharedApplication].windows firstObject] addSubview:sureview];
                
            }
            
        }
        
    }
}

- (void)requestData {

    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                phoneNumber,@"phone",
                                @"434",@"CashierAccountID",
                                jinzhongzi,@"jinzhongzi",
                                typeModel.CycleType,@"cycle",
                                TranAccount,@"TranAccount",
                                cuxiaoyuan,@"yuangong",
                                productname,@"goodsname",
                                account,@"allaccount",
                                @"1",@"status",
                                nil];
    
    NSLog(@"%@",parameters);
    
    [SVProgressHUD showWithStatus:@"赠送中..."];
    
    [requstClient request:@"PaymentCheck_Jinzhongzi_1.ashx" parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
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

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSArray *lastArray = [defaults valueForKey:@"productNameArray"];
    
    NSMutableArray *productNameArray = [NSMutableArray array];
    
    [productNameArray addObjectsFromArray:lastArray];
    
    BOOL isContain = [lastArray containsObject:productname];
    
    if (!isContain) {
        
        [productNameArray addObject:productname];
        
    }
    
    [defaults setObject:productNameArray forKey:@"productNameArray"];
    
    [defaults synchronize];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.navigationController.navigationBarHidden = YES;
    
}


@end
