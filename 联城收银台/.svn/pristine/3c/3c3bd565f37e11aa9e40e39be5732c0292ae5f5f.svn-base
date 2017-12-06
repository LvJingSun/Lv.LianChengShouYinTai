//
//  MenuOrderDetailViewController.m
//  CashierDeskIphone
//
//  Created by mac on 15-6-11.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "MenuOrderDetailViewController.h"

#import "OrderCell.h"

#import "RightCell.h"

@interface MenuOrderDetailViewController ()

@property (weak, nonatomic) IBOutlet UIView *m_titleView;

@property (weak, nonatomic) IBOutlet UIView *m_tempView;

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@property (weak, nonatomic) IBOutlet UILabel *m_totalPrice;

@property (weak, nonatomic) IBOutlet UIView *m_downView;

@property (weak, nonatomic) IBOutlet UIButton *m_payBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_doneBtn;
@property (weak, nonatomic) IBOutlet UIButton *m_cancelBtn;

@property (weak, nonatomic) IBOutlet TableViewWithBlock *m_righttableView;
@property (weak, nonatomic) IBOutlet UIControl *B_m_alphaView;

- (IBAction)goBack:(id)sender;

// 结账按钮触发的事件
- (IBAction)SubmitOrderClicked:(id)sender;
// 用餐结束后用于更改状态
- (IBAction)endClicked:(id)sender;
// 取消订单按钮触发的事件
- (IBAction)cancelBtnClicked:(id)sender;

- (IBAction)alphaviewtap:(id)sender;

@end

@implementation MenuOrderDetailViewController

@synthesize m_orderId;

@synthesize m_orderDetailList;

@synthesize m_status;

@synthesize B_RightArray;

@synthesize m_seatList;

@synthesize m_dic;

@synthesize m_SectionsSet;

@synthesize m_seatName;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        m_orderDetailList = [[NSMutableArray alloc]initWithCapacity:0];
        
        B_RightArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_seatList = [[NSMutableArray alloc]initWithCapacity:0];
        
        menta = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_dic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        m_SectionsSet = [[NSMutableSet alloc]init];
        
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 版本判断
    if ( isIOS7 ) {
        
        [self.m_titleView setFrame:CGRectMake(0, 20, 320, 48)];
        
        if ( iPhone5 ) {
            
            [self.m_tempView setFrame:CGRectMake(0, 68, 320, [[UIScreen mainScreen]bounds].size.height - 20 - 48 - 50)];
            
        }else{
            
            [self.m_tempView setFrame:CGRectMake(0, 68, 320, [[UIScreen mainScreen]bounds].size.height - 50)];
          
            
        }
        
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
        label.backgroundColor = [UIColor blackColor];
        
        [self.view addSubview:label];
        
    }else{
        
        [self.m_titleView setFrame:CGRectMake(0, 0, 320, 48)];
        
        [self.m_tempView setFrame:CGRectMake(0, 48, 320, self.view.frame.size.height - 48 - 50)];
        
    }
        
    [self.m_downView setFrame:CGRectMake(0, [[UIScreen mainScreen]bounds].size.height - 50, WindowSizeWidth, 50)];
 
    // 设置去掉多余的tableView的分割线
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [self.m_tableView setTableFooterView:view];
    
    
    // 根据状态来判断显示按钮
    if ( [self.m_status isEqualToString:@"1"] ) {
        
        self.m_payBtn.hidden = YES;
        self.m_doneBtn.hidden = NO;
    
        
        // 设置数组
//        [self.B_RightArray addObject:@"更换座位"];
        
        self.m_cancelBtn.hidden = YES;
        
        
    }else{
        
        self.m_payBtn.hidden = NO;
        self.m_doneBtn.hidden = YES;
        
        self.m_cancelBtn.hidden = NO;
        
        // 设置数组
//        [self.B_RightArray addObject:@"更换座位"];
//        [self.B_RightArray addObject:@"取消订单"];

    }
    
   
    
    // 初始化tableView
