//
//  ConsoleHandViewController.m
//  CashierDeskIphone
//
//  Created by mac on 13-9-12.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "ConsoleHandViewController.h"

#import "ConsoleCell.h"

#import "ValidateResultViewController.h"

#import "KeyValidateData.h"

#import "QuanquanResultViewController.h"

#import "QuanquanData.h"

#import "BalancashierViewController.h"

#import "CashierlistViewController.h"

#import <QRCodeReader.h>

#import "MenuOrderDetailViewController.h"

#import "Ca_MenuOrderViewController.h"
#import "N_ShouYinListViewController.h"

@interface ConsoleHandViewController ()

@property (weak, nonatomic) IBOutlet UIButton *m_leftBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_rightBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_threeBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_fourBtn;


//红包页面
@property (weak, nonatomic) IBOutlet UIView *m_quanView;
//红包输入框
@property (weak, nonatomic) IBOutlet UITextField *hongbaoTextfield;
@property (weak, nonatomic) IBOutlet UIView *m_btnView;
//积分页面
@property (weak, nonatomic) IBOutlet UIView *m_tempView;
//积分输入框
@property (weak, nonatomic) IBOutlet UITextField *jifenTextfield;


@property (weak, nonatomic) IBOutlet UIView *m_cardView;


@property (weak, nonatomic) IBOutlet UIScrollView *m_scrollerView;



- (IBAction)btnCilcked:(id)sender;

// 券券验证的按钮触发的事件
//- (IBAction)quanquanSureClicked:(id)sender;

@end

@implementation ConsoleHandViewController

//@synthesize m_minusBtn;

//@synthesize m_plusBtn;

@synthesize m_number;

//@synthesize m_numberTextField;

//@synthesize m_tableView;

@synthesize m_footerView;

@synthesize m_array;

@synthesize m_activeTextField;

@synthesize m_dic;

@synthesize m_orderList;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

        m_array = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_dic = [[NSMutableDictionary alloc]init];
        
        m_orderList = [[NSMutableArray alloc]initWithCapacity:0];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationController.navigationBar.translucent = NO;

    // 默认隐藏
    self.m_scrollerView.hidden = YES;

    // 版本判断
    if ( isIOS7 ) {
        
        [self.m_titleVIew setFrame:CGRectMake(0, 20, 320, 48)];
        
        [self.m_btnView setFrame:CGRectMake(0, 68, 320, 48)];

        if ( iPhone5 ) {
            
            [self.m_tempView setFrame:CGRectMake(0, 68+48, 320, [[UIScreen mainScreen]bounds].size.height - 20 - 96)];

            [self.m_quanView setFrame:CGRectMake(0, 68+48, 320, [[UIScreen mainScreen]bounds].size.height - 20 - 96)];
            
            [self.m_cardView setFrame:CGRectMake(0, 68+48, 320, [[UIScreen mainScreen]bounds].size.height - 20 - 96)];

        }else{

            [self.m_tempView setFrame:CGRectMake(0, 68+48, 320, [[UIScreen mainScreen]bounds].size.height - 20)];

            [self.m_quanView setFrame:CGRectMake(0, 68+48, 320, [[UIScreen mainScreen]bounds].size.height - 20)];
            [self.m_cardView setFrame:CGRectMake(0, 68+48, 320, [[UIScreen mainScreen]bounds].size.height - 20)];


        }
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
        label.backgroundColor = [UIColor blackColor];
        
        [self.view addSubview:label];
        
    }else{
        
        [self.m_titleVIew setFrame:CGRectMake(0, 0, 320, 48)];
        
        [self.m_btnView setFrame:CGRectMake(0, 48, 320, 48)];

        [self.m_tempView setFrame:CGRectMake(0, 96, 320, self.view.frame.size.height - 96)];
        
        [self.m_quanView setFrame:CGRectMake(0, 96, 320, self.view.frame.size.height - 96)];
        [self.m_cardView setFrame:CGRectMake(0, 96, 320, self.view.frame.size.height - 96)];

        
    }

