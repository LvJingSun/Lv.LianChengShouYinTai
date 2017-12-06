 //
//  ConsoleViewController.m
//  CashierDeskIphone
//
//  Created by mac on 13-9-8.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "ConsoleViewController.h"

#import "ConsoleHandViewController.h"

#import "SureSoleCell.h"

#import <QRCodeReader.h>

#import "ValidateResultViewController.h"

#import "ConsumerData.h"

#import "QuanquanResultViewController.h"

#import "upcardchoseViewController.h"
#import "BalancashierViewController.h"
#import "WaimaiOrderViewController.h"
#import "RowNumberController.h"
#import "HuaHuaViewController.h"
#import "QFFController.h"


@interface ConsoleViewController ()

//@property (nonatomic, strong) ZBarReaderViewController *mWidgetController;


// 二维码扫描
- (IBAction)scanClicked:(id)sender;

// 外卖订单按钮触发的事件
- (IBAction)waimaiOrderClicked:(id)sender;



@end

@implementation ConsoleViewController

@synthesize m_leftBtn;

@synthesize m_rightBtn;

@synthesize m_stringType;

@synthesize m_handView;

@synthesize m_quickView;

@synthesize m_scrollerView;

@synthesize m_red_leftBtn;

@synthesize m_red_midBtn;

@synthesize m_red_rightBtn;

@synthesize m_slideImag;

@synthesize m_firstView;

@synthesize m_phoneTextField;

@synthesize m_priceTextField;

@synthesize m_pageSize;

@synthesize m_consumerArray;

@synthesize m_payConsumerArray;

@synthesize m_ScanString;

@synthesize m_tempView;

@synthesize m_imageView;

@synthesize keyShow;

@synthesize mWidgetController;