//    [self B_PaixuDataTotableview];
    
    // 请求详情数据
    [self orderDetailRequest];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
    B_rightOpened = NO;
    
    self.m_righttableView.hidden = YES;
    CGRect frame4 = self.m_righttableView.frame;
    //    frame4.size.height = 0.0f;
    frame4 = CGRectMake(WindowSizeWidth/2, self.m_titleView.frame.size.height + self.m_titleView.frame.origin.y, WindowSizeWidth/2, 0);
    
    [self.m_righttableView setFrame:frame4];
    
    self.B_m_alphaView.alpha = 0;

    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    CGRect frame4 = self.m_righttableView.frame;
    frame4.size.height = 0.0f;
    [self.m_righttableView setFrame:frame4];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBack:(id)sender {
    
    [self goBack];
}

- (IBAction)SubmitOrderClicked:(id)sender {
    
    // 结账请求数据
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
                                key,@"key",
                                [NSString stringWithFormat:@"%@",self.m_orderId],@"cloudMenuOrderId",nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [requstClient request:@"CloudMenuOrderPay.ashx" parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            NSLog(@"%@",handlJson);
            
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(backLastView) userInfo:nil repeats:NO];

            
        }else
        {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
            [CommonUtil addValue:@"1" andKey:@"MenuOrderListKey"];
            
            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(backLastView) userInfo:nil repeats:NO];

            
        }
    } failured:^(NSError* error)
     {
         
         [SVProgressHUD showErrorWithStatus:error.description];
         
         [CommonUtil addValue:@"1" andKey:@"MenuOrderListKey"];
         
         [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(backLastView) userInfo:nil repeats:NO];
         
     }];

}

- (IBAction)endClicked:(id)sender {
    
    // 用餐结束请求数据
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
                                key,@"key",
                                [NSString stringWithFormat:@"%@",self.m_orderId],@"cloudMenuOrderId",nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [requstClient request:@"SetCloudMenuOrderFinished.ashx" parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            [CommonUtil addValue:@"1" andKey:@"MenuOrderListKey"];
            
            NSLog(@"%@",handlJson);
            
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(backLastView) userInfo:nil repeats:NO];
            
            
        }else
        {
            
            [CommonUtil addValue:@"0" andKey:@"MenuOrderListKey"];

            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
        }
    } failured:^(NSError* error)
     {
         
         [CommonUtil addValue:@"0" andKey:@"MenuOrderListKey"];

         [SVProgressHUD showErrorWithStatus:error.description];
     }];
    
    
}

- (IBAction)cancelBtnClicked:(id)sender {
    // 显示tableView
//    [self B_RightOpenBtn];
    
    // 取消订单
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil
                                                       message:@"确定取消订单？"
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                             otherButtonTitles:@"确定", nil];
    alertView.tag = 109324;
    [alertView show];
    
}

- (void)backLastView{
    
    [self goBack];
}

#pragma mark - 详情请求数据
- (void)orderDetailRequest{
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
                                key,@"key",
                                [NSString stringWithFormat:@"%@",self.m_orderId],@"cloudMenuOrderId",nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
//    [requstClient request:@"WaitPayOrderDetail.ashx" parameters:parameters successed:^(JSONDecoder*json,id responseObject){
  
    [requstClient request:@"CloudMenuOrderDetail.ashx" parameters:parameters successed:^(JSONDecoder*json,id responseObject){
    
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            NSLog(@"%@",handlJson);
            
            // 赋值
            self.m_dic = handlJson;
            
            self.m_orderDetailList = [handlJson valueForKey:@"orderDetailList"];
            
            // 赋值
            self.m_totalPrice.text = [NSString stringWithFormat:@"%@元",[handlJson valueForKey:@"PriceAmount"]];
            
            // 刷新列表
            [self.m_tableView reloadData];
           
        }else
        {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
        }
    } failured:^(NSError* error)
     {
         
         [SVProgressHUD showErrorWithStatus:error.description];
     }];
 
}