//    self.m_numberTextField.delegate = self;
    
    self.m_number = 1;
    
//    self.m_numberTextField.text = [NSString stringWithFormat:@"%li",(long)self.m_number];
    
//    self.m_minusBtn.userInteractionEnabled = NO;
    
//    self.m_plusBtn.userInteractionEnabled = YES;
    
//    [self.m_minusBtn setImage:[UIImage imageNamed:@"number_control_minus_disabled.png"] forState:UIControlStateNormal];
    
//    [self.m_plusBtn setImage:[UIImage imageNamed:@"number_control_plus.png"] forState:UIControlStateNormal];
    
//    self.m_tableView.tableFooterView = self.m_footerView;
    
   // 默认选中的是key值收银
    [self setLeftBtn:NO rightBtn:NO andthree:YES andfour:NO];
    
    self.m_stringType = @"2";
    
    
    [Cardrecordbtn addTarget:self action:@selector(Cashierlist) forControlEvents:UIControlEventTouchUpInside];
    
    
    // 根据是点单模式还是美容模式，来判断是否请求座位信息的订单
    NSString *isSeat = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:ISSELECTSEAT]];
    
    if ( [isSeat isEqualToString:@"1"] ) {
        
        // 请求数据
        [self orderListRequestSubmit];
        
    }else{
        
        
    }
    
   
}