@synthesize readline;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.m_pageSize = 1;
        
        m_consumerArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_payConsumerArray = [[NSMutableArray alloc]initWithCapacity:0];
                
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.translucent = NO;

    self.needDone = YES;
    keyShow = NO;
    
    self.m_ScanString = @"0";
    
    self.m_scanIndex = 0;
    
    // 版本判断
    if ( isIOS7 ) {
        
        [self.m_titleVIew setFrame:CGRectMake(0, 20, 320, 48)];
        
        if ( iPhone5 ) {
            
            [self.m_quickView setFrame:CGRectMake(0, 68, 320, [[UIScreen mainScreen]bounds].size.height - 20 - 48)];
            
            [self.m_handView setFrame:CGRectMake(0, 68, 320, [[UIScreen mainScreen]bounds].size.height - 20 - 48)];
        }else{
            
            [self.m_quickView setFrame:CGRectMake(0, 68, 320, [[UIScreen mainScreen]bounds].size.height)];
            
            [self.m_handView setFrame:CGRectMake(0, 68, 320, [[UIScreen mainScreen]bounds].size.height)];
        }
            
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
        label.backgroundColor = [UIColor blackColor];
        
        [self.view addSubview:label];
        

    }else{
        
        [self.m_titleVIew setFrame:CGRectMake(0, 0, 320, 48)];
        
        [self.m_quickView setFrame:CGRectMake(0, 48, 320, self.view.frame.size.height - 48)];
        
        [self.m_handView setFrame:CGRectMake(0, 48, 320, self.view.frame.size.height - 48)];
        
    }
    
    
    self.m_priceTextField.delegate = self;
    
    self.m_phoneTextField.delegate = self;
    
    [self setLeftBtn:YES rightBtn:NO];
    
    self.m_stringType = @"0";
    
    if ( iPhone5 ) {
        
        [self.m_tempView setFrame:CGRectMake(0, 334, 320, 117)];
        
        [self.m_scrollerView setFrame:CGRectMake(0, 0, 320, 334)];
        
        [self.m_scrollerView setContentSize:CGSizeMake(960, 334)];

    }else{
        
        [self.m_tempView setFrame:CGRectMake(0, 246, 320, 117)];
        
        [self.m_scrollerView setFrame:CGRectMake(0, 0, 320, 246)];
        
        [self.m_scrollerView setContentSize:CGSizeMake(960, 246)];
        
    }
    
    // 设置scrollerView的能滚动的范围
    [self.m_scrollerView setContentSize:CGSizeMake(960, self.m_scrollerView.frame.size.height)];
    
    // scrollerView翻页滚动
    self.m_scrollerView.pagingEnabled = YES;
    
    // scrollerView添加三个视图
    [self.m_firstView setFrame:CGRectMake(0, 0, 320, 230)];
   
    [self.m_scrollerView addSubview:self.m_firstView];
    
    self.m_secondView.frame = CGRectMake(320, 0, 320, self.m_scrollerView.frame.size.height);

    [self.m_scrollerView addSubview:self.m_secondView];
    
    self.m_thirdView.frame = CGRectMake(640, 0, 320, self.m_scrollerView.frame.size.height);
    
    [self.m_scrollerView addSubview:self.m_thirdView];
    
    // 设置滑动的图片
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(57, self.m_scrollerView.frame.size.height - 7, 15, 10)];
    
    img.image = [UIImage imageNamed:@"consumer_cashier_icon_arrow.png"];
    
    self.m_slideImag = img;
    
    [self.m_handView addSubview:self.m_slideImag];
    
    // 设置下拉刷新的代理
    [self.m_secondTableView setPullDelegate:self];
    
    [self.m_secondTableView setPullBackgroundColor:[UIColor whiteColor]];
    
    self.m_secondTableView.useRefreshView = YES;
  
    self.m_secondTableView.useLoadingMoreView= YES;
    
    [self.m_thirdTableVIew setPullDelegate:self];
    
    [self.m_thirdTableVIew setPullBackgroundColor:[UIColor whiteColor]];
    
    self.m_thirdTableVIew.useRefreshView = YES;
    
    self.m_thirdTableVIew.useLoadingMoreView= YES;
    
    // 隐藏无数据时的提示
    self.m_emptyLabel.hidden = YES;
    self.m_emptySureLabel.hidden = YES;

   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
   
    [super viewDidAppear:animated];

            
    if ( !(self.m_scanIndex == 2) ) {
        
        self.m_phoneTextField.text = @"";
        
        self.m_priceTextField.text = @"";
   
    }else{
        
//        self.m_scanIndex = 0;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    ISscaning = NO;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.navigationController.navigationBarHidden = YES;
    
//    self.mWidgetController.readerDelegate = self;

    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
}

- (void)setLeftBtn:(BOOL)aLeft rightBtn:(BOOL)aRight{
    
    m_leftBtn.selected = aLeft;
    
    m_rightBtn.selected = aRight;
    
    if ( aLeft ) {
        
        m_leftBtn.userInteractionEnabled = NO;
        
        m_rightBtn.userInteractionEnabled = YES;
        
        self.m_quickView.hidden = NO;
        
        self.m_handView.hidden = YES;
        
    }else{
        
        m_leftBtn.userInteractionEnabled = YES;
        
        m_rightBtn.userInteractionEnabled = NO;
        
        self.m_quickView.hidden = YES;
        
        self.m_handView.hidden = NO;
        
        // 点击时选中第一个
        [self setLeft:YES midBtn:NO rightBtn:NO];
    }
    
}