- (void)cancelOrderRequest{
    
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
                                key,@"key",
                                [NSString stringWithFormat:@"%@",self.m_orderId],@"cloudMenuOrderId",nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [requstClient request:@"DeleteCloudMenuOrder.ashx" parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
            NSLog(@"%@",handlJson);
            
            [CommonUtil addValue:@"1" andKey:@"MenuOrderListKey"];
            
            // 设置成功座位后返回上一级
            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(backLastView) userInfo:nil repeats:NO];
            
            
        }else
        {
            [CommonUtil addValue:@"0" andKey:@"MenuOrderListKey"];

            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
        }
    } failured:^(NSError* error)
     {
         
         [CommonUtil addValue:@"0" andKey:@"MenuOrderListKey"];

         [SVProgressHUD showErrorWithStatus:error.description];
     }];
  
}


#pragma mark - UITableViewDataSource
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.m_orderDetailList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"OrderCellIdentifier";
    
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"OrderCell" owner:self options:nil];
        
        cell = (OrderCell *)[nib objectAtIndex:0];
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
    }
    
    // 赋值
    if ( self.m_orderDetailList.count != 0 ) {
        
        NSDictionary *dic = [self.m_orderDetailList objectAtIndex:indexPath.row];
        
        cell.m_titleLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MenuName"]];

        cell.m_amount.text = [NSString stringWithFormat:@"%@份",[dic objectForKey:@"MenuAmount"]];

        cell.m_price.text = [NSString stringWithFormat:@"%@元",[dic objectForKey:@"MenuPrice"]];

    }
    
    
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60.0f;
    
}

 
*/


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    BOOL expand = [self isSection:section];
    
    if ( !expand ) {
        
        if ( section == 0 ) {
            
            return self.m_orderDetailList.count;
            
        }else{
            
            return 1;
        }
        
    }else {
        
        return 0;
        
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( indexPath.section == 0 ) {
        
        static NSString *cellIdentifier = @"OrderCellIdentifier";
        
        OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if ( cell == nil ) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"OrderCell" owner:self options:nil];
            
            cell = (OrderCell *)[nib objectAtIndex:0];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        // 赋值
        if ( self.m_orderDetailList.count != 0 ) {
            
            NSDictionary *dic = [self.m_orderDetailList objectAtIndex:indexPath.row];
            
            cell.m_titleLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MenuName"]];
            
            cell.m_amount.text = [NSString stringWithFormat:@"%@份",[dic objectForKey:@"MenuAmount"]];
            
            cell.m_price.text = [NSString stringWithFormat:@"%@元",[dic objectForKey:@"MenuPrice"]];
            
        }
        
        return cell;
        
    }else if ( indexPath.section == 1 ){
        
        static NSString *cellIdentifier = @"MenuOrderInfoCellIdentifier";
        
        MenuOrderInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if ( cell == nil ) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"OrderCell" owner:self options:nil];
            
            cell = (MenuOrderInfoCell *)[nib objectAtIndex:1];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        // 赋值
        if ( self.m_dic.count != 0 ) {
            
            cell.m_account.text = [NSString stringWithFormat:@"%@ (%@)",[self.m_dic objectForKey:@"Account"],[self.m_dic objectForKey:@"NickName"]];
            
            NSString *count = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"CloudMenuPerson"]];
            
            if ( count.length != 0 ) {
                
                cell.m_personCount.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"CloudMenuPerson"]];
                
            }else{
                
                cell.m_personCount.text = @"暂无信息";
            }
            
            NSString *time = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"BookDateTime"]];
            
            if ( time.length != 0 ) {
                
                cell.m_time.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"BookDateTime"]];

            }else{
                
                cell.m_time.text = @"暂无信息";
                
            }
            
            
            [cell.m_callBtn addTarget:self action:@selector(callBtn:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        return cell;
        
    }else{
        
        static NSString *cellIdentifier = @"MEnuOrderSeatCellIdentifier";
        
        MEnuOrderSeatCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if ( cell == nil ) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"OrderCell" owner:self options:nil];
            
            cell = (MEnuOrderSeatCell *)[nib objectAtIndex:2];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        // 赋值
        cell.m_seatName.text = [NSString stringWithFormat:@"%@",self.m_seatName];
        [cell.m_seatBtn setTitle:@"更换座位" forState:UIControlStateNormal];
        [cell.m_seatBtn addTarget:self action:@selector(ChangeSeat) forControlEvents:UIControlEventTouchUpInside];
        
        
        return cell;

    }
    
}