-(void)setTextField:(NSString *)textStr{
    
    if (self.m_leftBtn.selected) {
        
        //积分
        self.jifenTextfield.text = textStr;
        
    }else if (self.m_rightBtn.selected) {
        
        //红包
        self.hongbaoTextfield.text = textStr;
        
    }else if (self.m_threeBtn.selected) {
        
        //会员卡
        self.m_cardTextField.text = textStr;
        
    }
    
//    //积分
//    self.m_leftBtn.selected = aLeft;
//    //红包
//    self.m_rightBtn.selected = aRight;
//    //会员卡
//    self.m_threeBtn.selected = athree;
//    //余额
//    self.m_fourBtn.selected = afour;
    
   
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if (  [self.m_stringType isEqualToString:@"2"] ) {
        
        NSString *isSeat = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:ISSELECTSEAT]];
        
        if ( [isSeat isEqualToString:@"1"] ) {
            
            // 会员卡的选项下面如果该值为1则表示有新增的菜单
            NSString *menuOrderList = [CommonUtil getValueByKey:@"MenuOrderListKey"];
            
            if ( [menuOrderList isEqualToString:@"1"] ) {
                
                [CommonUtil addValue:@"0" andKey:@"MenuOrderListKey"];
                
                // 表示下过订单请求接口刷新数据
                [self orderListRequestSubmit];
                
            }
            
        }else {
            // 隐藏座位显示
            self.m_scrollerView.hidden = YES;
            
        }
    }
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];

    [self.view endEditing:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

// 请求数据
- (void)requestSubmit{
    
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
        
    NSMutableString *str = [[NSMutableString alloc]init];
    
    if ( self.m_array.count != 0 ) {
        
        [self.m_array removeAllObjects];
    }
    // 判断字典是否有值后将字典里不为空的数据添加到数组里面
    for (int i = 0; i < [self.m_dic count]; i ++) {
        
        NSString *string = [self.m_dic objectForKey:[NSString stringWithFormat:@"%i",i]];
                
        if ( string.length != 0 ) {
            
            [self.m_array addObject:string];
        }
       
    }
    
    // 将数组里的值拼接为字符用于数据请求
    for (int i = 0; i < [self.m_array count]; i ++) {
        
        if ( i == [self.m_array count] - 1 ) {
            
            [str appendString:[NSString stringWithFormat:@"%@",[self.m_array objectAtIndex:i]]];
            
        }else{
            
            [str appendString:[NSString stringWithFormat:@"%@,",[self.m_array objectAtIndex:i]]];
        }
    }
    
    // 当数组为空时跳出提示
    if ( self.m_array.count == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入KEY值"];
        
        return;
    }
   
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
        
    // 刷新请求数据接口
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId, @"cashierAccountId",
                                key,@"key",
                                str,@"keyCode",nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [requstClient request:CDHTTPRequestKeyValidate parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        KeyValidateData *keyData = [[KeyValidateData alloc]initWithJsonObject:handlJson];
        
        BOOL success = [keyData.status boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            // 点击进入验证结果页面
            ValidateResultViewController *viewController = [[ValidateResultViewController alloc]initWithNibName:@"ValidateResultViewController" bundle:nil];
            viewController.m_typeString = @"1";
            viewController.m_validateData = keyData;
            [self.navigationController pushViewController:viewController animated:YES];
            
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

- (IBAction)userListClick:(id)sender {
    
    UserListViewController *userList = [UserListViewController ShareUserListVC];
    userList.delegate = self;
    [self.navigationController pushViewController:userList animated:YES];
}

- (IBAction)backLastView:(id)sender {
    
    [self goBack];
}

// 判断输入框里值是否为空
//- (BOOL)emptyString{
//
//    if ( self.m_numberTextField.text.length == 0 ) {
//
//        [self.m_minusBtn setImage:[UIImage imageNamed:@"number_control_minus_disabled.png"] forState:UIControlStateNormal];
//
//        self.m_minusBtn.userInteractionEnabled = NO;
//
//        self.m_number = 1;
//
//        self.m_numberTextField.text = [NSString stringWithFormat:@"%li",(long)self.m_number];
//
//        [m_tableView reloadData];
//
//        return YES;
//
//    }else{
//
//        return NO;
//    }
//
//}

//- (IBAction)minusClicked:(id)sender {
//
//    [self.view endEditing:YES];
//
//    if ( [self emptyString] ) {
//        return;
//    }
//
//    // 删除数组里的最后一个内容
//    if ( self.m_dic.count == self.m_number ) {
//
//        [self.m_dic removeObjectForKey:[NSString stringWithFormat:@"%lu",self.m_dic.count - 1]];
//    }
//
//
//    self.m_number = self.m_number - 1;
//
//    // 判断减号的按钮是否可以点击以及按钮的背景图片
//    if ( self.m_number == 1 || self.m_number == 0 ) {
//
//        [self.m_minusBtn setImage:[UIImage imageNamed:@"number_control_minus_disabled.png"] forState:UIControlStateNormal];
//
//        self.m_minusBtn.userInteractionEnabled = NO;
//
//        self.m_number = 1;
//
//    }else{
//
//        [self.m_minusBtn setImage:[UIImage imageNamed:@"number_control_minus.png"] forState:UIControlStateNormal];
//
//        self.m_minusBtn.userInteractionEnabled = YES;
//
//    }
//
//    self.m_numberTextField.text = [NSString stringWithFormat:@"%li",(long)self.m_number];
//
//    // 刷新tableView
//    [m_tableView reloadData];
//
//
//}
//
//- (IBAction)m_plusClicked:(id)sender {
//
//    [self.view endEditing:YES];
//
//    if ( [self emptyString] ) {
//        return;
//    }
//
//
//    self.m_number = self.m_number + 1;
//
//    self.m_minusBtn.userInteractionEnabled = YES;
//
//    self.m_numberTextField.text = [NSString stringWithFormat:@"%li",(long)self.m_number];
//
//    [self.m_minusBtn setImage:[UIImage imageNamed:@"number_control_minus.png"] forState:UIControlStateNormal];
//
//    [m_tableView reloadData];
//
//
//}

- (IBAction)vidateClicked:(id)sender {
    
    [self.view endEditing:YES];
    
    // 请求数据
    [self requestSubmit];
      
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.m_number;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"ConsoleCellIdentifier";
    
    ConsoleCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ConsoleCell" owner:self options:nil];
        
        cell = (ConsoleCell *)[nib objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
       
    
    }
    
    cell.m_keyValueTextField.tag = indexPath.row;
    
    // 判断各种设备下分割线的显示
    if ( isIOS7 ) {
        
    }else{
        
        cell.m_imageView.frame = CGRectMake(-1, 48, 291, 0.5);
        
    }

    // 设置cell的背景图片
    UIImageView *image = [[UIImageView alloc]initWithFrame:cell.frame];
    
    if ( self.m_number == 1 ) {
        
        image.image = [UIImage imageNamed:@"cell_single.png"];
        
        cell.m_imageView.hidden = YES;
        
    }else{
        
        if ( indexPath.row == 0 ) {
            
            image.image = [UIImage imageNamed:@"cell_head.png"];
            
            cell.m_imageView.hidden = YES;

        }else if ( indexPath.row != self.m_number - 1 ) {
            
            image.image = [UIImage imageNamed:@"cell_body_repeat.png"];
            
            cell.m_imageView.hidden = NO;
            
            // 7的设备下添加分割线
            if ( isIOS7 ) {
                
                UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 43, 310, 0.5)];
                
                imgV.image = [UIImage imageNamed:@"cell_line_repeat.png"];
                
                if ( indexPath.row != self.m_number ) {
                    
                    [cell.contentView addSubview:imgV];
                    
                }
            }else{
               
                UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 43, 290, 0.5)];
                
                imgV.image = [UIImage imageNamed:@"cell_line_repeat.png"];
                
                if ( indexPath.row != self.m_number ) {
                    
                    [cell.contentView addSubview:imgV];
                    
                }
                
            }
            
        }else{
            
            image.image = [UIImage imageNamed:@"cell_comm_foot.png"];
            
            cell.m_imageView.hidden = YES;

        }
   
    }
    
    // 将字典里的值赋值在textField上进行显示
    cell.m_keyValueTextField.text = [self.m_dic objectForKey:[NSString stringWithFormat:@"%li",(long)indexPath.row]];
    
    
    cell.m_keyValueTextField.tag = indexPath.row;
   
    cell.m_keyValueTextField.delegate = self;
    
    [cell.m_keyValueTextField addTarget:self action:@selector(showNumberPadKeyboard:) forControlEvents:UIControlEventTouchDown];
    
    cell.backgroundView = image;
    
    return cell;
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    // textField == self.m_quanquanTextField ||
    
    if (textField ==self.m_cardTextField) {
        
        // 手动调动下键盘隐藏的方法
        [self hideNumberPadKeyboard:nil];
        
    }
}



- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    self.m_activeTextField = textField;
        
//    if ( self.m_activeTextField != self.m_quanquanTextField ) {
//
//        // 手动调动下键盘显示的方法
//        [self showNumberPadKeyboard:nil];
//
//        CGRect textFieldRect = CGRectMake(0, textField.tag * 42, 320, 460);
//
//        // 设置tableView滚动到点击的哪一行
//        [self.m_tableView setContentOffset:CGPointMake(0, textFieldRect.origin.y)];
//
//    }else{
    
        // 手动调动下键盘隐藏的方法
        [self hideNumberPadKeyboard:nil];
        
//    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
//    if ( textField == self.m_numberTextField ) {
//
//        if ( m_numberTextField.text.length == 0 ) {
//
//            self.m_numberTextField.text = @"";
//
//        }else{
//
//            self.m_numberTextField.text = textField.text;
//
//            self.m_number = [textField.text integerValue];
//
//        }
//
//    }else{
    
        // 将值赋到字典里面
        [self.m_dic setObject:textField.text forKey:[NSString stringWithFormat:@"%li",(long)textField.tag]];

//    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
//    if ( textField == self.m_numberTextField ) {
//
//        self.m_numberTextField.text = textField.text;
//
//        [self hidenKeyboard];
//
//        return YES;
//
//    }else{
    
        [textField resignFirstResponder];
        
        return YES;