#pragma mark - Btn Clicked
- (IBAction)btnClicked:(id)sender {
    
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

- (IBAction)quickCash:(id)sender {
    
//    QRCodeViewController *VC = [[QRCodeViewController alloc]initWithNibName:@"QRCodeViewController" bundle:nil];
//    
//    [self.navigationController pushViewController:VC animated:YES];
    
    self.m_scanIndex = 1;
    
    ZXingWidgetController *widController = [[ZXingWidgetController alloc] initWithDelegate:self showCancel:YES OneDMode:NO withType:1];
    
    NSMutableSet *readers = [[NSMutableSet alloc] init];
    QRCodeReader *qrcodeReader = [[QRCodeReader alloc] init];
    [readers addObject:qrcodeReader];
    widController.readers = readers;
    
    NSBundle *mainBundle = [NSBundle mainBundle];
    widController.soundToPlay = [NSURL fileURLWithPath:[mainBundle pathForResource:@"beep-beep" ofType:@"caf"] isDirectory:YES];
    
    [self.navigationController pushViewController:widController animated:YES];
    
    
}


- (IBAction)handCash:(id)sender {
    
    ConsoleHandViewController *viewController = [[ConsoleHandViewController alloc]initWithNibName:@"ConsoleHandViewController" bundle:nil];
    
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)setLeft:(BOOL)aLeft midBtn:(BOOL)aMid rightBtn:(BOOL)aRight{
    
    
    self.m_pageSize = 1;
    
    m_red_leftBtn.selected = aLeft;
    
    m_red_midBtn.selected = aMid;
    
    m_red_rightBtn.selected = aRight;
    
    if ( aLeft ) {
        
        self.m_typeString = @"0";

        m_red_leftBtn.userInteractionEnabled = NO;
        
        m_red_midBtn.userInteractionEnabled = YES;
        
        m_red_rightBtn.userInteractionEnabled = YES;
        
        [self.m_slideImag setFrame:CGRectMake(57, self.m_scrollerView.frame.size.height - 7, 15, 10)];
        
        [self.m_scrollerView setContentOffset:CGPointMake(0, 0) animated:YES];
        
    }
    
    if ( aMid ) {
        
        self.m_typeString = @"1";

        m_red_leftBtn.userInteractionEnabled = YES;
        
        m_red_midBtn.userInteractionEnabled = NO;
        
        m_red_rightBtn.userInteractionEnabled = YES;
        
        [self.m_slideImag setFrame:CGRectMake(153, self.m_scrollerView.frame.size.height - 7, 15, 10)];
        
        [self.m_scrollerView setContentOffset:CGPointMake(320, 0) animated:YES];
        
        
        // 请求数据
        [self requestPaySubmit];
        
    }
    
    if ( aRight ) {
        
        self.m_typeString = @"2";
        
        m_red_leftBtn.userInteractionEnabled = YES;
        
        m_red_midBtn.userInteractionEnabled = YES;
        
        m_red_rightBtn.userInteractionEnabled = NO;
        
        [self.m_slideImag setFrame:CGRectMake(250, self.m_scrollerView.frame.size.height - 7, 15, 10)];
        
        [self.m_scrollerView setContentOffset:CGPointMake(640, 0) animated:YES];

        
        // 待确认请求数据
        [self requestCustomerPay];
        
    }

}

// 选择三种状态
- (IBAction)changStateClicked:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    if ( btn.tag == 111 ) {
        
        [self setLeft:YES midBtn:NO rightBtn:NO];
        
        
    }else if ( btn.tag == 222 ){
        
        [self setLeft:NO midBtn:YES rightBtn:NO];

    }else{
        
        [self setLeft:NO midBtn:NO rightBtn:YES];
       
    }
}

- (IBAction)makeSure:(id)sender {
    
    [self.view endEditing:YES];

    // 判断输入多个小数点的情况
    NSArray *array = [self.m_priceTextField.text componentsSeparatedByString:@"."];

    if ( array.count > 2 ) {
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示"
                                                           message:@"您输入的价钱格式不对,请重新输入"
                                                          delegate:nil
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles: nil];
        [alertView show];
        
        return;
        
    }
    
    // 请求网络数据
    [self requestSubmit];
         
}