- (void)callBtn:(id)sender{
    
    // 判断设备是否支持
    if([[[UIDevice currentDevice] model] rangeOfString:@"iPhone Simulator"].location != NSNotFound) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                        message:@"该设备暂不支持电话功能"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles: nil];
        [alert show];
        
    }else{
        
        self.m_webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
        
        NSString *phone = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"Account"]];
        [self.m_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", phone]]]];
        
    }
    
}

#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if ( section == 2 ) {
        
        return nil;
        
    }else{
        
        UIView *tempView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowSizeWidth, 44)];
        tempView.backgroundColor = [UIColor whiteColor];
        
        // 显示名称
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 200, 34)];
        
        if ( section == 0 ) {
            
            label.text = @"预定的商品";
            
        }else{
            
            label.text = @"预定人信息";
            
        }
        
        //    label.textColor = RGBACKTAB;
        label.font = [UIFont systemFontOfSize:16.0f];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentLeft;
        [tempView addSubview:label];
        
        
        // 根据字典里的值显示按钮勾选的状态
        //    NSMutableSet *expandedSectionsSet = [self.m_dic objectForKey:[NSNumber numberWithInteger:section]];
        
        
        // 添加按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, WindowSizeWidth, 44);
        [btn addTarget:self action:@selector(headerClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = section;
        [tempView addSubview:btn];
        
        // 添加箭头变化的图片
        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(WindowSizeWidth - 30, 17, 16, 10)];
        
        BOOL expand = [self isSection:section];
        
        // 判断是展开还是闭合
        if ( expand ) {
            
            imgV.image = [UIImage imageNamed:@"arrow_L_up.png"];
            
        } else {
            
            imgV.image = [UIImage imageNamed:@"arrow_L_down.png"];
            
        }
        
        
        [tempView addSubview:imgV];
        
        
        return tempView;

    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if ( section == 2 ) {
        
        return 0.0f;
        
    }else{
        
        return 44.0f;

    }


}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( indexPath.section == 0 ) {
        
        return 60.0f;
        
    }else if ( indexPath.section == 1 ) {
        
        return 75.0f;
        
    }else{
        
        return 44.0f;
    }
    
}

// 判断是否展开
- (BOOL)isSection:(NSInteger)section{
    
    BOOL result = NO;
    
    if ( [self.m_SectionsSet containsObject:[NSNumber numberWithInteger:section]] ) {
        
        result = YES;
        
    }
    
    return result;
}

// 展开的section保存到expandedSectionsSet里面
- (void)setSection:(int)section expand:(BOOL)expand{
    
    if ( expand ) {
        
        if ( ![self.m_SectionsSet containsObject:[NSNumber numberWithInteger:section]] ) {
            // 首先是只显示一个点击展开的列表-即删除数据
            //            [self.m_SectionsSet removeAllObjects];
            //
            //            [self.m_SectionsSet addObject:[NSNumber numberWithInteger:section]];
            
            // 如果展开全部的数据则写下面这行代码
            [self.m_SectionsSet addObject:[NSNumber numberWithInteger:section]];
            
            
        }
        
    }else{
        // 如果展开全部的数据则写下面这行代码
        [self.m_SectionsSet removeObject:[NSNumber numberWithInteger:section]];
        
        // 首先是只显示一个点击展开的列表-即删除数据
        //        [self.m_SectionsSet removeAllObjects];
        
    }
    
}