//    }
}

//隐藏键盘的方法
-(void)hidenKeyboard {
    
//    [self.m_tableView setContentOffset:CGPointMake(0, 0)];

    
//    [self.m_numberTextField resignFirstResponder];
    
    [self.view endEditing:YES];
    
//    [self resumeView];
}

//恢复原始视图位置
//-(void)resumeView {
//    if ( m_numberTextField.text.length == 0 ) {
//
//        self.m_number = 1;
//
//        self.m_numberTextField.text = [NSString stringWithFormat:@"%li",(long)self.m_number];
//
//        [self.m_minusBtn setImage:[UIImage imageNamed:@"number_control_minus_disabled.png"] forState:UIControlStateNormal];
//
//        self.m_minusBtn.userInteractionEnabled = NO;
//
//
//    }else if ( [m_numberTextField.text isEqualToString:@"0"] ){
//
//        self.m_number = 1;
//
//        self.m_numberTextField.text = [NSString stringWithFormat:@"%li",(long)self.m_number];
//
//        [self.m_minusBtn setImage:[UIImage imageNamed:@"number_control_minus_disabled.png"] forState:UIControlStateNormal];
//
//        self.m_minusBtn.userInteractionEnabled = NO;
//
//    }else{
//
//        self.m_number = [m_numberTextField.text integerValue];
//
//        self.m_numberTextField.text = [NSString stringWithFormat:@"%li",(long)self.m_number];
//
//        if ( self.m_number == 1 ) {
//
//            [self.m_minusBtn setImage:[UIImage imageNamed:@"number_control_minus_disabled.png"] forState:UIControlStateNormal];
//
//            self.m_minusBtn.userInteractionEnabled = NO;
//
//
//        }else{
//
//            [self.m_minusBtn setImage:[UIImage imageNamed:@"number_control_minus.png"] forState:UIControlStateNormal];
//
//            self.m_minusBtn.userInteractionEnabled = YES;
//
//        }
//
//    }
//
//
//    [m_tableView reloadData];
//
//}

- (void)setLeftBtn:(BOOL)aLeft rightBtn:(BOOL)aRight andthree:(BOOL)athree andfour:(BOOL)afour{
    //积分
    self.m_leftBtn.selected = aLeft;
    //红包
    self.m_rightBtn.selected = aRight;
    //会员卡
    self.m_threeBtn.selected = athree;
    //余额
    self.m_fourBtn.selected = afour;
    
    if ( aLeft ) {
        
        //积分
        self.m_leftBtn.userInteractionEnabled = NO;
        
        self.m_rightBtn.userInteractionEnabled = YES;
        
        self.m_threeBtn.userInteractionEnabled = YES;

        self.m_fourBtn.userInteractionEnabled = YES;
        
        self.m_tempView.hidden = NO;
        
        self.m_quanView.hidden = YES;
        
        self.m_cardView.hidden = YES;
        
        self.m_handView.hidden = YES;
        
//        Cardrecordbtn.hidden = YES;

        
    }else if ( aRight ){
        
        //红包
        self.m_leftBtn.userInteractionEnabled = YES;
        
        self.m_rightBtn.userInteractionEnabled = NO;
        
        self.m_threeBtn.userInteractionEnabled = YES;

        self.m_fourBtn.userInteractionEnabled = YES;
        
        self.m_tempView.hidden = YES;
        
        self.m_quanView.hidden = NO;
        
        self.m_cardView.hidden = YES;
        
        self.m_handView.hidden = YES;

//        Cardrecordbtn.hidden = YES;

       
    }else if ( athree ){
        
        //会员卡
        self.m_leftBtn.userInteractionEnabled = YES;
        
        self.m_rightBtn.userInteractionEnabled = YES;
        
        self.m_threeBtn.userInteractionEnabled = NO;
        
        self.m_fourBtn.userInteractionEnabled = YES;
        
        self.m_tempView.hidden = YES;
        
        self.m_quanView.hidden = YES;
        
        self.m_cardView.hidden = NO;
        
        self.m_handView.hidden = YES;

//        Cardrecordbtn.hidden = NO;

    }else {
        
        //余额
        self.m_leftBtn.userInteractionEnabled = YES;
        
        self.m_rightBtn.userInteractionEnabled = YES;
        
        self.m_threeBtn.userInteractionEnabled = YES;
        
        self.m_fourBtn.userInteractionEnabled = NO;
        
        self.m_tempView.hidden = YES;
        
        self.m_quanView.hidden = YES;
        
        self.m_cardView.hidden = YES;
        
        self.m_handView.hidden = NO;

//        Cardrecordbtn.hidden = YES;

        
        if (_CbalanceVC == nil) {
            _CbalanceVC = [[CbalanceViewController alloc]initWithNibName:@"CbalanceViewController" bundle:nil];
            _CbalanceVC.navigationController = self.navigationController;
            _CbalanceVC.view.frame = CGRectMake(0, -48, 320, _CbalanceVC.view.frame.size.height);
            [self.m_handView addSubview:_CbalanceVC.view];
        }
        

    }
    
}

