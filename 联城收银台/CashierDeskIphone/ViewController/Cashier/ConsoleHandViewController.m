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


@interface ConsoleHandViewController ()

@property (weak, nonatomic) IBOutlet UIButton *m_leftBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_rightBtn;

@property (weak, nonatomic) IBOutlet UIView *m_quanView;
@property (weak, nonatomic) IBOutlet UIView *m_btnView;

@property (weak, nonatomic) IBOutlet UITextField *m_quanquanTextField;

- (IBAction)btnCilcked:(id)sender;

// 券券验证的按钮触发的事件
- (IBAction)quanquanSureClicked:(id)sender;

@end

@implementation ConsoleHandViewController

@synthesize m_minusBtn;

@synthesize m_plusBtn;

@synthesize m_number;

@synthesize m_numberTextField;

@synthesize m_tableView;

@synthesize m_footerView;

@synthesize m_array;

@synthesize m_activeTextField;

@synthesize m_dic;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_array = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_dic = [[NSMutableDictionary alloc]init];
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
        
        [self.m_titleVIew setFrame:CGRectMake(0, 20, 320, 48)];
        
        [self.m_btnView setFrame:CGRectMake(0, 68, 320, 48)];

        if ( iPhone5 ) {
            
            [self.m_tempView setFrame:CGRectMake(0, 68+48, 320, [[UIScreen mainScreen]bounds].size.height - 20 - 96)];

            [self.m_quanView setFrame:CGRectMake(0, 68+48, 320, [[UIScreen mainScreen]bounds].size.height - 20 - 96)];

        }else{

            [self.m_tempView setFrame:CGRectMake(0, 68+48, 320, [[UIScreen mainScreen]bounds].size.height - 20)];

            [self.m_quanView setFrame:CGRectMake(0, 68+48, 320, [[UIScreen mainScreen]bounds].size.height - 20)];

        }
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
        label.backgroundColor = [UIColor blackColor];
        
        [self.view addSubview:label];
        
    }else{
        
        [self.m_titleVIew setFrame:CGRectMake(0, 0, 320, 48)];
        
        [self.m_btnView setFrame:CGRectMake(0, 48, 320, 48)];

        [self.m_tempView setFrame:CGRectMake(0, 96, 320, self.view.frame.size.height - 96)];
        
        [self.m_quanView setFrame:CGRectMake(0, 96, 320, self.view.frame.size.height - 96)];

        
    }

    self.m_numberTextField.delegate = self;
    
    self.m_number = 1;
    
    self.m_numberTextField.text = [NSString stringWithFormat:@"%i",self.m_number];
    
    self.m_minusBtn.userInteractionEnabled = NO;
    
    self.m_plusBtn.userInteractionEnabled = YES;
    
    [self.m_minusBtn setImage:[UIImage imageNamed:@"number_control_minus_disabled.png"] forState:UIControlStateNormal];
    
    [self.m_plusBtn setImage:[UIImage imageNamed:@"number_control_plus.png"] forState:UIControlStateNormal];
    
    self.m_tableView.tableFooterView = self.m_footerView;
    
   // 默认选中的是key值收银
    [self setLeftBtn:YES rightBtn:NO];
    
    self.m_stringType = @"0";
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 请求数据
- (void)requestSubmit{
    
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSLog(@"m_dic = %@",m_dic);
    
        
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
        
        NSLog(@"handlJson = %@",handlJson);
                        
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

- (IBAction)backLastView:(id)sender {
    
    [self goBack];
}

// 判断输入框里值是否为空
- (BOOL)emptyString{
    
    if ( self.m_numberTextField.text.length == 0 ) {
        
        [self.m_minusBtn setImage:[UIImage imageNamed:@"number_control_minus_disabled.png"] forState:UIControlStateNormal];
        
        self.m_minusBtn.userInteractionEnabled = NO;
        
        self.m_number = 1;
        
        self.m_numberTextField.text = [NSString stringWithFormat:@"%i",self.m_number];
        
        [m_tableView reloadData];
        
        return YES;
        
    }else{
        
        return NO;
    }

}

- (IBAction)minusClicked:(id)sender {
    
    [self.view endEditing:YES];
    
    if ( [self emptyString] ) {
        return;
    }
    
    // 删除数组里的最后一个内容
    if ( self.m_dic.count == self.m_number ) {
        
        [self.m_dic removeObjectForKey:[NSString stringWithFormat:@"%i",self.m_dic.count - 1]];
    }
    
    
    self.m_number = self.m_number - 1;
  
    // 判断减号的按钮是否可以点击以及按钮的背景图片
    if ( self.m_number == 1 || self.m_number == 0 ) {
        
        [self.m_minusBtn setImage:[UIImage imageNamed:@"number_control_minus_disabled.png"] forState:UIControlStateNormal];
        
        self.m_minusBtn.userInteractionEnabled = NO;
        
        self.m_number = 1;
        
    }else{
        
        [self.m_minusBtn setImage:[UIImage imageNamed:@"number_control_minus.png"] forState:UIControlStateNormal];
        
        self.m_minusBtn.userInteractionEnabled = YES;
        
    }
 
    self.m_numberTextField.text = [NSString stringWithFormat:@"%i",self.m_number];
    
    // 刷新tableView
    [m_tableView reloadData];

    
}

- (IBAction)m_plusClicked:(id)sender {
    
    [self.view endEditing:YES];
        
    if ( [self emptyString] ) {
        return;
    }
   
    
    self.m_number = self.m_number + 1;
    
    self.m_minusBtn.userInteractionEnabled = YES;
    
    self.m_numberTextField.text = [NSString stringWithFormat:@"%i",self.m_number];

    [self.m_minusBtn setImage:[UIImage imageNamed:@"number_control_minus.png"] forState:UIControlStateNormal];
        
    [m_tableView reloadData];

    
}

- (IBAction)vidateClicked:(id)sender {
    
    [self.view endEditing:YES];
    
    NSLog(@"%i,%@",m_array.count,m_array);
    
    
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
        
//        cell.m_imageView.frame = CGRectMake(0, 45, 290, 1);
        
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
    cell.m_keyValueTextField.text = [self.m_dic objectForKey:[NSString stringWithFormat:@"%i",indexPath.row]];
    
    
    cell.m_keyValueTextField.tag = indexPath.row;
   
    cell.m_keyValueTextField.delegate = self;
    
    [cell.m_keyValueTextField addTarget:self action:@selector(showNumberPadKeyboard:) forControlEvents:UIControlEventTouchDown];
    
    cell.backgroundView = image;
    
    return cell;
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if ( textField == self.m_quanquanTextField ) {
        
        // 手动调动下键盘隐藏的方法
        [self hideNumberPadKeyboard:nil];

    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    self.m_activeTextField = textField;
        
    if ( self.m_activeTextField != self.m_quanquanTextField ) {
        
        // 手动调动下键盘显示的方法
        [self showNumberPadKeyboard:nil];
                        
        CGRect textFieldRect = CGRectMake(0, textField.tag * 42, 320, 460);
        
        // 设置tableView滚动到点击的哪一行
        [self.m_tableView setContentOffset:CGPointMake(0, textFieldRect.origin.y)];        
        
    }else{
        
        // 手动调动下键盘隐藏的方法
        [self hideNumberPadKeyboard:nil];
        
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if ( textField == self.m_numberTextField ) {
        
        if ( m_numberTextField.text.length == 0 ) {
            
            self.m_numberTextField.text = @"";
            
        }else{
            
            self.m_numberTextField.text = textField.text;
            
            self.m_number = [textField.text integerValue];
            
        }

    }else{
       
        // 将值赋到字典里面
        [self.m_dic setObject:textField.text forKey:[NSString stringWithFormat:@"%i",textField.tag]];

    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)sender {
    
    if ( sender == self.m_numberTextField ) {
        
        self.m_numberTextField.text = sender.text;
        
        [self hidenKeyboard];
        
        return YES;
        
    }else{
        
        [sender resignFirstResponder];
        
        return YES;
    }
}

//隐藏键盘的方法
-(void)hidenKeyboard {
    
    [self.m_tableView setContentOffset:CGPointMake(0, 0)];

    
    [self.m_numberTextField resignFirstResponder];
    [self resumeView];
}

//恢复原始视图位置
-(void)resumeView {
    if ( m_numberTextField.text.length == 0 ) {
        
        self.m_number = 1;
        
        self.m_numberTextField.text = [NSString stringWithFormat:@"%i",self.m_number];
        
        [self.m_minusBtn setImage:[UIImage imageNamed:@"number_control_minus_disabled.png"] forState:UIControlStateNormal];
        
        self.m_minusBtn.userInteractionEnabled = NO;
        
        
    }else if ( [m_numberTextField.text isEqualToString:@"0"] ){
        
        self.m_number = 1;
        
        self.m_numberTextField.text = [NSString stringWithFormat:@"%i",self.m_number];
        
        [self.m_minusBtn setImage:[UIImage imageNamed:@"number_control_minus_disabled.png"] forState:UIControlStateNormal];
        
        self.m_minusBtn.userInteractionEnabled = NO;
        
    }else{
        
        self.m_number = [m_numberTextField.text integerValue];
        
        self.m_numberTextField.text = [NSString stringWithFormat:@"%i",self.m_number];
        
        if ( self.m_number == 1 ) {
            
            [self.m_minusBtn setImage:[UIImage imageNamed:@"number_control_minus_disabled.png"] forState:UIControlStateNormal];
            
            self.m_minusBtn.userInteractionEnabled = NO;
            
            
        }else{
            
            [self.m_minusBtn setImage:[UIImage imageNamed:@"number_control_minus.png"] forState:UIControlStateNormal];
            
            self.m_minusBtn.userInteractionEnabled = YES;
            
        }
        
    }
    
    
    [m_tableView reloadData];
    
}

- (void)setLeftBtn:(BOOL)aLeft rightBtn:(BOOL)aRight{
    
    self.m_leftBtn.selected = aLeft;
    
    self.m_rightBtn.selected = aRight;
    
    if ( aLeft ) {
        
        self.m_leftBtn.userInteractionEnabled = NO;
        
        self.m_rightBtn.userInteractionEnabled = YES;
        
        self.m_tempView.hidden = NO;
        
        self.m_quanView.hidden = YES;
        
    }else{
        
        self.m_leftBtn.userInteractionEnabled = YES;
        
        self.m_rightBtn.userInteractionEnabled = NO;
        
        self.m_tempView.hidden = YES;
        
        self.m_quanView.hidden = NO;
       
    }
    
}

#pragma mark - Btn Clicked
- (IBAction)btnCilcked:(id)sender{
    
    [self.view endEditing:YES];
    
    UIButton *btn = (UIButton *)sender;
    
    if ( btn.tag == 10 ) {
        
        self.m_stringType = @"0";
        
        [self setLeftBtn:YES rightBtn:NO];
        
    }else{
        
        self.m_stringType = @"1";
        
        [self setLeftBtn:NO rightBtn:YES];
    }
    
}

- (IBAction)quanquanSureClicked:(id)sender {
    
    [self.view endEditing:YES];
    
    // 券券验证
    if ( self.m_quanquanTextField.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入券券兑换码"];
        
        return;
    }
    
    // 请求成功后进入券券验证的页面 券券验证
    QuanquanResultViewController *VC = [[QuanquanResultViewController alloc]initWithNibName:@"QuanquanResultViewController" bundle:nil];
    VC.m_quanquanString = [NSString stringWithFormat:@"%@",self.m_quanquanTextField.text];
    [self.navigationController pushViewController:VC animated:YES];
    
}



@end