- (void)headerClicked:(id)sender{
    
    // button的tag值
    UIButton *btn = (UIButton *)sender;
    
    //    sectionIndex = btn.tag;
    
    // bool值判断哪个section是展开还是合起来的
    BOOL expand = [self isSection:btn.tag];
    
    [self setSection:btn.tag expand:!expand];
    
    // 刷新tableView 展开全部的列表的话则就刷新某一行
    //    [self.m_tableView reloadSections:[NSIndexSet indexSetWithIndex:btn.tag] withRowAnimation:UITableViewRowAnimationNone];
    
    [self.m_tableView reloadData];
    
    
}




#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 109324 ){
        
        if ( buttonIndex == 1 ) {
            
            // 取消订单
            [self cancelOrderRequest];
        }
        
    }
    
}

//排序赋值
- (void) B_PaixuDataTotableview
{
    
    [self.m_righttableView initTableViewDataSourceAndDelegate:^(UITableView *tableView,NSInteger section)
     {
         NSInteger count = self.B_RightArray.count;
         return count;
         
     } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         RightCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RightCell"];
         
         if (!cell)
         {
             cell = [[[NSBundle mainBundle]loadNibNamed:@"RightCell" owner:self options:nil]objectAtIndex:0];
             [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
         }
         
         if ( self.B_RightArray ) {
             
             [cell.MctName setText:[NSString stringWithFormat:@"%@",[self.B_RightArray objectAtIndex:indexPath.row]]];
             
         }
         
         return cell;
         
     } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         RightCell *cell = (RightCell*)[tableView cellForRowAtIndexPath:indexPath];
         
//         [self.B_m_paixuBtn setTitle:cell.MctName.text forState:UIControlStateNormal];
         
         
         // 根据状态来判断显示按钮
         if ( [self.m_status isEqualToString:@"1"] ) {
             // 已支付的情况下
         
             if ( indexPath.row == 0 ) {
                 // 更换座位
                 [self ChangeSeat];
                 
             }
         
         
         }else{
        
             // 未支付的情况
             if ( indexPath.row == 0 ) {
                 // 更换座位
                 [self ChangeSeat];
                 
             }else{
                 
                 // 取消订单
                 UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil
                                                                    message:@"确定取消订单？"
                                                                   delegate:self
                                                          cancelButtonTitle:@"取消"
                                                          otherButtonTitles:@"确定", nil];
                 alertView.tag = 109324;
                 [alertView show];

                 
             }
         
         }
         
         
         
         
         
         [self alphaviewtap:nil];
     }];
    
    
}

- (void)B_RightOpenBtn {
    
    if (B_rightOpened) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect frame = self.m_righttableView.frame;
            
            frame.size.height = 0;
            [self.m_righttableView setFrame:frame];
            self.B_m_alphaView.alpha = 0;
            
        } completion:^(BOOL finished){
            
            B_rightOpened=NO;
        }];
    }else{
        
        self.m_righttableView.hidden = NO;
        
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect frame = self.m_righttableView.frame;
            
            int fr = self.B_RightArray.count*44;
            if (fr>300) {
                frame.size.height=300;
            }else
            {
                frame.size.height = fr;
            }
            
            [self.m_righttableView setFrame:frame];
            
            self.B_m_alphaView.alpha = 0.3;
            
            
        } completion:^(BOOL finished){
            
            B_rightOpened = YES;
            
        }];
        
    }
    
}

- (IBAction)alphaviewtap:(id)sender
{

    B_rightOpened = YES;

    [self B_RightOpenBtn];
}

// 更换座位
- (void)ChangeSeat{
    
    // 座位列表请求数据及显示view
    [self seatRequestSubmit];
    
}

// 座位列表请求数据
- (void)seatRequestSubmit{
    
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
    
    //    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [requstClient request:@"SeatList.ashx" parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            // 赋值
            self.m_seatList = [handlJson valueForKey:@"SeatList"];
            
            // 初始化座位
            [self initDemoData];
            
        }else
        {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
        }
    } failured:^(NSError* error)
     {
         
         [SVProgressHUD showErrorWithStatus:error.description];
     }];
    
    
}