#pragma mark - Btn Clicked
- (IBAction)btnCilcked:(id)sender{
    
    [self.view endEditing:YES];
    
    UIButton *btn = (UIButton *)sender;
    
    if ( btn.tag == 10 ) {
        
        self.m_stringType = @"0";
        
        [self setLeftBtn:YES rightBtn:NO andthree:NO andfour:NO];
        
    }else if( btn.tag == 11 ){
        
        self.m_stringType = @"1";
        
        [self setLeftBtn:NO rightBtn:YES andthree:NO andfour:NO];

    }else if( btn.tag == 12 ){
        
        self.m_stringType = @"2";
        
        [self setLeftBtn:NO rightBtn:NO andthree:YES andfour:NO];

    }else {
        
        self.m_stringType = @"3";
        
        [self setLeftBtn:NO rightBtn:NO andthree:NO andfour:YES];
        
    }
    
}

//积分收银确认
- (IBAction)jifenSureClick:(id)sender {
    
    [self.view endEditing:YES];
    
    if ( self.jifenTextfield.text.length == 0 ) {
        [SVProgressHUD showErrorWithStatus:@"请输入会员手机号"];
        return;
    }
    
    [self CardCheckrequestSubmit:@"account" andqr:@""];
    
}

//红包收银确认
- (IBAction)hongbaoSureClick:(id)sender {
    
    [self.view endEditing:YES];
    
    if ( self.hongbaoTextfield.text.length == 0 ) {
        [SVProgressHUD showErrorWithStatus:@"请输入会员手机号"];
        return;
    }
    
    [self CardCheckrequestSubmit:@"account" andqr:@""];
    
}

- (IBAction)CardsSureClicked:(id)sender {
    
    [self.view endEditing:YES];
    
    if ( self.m_cardTextField.text.length == 0 ) {
        [SVProgressHUD showErrorWithStatus:@"请输入会员手机号"];
        return;
    }
    
    [self CardCheckrequestSubmit:@"account" andqr:@""];

    
}