#pragma mark - NetWork requestSubmit
// 消费收银请求数据 - 消费结账
- (void)requestSubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    if ( m_phoneTextField.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"客户手机号不能为空！"];
        
        return;
    }
    
    if ( m_priceTextField.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"消费金额不能为空！"];
        
        return;
    }
    
   
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
        
    // 刷新请求数据接口
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId, @"cashierAccountId",
                                key,@"key",
                                self.m_priceTextField.text,@"amount",
                                self.m_phoneTextField.text,@"phone",nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [requstClient request:CDHTTPRequestHandCashier parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        NSLog(@"%@",handlJson);
        
        BaseRetData *Data = [[BaseRetData alloc]initWithJsonObject:handlJson];
        
        BOOL success = [Data.status boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            // 收银成功后
            [self setLeft:NO midBtn:YES rightBtn:NO];
            
            // 将数据清空
            self.m_phoneTextField.text = @"";
            
            self.m_priceTextField.text = @"";
            
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

// 确认中得状态请求数据-待付款
- (void)requestPaySubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    if ( self.m_pageSize == 1 ) {
        
        [self.m_consumerArray removeAllObjects];
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    // 刷新请求数据接口 CRConfirmation 确认中,CRHasBeenPaid 已支付,CRRecognized 已确认
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId, @"cashierAccountId",
                                key,@"key",
                                [NSString stringWithFormat:@"%li",(long)self.m_pageSize],@"pageIndex",
                                @"CRConfirmation",@"status",nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [requstClient request:CDHTTPRequestConsumer parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        ConsumerData *Data = [[ConsumerData alloc]initWithJsonObject:handlJson];
        
        NSLog(@"handlJson = %@",handlJson);
        
        BOOL success = [Data.status boolValue];
        
        if (success) {
            
            [self.m_consumerArray addObjectsFromArray:Data.confirmCashRecognized];
            
            if ( self.m_consumerArray.count != 0 ) {
                
                self.m_emptyLabel.hidden = YES;

                self.m_secondTableView.hidden = NO;
                
            }else{
                
                self.m_emptyLabel.hidden = NO;
                
                self.m_secondTableView.hidden = YES;
            }

            
            [SVProgressHUD dismiss];
            
            [self.m_secondTableView reloadData];
            
        }else
        {
            
            [SVProgressHUD showErrorWithStatus:Data.msg];
            
            
        }
        
        self.m_secondTableView.pullLastRefreshDate = [NSDate date];
        
        self.m_secondTableView.pullTableIsRefreshing = NO;
        
        self.m_secondTableView.pullTableIsLoadingMore = NO;


    } failured:^(NSError* error)
     {
         NSLog(@"error:%@",error.description);
         
         [SVProgressHUD showErrorWithStatus:error.description];
                  
         self.m_secondTableView.pullTableIsRefreshing = NO;
         
         self.m_secondTableView.pullTableIsLoadingMore = NO;


     }];
    
}
// 待确认请求数据
- (void)requestCustomerPay{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    if ( self.m_pageSize == 1 ) {
        
        [self.m_payConsumerArray removeAllObjects];
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    // 刷新请求数据接口 已支付  CRConfirmation 确认中,CRHasBeenPaid 已支付,CRRecognized 已确认
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId, @"cashierAccountId",
                                key,@"key",
                                [NSString stringWithFormat:@"%i",self.m_pageSize],@"pageIndex",
                                @"CRHasBeenPaid",@"status",nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [requstClient request:CDHTTPRequestConsumer parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        ConsumerData *Data = [[ConsumerData alloc]initWithJsonObject:handlJson];
        
        BOOL success = [Data.status boolValue];
        
        if (success) {
            
            [self.m_payConsumerArray addObjectsFromArray:Data.confirmCashRecognized];
            
            if ( self.m_payConsumerArray.count != 0 ) {
                
                self.m_emptySureLabel.hidden = YES;
                
                self.m_thirdTableVIew.hidden = NO;
                
            }else{
                
                self.m_emptySureLabel.hidden = NO;
                
                self.m_thirdTableVIew.hidden = YES;
            }
            
            
            [SVProgressHUD dismiss];
            
            [self.m_thirdTableVIew reloadData];
            
        }else
        {
            
            [SVProgressHUD showErrorWithStatus:Data.msg];
            
        }
        
        self.m_thirdTableVIew.pullLastRefreshDate = [NSDate date];
        
        self.m_thirdTableVIew.pullTableIsRefreshing = NO;

        self.m_thirdTableVIew.pullTableIsLoadingMore = NO;

        
    } failured:^(NSError* error)
     {
         NSLog(@"error:%@",error.description);
         
         [SVProgressHUD showErrorWithStatus:error.description];
                  
         self.m_thirdTableVIew.pullTableIsRefreshing = NO;

         self.m_thirdTableVIew.pullTableIsLoadingMore = NO;

     }];    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 111111) {
        
        if ( buttonIndex == 1 ) {
            
            // 判断网络是否存在
            if ( ![self isConnectionAvailable] ) {
                
                return;
            }
            
            ConsumerDetailData *data = (ConsumerDetailData *)[self.m_consumerArray objectAtIndex:self.m_index];
            
            NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
            NSString *key = [CommonUtil getServerKey];
            
            // 刷新请求数据接口 ======== status 状态的值 ========
            HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
            NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                        memberId, @"cashierAccountId",
                                        key,@"key",
                                        data.CashRegisterRecordId,@"cashRegisterRecordId",nil];
            
            [SVProgressHUD showWithStatus:@"数据加载中"];
            
            [requstClient request:CDHTTPRequestCustomerCancel parameters:parameters successed:^(JSONDecoder*json,id responseObject){
                
                NSData* data = [NSData dataWithData:responseObject];
                
                NSDictionary* handlJson = [json objectWithData:data];
                
                BaseRetData *Data = [[BaseRetData alloc]initWithJsonObject:handlJson];
                            
                BOOL success = [Data.status boolValue];
                
                if (success) {
                    
                    
                    [SVProgressHUD dismiss];
                    
                    self.m_pageSize = 1;
                    
                    // 重新请求数据，刷新页面
                    [self requestPaySubmit];
                    
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
    }else if ( alertView.tag == 111112 ){
        
        if ( buttonIndex == 1 ) {
            
            // 判断网络是否存在
            if ( ![self isConnectionAvailable] ) {
                
                return;
            }
            
            // 确认操作请求数据
            
            ConsumerDetailData *data = (ConsumerDetailData *)[self.m_payConsumerArray objectAtIndex:self.m_ConformIndex];
            
            
            NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
            NSString *key = [CommonUtil getServerKey];
            
            
            // 刷新请求数据接口 ======== status 状态的值 ========
            HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
            NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                        memberId, @"cashierAccountId",
                                        key,@"key",
                                        data.CashRegisterRecordId,@"cashRegisterRecordId",nil];
            
            [SVProgressHUD showWithStatus:@"数据加载中"];
            
            [requstClient request:CDHTTPRequestCustomerConfirm parameters:parameters successed:^(JSONDecoder*json,id responseObject){
                
                NSData* data = [NSData dataWithData:responseObject];
                
                NSDictionary* handlJson = [json objectWithData:data];
                
                BaseRetData *Data = [[BaseRetData alloc]initWithJsonObject:handlJson];
                
                BOOL success = [Data.status boolValue];
                
                if (success) {
                    
                    [SVProgressHUD dismiss];
                    
                    // 确认之后设置为第一页
                    self.m_pageSize = 1;
                    
                    // 重新请求数据，刷新页面
                    [self requestCustomerPay];
                    
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
    }
}


// 取消操作请求数据
- (void)customerCancel:(id)sender{
   
    // 取消操作请求数据
    
    UIButton *btn = (UIButton *)sender;
    
    self.m_index = btn.tag;
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示"
                                                       message:@"确定取消操作？"
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                             otherButtonTitles:@"确定", nil];
    alertView.tag = 111111;
    
    [alertView show];

   
}

// 确认操作请求数据
- (void)customerConfirm:(id)sender{
    
    
    UIButton *btn = (UIButton *)sender;
    
    self.m_ConformIndex = btn.tag;
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示"
                                                       message:@"确定收银操作？"
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                             otherButtonTitles:@"确定", nil];
    alertView.tag = 111112;
    
    [alertView show];

    
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)sender {
    
    [self hidenKeyboard];
    
    [sender resignFirstResponder];
    
    return YES;
    
}

//UITextField的协议方法，当开始编辑时监听
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
  
    self.m_activityField = textField;
    
     // 手动调动下键盘显示的方法
    if ( textField == m_priceTextField ) {
       self.doneButton.userInteractionEnabled = YES;
        [self showKeyboard:nil];
        
    } else if ( textField == self.m_phoneTextField ) {
        
        self.doneButton.userInteractionEnabled = NO;
        
        [self showKeyboard:nil];
    }

    return YES;
}

//隐藏键盘的方法
-(void)hidenKeyboard {
    [self.m_phoneTextField resignFirstResponder];
    [self.m_priceTextField resignFirstResponder];

    [self resumeView];
}

//恢复原始视图位置
-(void)resumeView {
    NSTimeInterval animationDuration=0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    float Y = 0.0f;
    CGRect rect=CGRectMake(0.0f,Y,width,height);
    self.view.frame=rect;
    [UIView commitAnimations];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ( tableView == self.m_secondTableView ) {
        
         return [self.m_consumerArray count];
        
    }else{
        
        return [self.m_payConsumerArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"SureSoleCellIdentifier";
    
    SureSoleCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"SureSoleCell" owner:self options:nil];
        
        cell = (SureSoleCell *)[nib objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    if ( tableView == self.m_secondTableView ) {
        
        if ( self.m_consumerArray.count != 0 ) {
            
            ConsumerDetailData *data = (ConsumerDetailData *)[self.m_consumerArray objectAtIndex:indexPath.row];
            
            cell.m_priceLabel.text = [NSString stringWithFormat:@"%.2f",[data.Amount floatValue]];
            
            cell.m_phoneLabel.text = [NSString stringWithFormat:@"%@（ %@ ）",data.Phone,data.RealName];
            
            cell.suringLabel.text = @"正在确认中...";
            
            cell.m_btn.tag = indexPath.row;
            
            [cell.m_btn setTitle:@"取消" forState:UIControlStateNormal];
            
            [cell.m_btn addTarget:self action:@selector(customerCancel:) forControlEvents:UIControlEventTouchUpInside];
          
        }
        
    }else{
        
        if ( self.m_payConsumerArray.count != 0 ) {
           
            ConsumerDetailData *data = (ConsumerDetailData *)[self.m_payConsumerArray objectAtIndex:indexPath.row];
            
            cell.m_priceLabel.text = [NSString stringWithFormat:@"%.2f",[data.Amount floatValue]];
            
            cell.m_phoneLabel.text = [NSString stringWithFormat:@"%@（ %@ ）",data.Phone,data.RealName];
            
            cell.suringLabel.text = @"已付款";

            cell.m_btn.tag = indexPath.row;
            
            [cell.m_btn setTitle:@"确定" forState:UIControlStateNormal];

            [cell.m_btn addTarget:self action:@selector(customerConfirm:) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70.0f;
}

#pragma mark - UIScrollerView
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self.m_phoneTextField resignFirstResponder];
    [self.m_priceTextField resignFirstResponder];
    
    // 判断scrollerView滚动的范围，然后计算当前显示的是第几页，设置button的选中状态
    if ( scrollView == self.m_scrollerView ) {
        
        NSInteger page = scrollView.contentOffset.x / 320;
                        
        if ( page == 0 ) {
            
            [self setLeft:YES midBtn:NO rightBtn:NO];
                        
        }else if ( page == 1 ){
                        
            [self setLeft:NO midBtn:YES rightBtn:NO];
                        
        }else{
            
            [self setLeft:NO midBtn:NO rightBtn:YES];
                                    
        }

    }
}

#pragma mark ZxingDelegate
- (void)zxingController:(ZXingWidgetController*)controller didScanResult:(NSString *)result {
  
    // 判断是手机号码还是key值扫描 == key 值扫描
    if ( self.m_scanIndex == 1 ) {
        
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
       
    }else{
        
        // 手机号码扫描
        
        NSString *resultString;
        
        // 字符串是否以http://开头,如果不是则就表示是手机号；如果是，则是公众邀请码的一个链接，需截取其中的一个手机号
        if ( [result hasPrefix:@"http://"] ) {
            
            NSArray *array = [result componentsSeparatedByString:@"inviteCode="];
            
            NSString *string = [NSString stringWithFormat:@"%@",[array objectAtIndex:1]];
            
            
            // 请求数据，由公众邀请码去获得手机号
            [self validatePhone:string];
            
        }else{
            
            resultString = [NSString stringWithFormat:@"%@",result];
            
            self.m_phoneTextField.text = [NSString stringWithFormat:@"%@",resultString];

        }

        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}

- (void)zxingControllerDidCancel:(ZXingWidgetController*)controller {
//    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.navigationController popViewControllerAnimated:YES];

}



// 用扫描来的公众邀请码去获得手机号
- (void)validatePhone:(NSString *)aPhone{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    // 刷新请求数据接口 ======== status 状态的值 ========
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId, @"cashierAccountId",
                                key,@"key",
                                [NSString stringWithFormat:@"%@",aPhone],@"pubInvCode",nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [requstClient request:CDHTTPRequestPhone parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        BaseRetData *Data = [[BaseRetData alloc]initWithJsonObject:handlJson];
        
        BOOL success = [Data.status boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            self.m_phoneTextField.text = [NSString stringWithFormat:@"%@",Data.msg];

        
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

#pragma mark - PullTableViewDelegate

- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {
    
    self.m_pageSize = 1;
    
    if (  [self.m_typeString isEqualToString:@"1"] ) {
        
        [self performSelector:@selector(requestPaySubmit) withObject:nil];
        
    }else if ( [self.m_typeString isEqualToString:@"2"] ) {
        
        [self performSelector:@selector(requestCustomerPay) withObject:nil];
        
    }
    
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {
    
    self.m_pageSize ++;
    
    if (  [self.m_typeString isEqualToString:@"1"] ) {
        
        [self performSelector:@selector(requestPaySubmit) withObject:nil];
        
    }else if (  [self.m_typeString isEqualToString:@"2"] ) {
        
        [self performSelector:@selector(requestCustomerPay) withObject:nil];
        
    }
    
}

// 完成按钮改为小数点
- (void)handleKeyboardWillHide:(NSNotification *)notification
{
    if (self.doneButton.superview)
    {
        [self.doneButton removeFromSuperview];
    }
    if (!keyShow) {
        return;
    }
//    if (self.rootScrollView != nil) {
//        NSDictionary *info = [notification userInfo];
//        NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
//        CGSize keybroundSize = [value CGRectValue].size;
//        CGRect viewFrame = [self.rootScrollView frame];
//        viewFrame.size.height += keybroundSize.height;
//        self.rootScrollView.frame = viewFrame;
//    }
    keyShow = NO;
}

- (void)handleKeyboardDidShow:(NSNotification *)notification
{
    // create custom button
    if (self.doneButton == nil)
    {
        self.doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
        if (screenHeight==568.0f) {//爱疯5
            self.doneButton.frame = CGRectMake(0, 568 - 53, 106, 53);
        } else {//3.5寸
            self.doneButton.frame = CGRectMake(0, 480 - 53, 106, 53);
        }
        
        
        self.doneButton.adjustsImageWhenHighlighted = NO;
        self.doneButton.hidden=self.needDone;
        [self.doneButton setImage:[UIImage imageNamed:@"btn_done_normal.png"] forState:UIControlStateNormal];
        [self.doneButton setImage:[UIImage imageNamed:@"btn_done_selected.png"] forState:UIControlStateHighlighted];
        [self.doneButton addTarget:self action:@selector(finishAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    // locate keyboard view
    UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
    if (self.doneButton.superview == nil)
    {
        [tempWindow addSubview:self.doneButton];    // 注意这里直接加到window上
    }
    self.doneButton.hidden=self.needDone;
    if (keyShow) {
        return;
    }
//    if (self.rootScrollView != nil) {
//        NSDictionary *info = [notification userInfo];
//        NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
//        CGSize keybroundSize = [value CGRectValue].size;
//        CGRect viewFrame = [self.rootScrollView frame];
//        viewFrame.size.height -= keybroundSize.height;
//        self.rootScrollView.frame = viewFrame;
//        //[self performSelector:@selector(moveToActiveView) withObject:nil afterDelay:0.5];
//        [self moveToActiveView];
//    }
    keyShow = YES;
    
    if ( self.m_activityField == self.m_priceTextField ) {
        
        self.doneButton.userInteractionEnabled = YES;
   
    }else{
        
        self.doneButton.userInteractionEnabled = NO;

    }
    
}

- (void)moveToActiveView {
    if (self.activeField != nil) {
        //CGRect textFieldRect = [self.activeField frame];
//        CGRect textFieldRect = [self.activeField.superview frame];
        //NSLog(@"(%.0f,%.0f,%.0f,%.0f,)", textFieldRect.origin.x, textFieldRect.origin.y, textFieldRect.size.width, textFieldRect.size.height);
//        [self.rootScrollView scrollRectToVisible:textFieldRect animated:YES];
    }
}

//隐藏键盘的方法
//-(void)hidenKeyboard {
//    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];//关闭键盘
//}

- (void)finishAction
{
//    [self hidenKeyboard];
    
    if ( self.m_activityField == self.m_priceTextField ) {
        
        self.m_priceTextField.text = [self.m_priceTextField.text stringByAppendingString:@"."];

    }
}

- (IBAction)showKeyboard:(id)sender
{
    self.needDone = NO;
    self.doneButton.hidden = self.needDone;
}

- (IBAction)hideKeyboard:(id)sender
{
    self.needDone = YES;
    self.doneButton.hidden = self.needDone;
}

- (IBAction)scanClicked:(id)sender {
    
    [self.m_phoneTextField resignFirstResponder];
    
    [self.m_priceTextField resignFirstResponder];
        
    self.m_scanIndex = 2;
    
    // 二维码扫描
    ZXingWidgetController *widController = [[ZXingWidgetController alloc] initWithDelegate:self showCancel:YES OneDMode:NO withType:2];
    
    NSMutableSet *readers = [[NSMutableSet alloc] init];
    QRCodeReader *qrcodeReader = [[QRCodeReader alloc] init];
    [readers addObject:qrcodeReader];
    widController.readers = readers;
    
    // 扫描成功的声音
    NSBundle *mainBundle = [NSBundle mainBundle];
    widController.soundToPlay = [NSURL fileURLWithPath:[mainBundle pathForResource:@"beep-beep" ofType:@"caf"] isDirectory:YES];
    
    [self.navigationController pushViewController:widController animated:YES];
    
}


-(IBAction)Top_upmembershipcard:(id)sender
{
    upcardchoseViewController *VC = [[upcardchoseViewController alloc]initWithNibName:@"upcardchoseViewController" bundle:nil];
    
    VC.type = @"huiyuan";
    
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (IBAction)HuaHuaChongZhiClick:(id)sender {
    
//    HuaHuaViewController *vc = [[HuaHuaViewController alloc] init];
//    
//    [self.navigationController pushViewController:vc animated:YES];
    
    upcardchoseViewController *VC = [[upcardchoseViewController alloc]initWithNibName:@"upcardchoseViewController" bundle:nil];
    
    VC.type = @"huahua";
    
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (IBAction)PaiHaoClick:(id)sender {
    
    RowNumberController *staffvc = [[RowNumberController alloc] init];
    
    [self .navigationController pushViewController:staffvc animated:YES];
}

- (IBAction)quanfanfuClick:(id)sender {
    
    QFFController *vc = [[QFFController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