- (void)initDemoData{
    
    menta = [[NSMutableArray alloc]initWithCapacity:0];

    if ( self.m_seatList.count != 0 ) {
        
        for (int i = 0; i < self.m_seatList.count; i++) {
            
            NSDictionary *dic = [self.m_seatList objectAtIndex:i];
            
            DownSheetModel *Model = [[DownSheetModel alloc]init];
            
            Model.title = [NSString stringWithFormat:@"%@",[dic objectForKey:@"SeatName"]];
            
            [menta addObject:Model];
            
        }
        
        
    }else{
        
        DownSheetModel *Model_1 = [[DownSheetModel alloc]init];
        Model_1.title = @"暂无座位";
        
        menta = @[Model_1];
        
    }
    
    // 选择座位 显示数据
    DownSheet *sheet = [[DownSheet alloc]initWithlist:menta height:0];
    sheet.delegate = self;
    [sheet showInView:nil];
    
}

- (void)didSelectIndex:(NSInteger)index{
    
    if ( self.m_seatList.count != 0 ) {
        
        NSDictionary *dic = [self.m_seatList objectAtIndex:index];
        
//        self.m_seatName.text = [NSString stringWithFormat:@"选择的座位：%@",[dic objectForKey:@"SeatName"]];
//        
        self.m_seatName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"SeatName"]];

//        self.m_seatId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"SeatId"]];

//        // 选择了之后设置tableView的footerView
//        self.m_footerView.frame = CGRectMake(self.m_footerView.frame.origin.x, self.m_footerView.frame.origin.y, self.m_footerView.frame.size.width, 80);
//        
//        self.m_tableView.tableFooterView = self.m_footerView;
//        
//        // 选择了座位后出现提交按钮
//        self.m_submitBtn.hidden = NO;
//        // 选择了座位后取消按钮隐藏，显示提交的按钮
//        self.m_cancelBtn.hidden = YES;
        
        // 选择了座位后请求数据
        [self chooseSeatRequest:[NSString stringWithFormat:@"%@",[dic objectForKey:@"SeatId"]]];
        
        
    }else{
        
        [SVProgressHUD showErrorWithStatus:@"暂无空座位"];
        
        // 没有座位后设置数据为空
//        self.m_seatName.text = @"";
//        self.m_seatId = @"";
//        self.m_seatNameString = @"";
//        // 选择了之后设置tableView的footerView
//        self.m_tableView.tableFooterView = nil;
//        
//        // 没有座位后隐藏提交按钮
//        self.m_submitBtn.hidden = YES;
//        // 没有座位后取消按钮显示，隐藏提交的按钮
//        self.m_cancelBtn.hidden = NO;
        
        
    }
    
}

- (void) chooseSeatRequest:(NSString *)seatId{
    
    NSLog(@"self.m_seatId = %@",seatId);
    
    // 提交按钮触发的事件
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
                                key,@"key",
                                [NSString stringWithFormat:@"%@",self.m_orderId],@"cloudMenuOrderId",
                                [NSString stringWithFormat:@"%@",seatId],@"seatId",nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [requstClient request:@"CloudMenuChooseSeat.ashx" parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            
            //            [SVProgressHUD dismiss];
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
           
            NSLog(@"%@",handlJson);
            
            [CommonUtil addValue:@"1" andKey:@"MenuOrderListKey"];
            
            
            // 刷新tableView
            NSArray *arr = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:2], nil];
            
            [self.m_tableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];

            
            // 设置成功座位后返回上一级
//            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(backLastView) userInfo:nil repeats:NO];
            
        }else
        {
            [CommonUtil addValue:@"0" andKey:@"MenuOrderListKey"];
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
        }
    } failured:^(NSError* error)
     {
         [CommonUtil addValue:@"0" andKey:@"MenuOrderListKey"];
         
         [SVProgressHUD showErrorWithStatus:error.description];
     }];
    
}



@end