-(void)Cashierlist
{
//    CashierlistViewController *VC = [[CashierlistViewController alloc]initWithNibName:@"CashierlistViewController" bundle:nil];
//    [self.navigationController pushViewController:VC animated:YES];
    
    N_ShouYinListViewController *vc = [[N_ShouYinListViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)CardCheckrequestSubmit:(NSString *)type andqr:(NSString *)qrcode{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    NSString *accountt = @"";
    NSString *qrCode = @"";
    
    NSString *shouyin_type;

    if ([type isEqualToString:@"account"]) {
        
        if (self.m_leftBtn.selected) {
            
            //积分
            accountt = [NSString stringWithFormat:@"%@",self.jifenTextfield.text];
            
        }else if (self.m_rightBtn.selected) {
            
            //红包
            accountt = [NSString stringWithFormat:@"%@",self.hongbaoTextfield.text];
            
        }else if (self.m_threeBtn.selected) {
            
            //会员卡
            accountt = [NSString stringWithFormat:@"%@",self.m_cardTextField.text];
 
        }
        
        qrCode = @"";
    }else if ([type isEqualToString:@"qrcode"]){
        accountt = @"";
        qrCode = [NSString stringWithFormat:@"%@",qrcode];
    }
    
    
    // 刷新请求数据接口
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId, @"cashierAccountID",
                                accountt,@"account",
                                qrCode,@"qrCode",
                                type,@"type",
                                key,@"key",nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中..."];
    
    [requstClient request:CHTTPRequestcardVIPCardCheckm parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
                
        BaseRetData *Data = [[BaseRetData alloc]initWithJsonObject:handlJson];
        
        BOOL success = [Data.status boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            BalancashierViewController *VC = [[BalancashierViewController alloc]initWithNibName:@"BalancashierViewController" bundle:nil];
            
            if (self.m_leftBtn.selected) {
                
                //积分
                VC.shouyin_Type = @"2";
                
            }else if (self.m_rightBtn.selected) {
                
                //红包
                VC.shouyin_Type = @"3";
                
            }else if (self.m_threeBtn.selected) {
                
                //会员卡
                VC.shouyin_Type = @"1";
                
            }
            
            
            VC.m_dic = handlJson;
            [VC returnText:^(NSString *showBool) {
                if ([showBool isEqualToString:@"CardtextClean"]) {
                    self.m_activeTextField.text = @"";
                }
                
            }];

            [self.navigationController pushViewController:VC animated:YES];
            
        }else
        {
//            [self.navigationController popViewControllerAnimated:YES];

            [SVProgressHUD showErrorWithStatus:Data.msg];
            
        }
    } failured:^(NSError* error)
     {
//         [self.navigationController popViewControllerAnimated:YES];

         [SVProgressHUD showErrorWithStatus:error.description];
     }];
    
}

-(IBAction)QRPushcard:(id)sender
{
//    [self.m_activeTextField resignFirstResponder];
    
    [self.view endEditing:YES];
    
    // 二维码扫描
    ZXingWidgetController *widController = [[ZXingWidgetController alloc] initWithDelegate:self showCancel:YES OneDMode:NO withType:3];
    
    NSMutableSet *readers = [[NSMutableSet alloc] init];
    QRCodeReader *qrcodeReader = [[QRCodeReader alloc] init];
    [readers addObject:qrcodeReader];
    widController.readers = readers;
    
    // 扫描成功的声音
    NSBundle *mainBundle = [NSBundle mainBundle];
    widController.soundToPlay = [NSURL fileURLWithPath:[mainBundle pathForResource:@"beep-beep" ofType:@"caf"] isDirectory:YES];
    
    [self.navigationController pushViewController:widController animated:YES];
    
}

#pragma mark ZxingDelegate
- (void)zxingController:(ZXingWidgetController*)controller didScanResult:(NSString *)result {
    
    NSLog(@"result = %@",result);
    
    if ( [result hasPrefix:@"cityandcityvipcard_"] ) {
        
        [self CardCheckrequestSubmit:@"qrcode" andqr:result];
        
    }
    
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)zxingControllerDidCancel:(ZXingWidgetController*)controller {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - 会员卡下面的待支付订单请求接口
- (void)orderListRequestSubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    // 刷新请求数据接口
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId, @"cashierAccountID",
                                key,@"key",nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
//    
//    [requstClient request:@"WaitPayOrderList.ashx" parameters:parameters successed:^(JSONDecoder*json,id responseObject){
    
    NSLog(@"params = %@",parameters);

    
    [requstClient request:@"CloudMenuOrderList.ashx" parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        NSLog(@"%@",handlJson);

        if (success) {
            
            [SVProgressHUD dismiss];
            
            self.m_orderList = [handlJson valueForKey:@"orderList"];
            
            if ( self.m_orderList.count != 0 ) {
                
                self.m_scrollerView.hidden = NO;
                // 初始化scrollerView
                [self initwithScroller];
           
            }else{
                
                self.m_scrollerView.hidden = YES;

            }
            
            
            
        }else
        {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
        }
    } failured:^(NSError* error)
     {
         
         [SVProgressHUD showErrorWithStatus:error.description];
     }];

}

- (void)initwithScroller{
    
    // 先删除已经存在的view
    for (UIView *view in self.m_scrollerView.subviews ) {
        
        if ( [view isKindOfClass:[UILabel class]] || [view isKindOfClass:[CategoryView class]] ) {
            
            [view removeFromSuperview];
            
        }
    }
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0,WindowSizeWidth - 20, 20)];
    
    label.text = @"订单座位";
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:14.0f];
    
    [self.m_scrollerView addSubview:label];
    
    
    CGFloat width = WindowSizeWidth;
    CGFloat padding = 10;
    // 记录总坐标
    CGFloat  sum = 0.0;
    
    CategoryView *currentView = [[CategoryView alloc]init];
    
    currentView.delegate = self;
    
    [currentView setArray:self.m_orderList];
    
    currentView.frame = CGRectMake(0, sum, width, currentView.m_view.frame.size.height + 20);
    
    sum = sum + currentView.frame.size.height + padding;
    
    [self.m_scrollerView addSubview:currentView];
    
    float height = [UIScreen mainScreen].bounds.size.height;
    
    if ( sum < height - 200 ) {
        
        self.m_scrollerView.frame = CGRectMake(0, 205, WindowSizeWidth, sum);

    }else{
        
        self.m_scrollerView.frame = CGRectMake(0, 205, WindowSizeWidth,  height - 280);
        
    }
    
    
    self.m_scrollerView.contentSize = CGSizeMake(WindowSizeWidth, sum + 50);

    
}

#pragma mark - CategoryDelegate
- (void)getCategoryClassId:(NSMutableDictionary *)dic{
    
    
    NSString *seatId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"SeatID"]];
    NSString *orderId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"CloudMenuOrderID"]];
    
   NSString *seatName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"SeatName"]];
    
    // 进入菜单的订单详情
    if ( seatId.length != 0 ) {
        // 如果座位id有值的话则表示是从收银台点单的，表示已经有座位
        MenuOrderDetailViewController *VC = [[MenuOrderDetailViewController alloc]initWithNibName:@"MenuOrderDetailViewController" bundle:nil];
        VC.m_orderId = orderId;
        VC.m_status = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Status"]];
        VC.m_seatName = seatName;
        [self.navigationController pushViewController:VC animated:YES];
        
    }else{
        // 没值的话表示从诲诲点单进入的-要进行选择座位
        Ca_MenuOrderViewController *VC = [[Ca_MenuOrderViewController alloc]initWithNibName:@"Ca_MenuOrderViewController" bundle:nil];
        VC.m_orderId = [NSString stringWithFormat:@"%@",orderId];
        VC.m_status = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Status"]];
        [self.navigationController pushViewController:VC animated:YES];
        
    }
  
}


- (IBAction)waimaiBtn:(id)sender {
    // 进入外卖订单的页面
    WaimaiOrderViewController *VC = [[WaimaiOrderViewController alloc]initWithNibName:@"WaimaiOrderViewController" bundle:nil];
    
    [self.navigationController pushViewController:VC animated:YES];
}
@end
