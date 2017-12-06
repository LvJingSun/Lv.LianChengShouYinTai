//
//  WaimaiOrderDetailViewController.m
//  CashierDeskIphone
//
//  Created by mac on 15-9-12.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "WaimaiOrderDetailViewController.h"
#import "WaimaiOrderDetailTableViewCell.h"

@interface WaimaiOrderDetailViewController ()

@end

@implementation WaimaiOrderDetailViewController
@synthesize m_orderdetailDIC;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        self.m_orderdetailDIC = [[NSMutableDictionary alloc]initWithCapacity:0];
        self.m_SectionsSet = [[NSMutableSet alloc]init];
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
            
            [self.m_detailTableView setFrame:CGRectMake(0, 68, 320, [[UIScreen mainScreen]bounds].size.height - 20 - 48)];
        }else{
            
            [self.m_detailTableView setFrame:CGRectMake(0, 68, 320, [[UIScreen mainScreen]bounds].size.height)];
        }
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
        label.backgroundColor = [UIColor blackColor];
        
        [self.view addSubview:label];
        
    }else{
        
        [self.m_titleView setFrame:CGRectMake(0, 0, 320, 48)];
        
        [self.m_detailTableView setFrame:CGRectMake(0, 48, 320, self.view.frame.size.height - 48)];
    }
    
    
}

- (IBAction)backLastView:(id)sender {
    
    [self goBack];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    NSInteger m_status=[[NSString stringWithFormat:@"%@",[self.m_orderdetailDIC objectForKey:@"Status"]] integerValue];
    switch (m_status) {
        case 0:
            return 3;
            break;
        case 1:
            return 3;
            break;
        case 2:
            return 2;
            break;
        case 3:
            return 2;
            break;
        default:
            break;
    }
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    BOOL expand = [self isSection:section];
    
    if ( !expand ) {
        
        if ( section == 0 ) {
            
            return [[self.m_orderdetailDIC objectForKey:@"OrderDetailList"] count];
            
        }else{
            
            return 1;
        }
        
    }else {
        
        return 0;
        
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( indexPath.section == 0 ) {
        
        static NSString *cellIdentifier = @"WaimaiOrderDetailTableViewCell";
        
        WaimaiOrderDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if ( cell == nil ) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"WaimaiOrderDetailTableViewCell" owner:self options:nil];
            
            cell = (WaimaiOrderDetailTableViewCell *)[nib objectAtIndex:0];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        // 赋值
        if ( [[self.m_orderdetailDIC objectForKey:@"OrderDetailList"] count] ) {
            
            NSDictionary *dic = [[self.m_orderdetailDIC objectForKey:@"OrderDetailList"] objectAtIndex:indexPath.row];
            
            cell.m_name.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MenuName"]];
            
            cell.m_num.text = [NSString stringWithFormat:@"%@份",[dic objectForKey:@"MenuAmount"]];
            
            cell.m_price.text = [NSString stringWithFormat:@"%@元",[dic objectForKey:@"MenuPrice"]];
            self.AVLIST = @"";
            NSArray *avlist = [dic objectForKey:@"AVList"];
            if (avlist.count>1) {
                [avlist enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    self.AVLIST = [NSString stringWithFormat:@"%@;%@",self.AVLIST,[NSString stringWithFormat:@"%@",[obj objectForKey:@"AV"]]];
                }];
            }else
            {
                self.AVLIST = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",[[avlist objectAtIndex:0] objectForKey:@"AV"]]];
            }
            cell.m_yaoqiu.text = self.AVLIST;
            self.AVLIST = @"";
            
        }
        
        return cell;
        
    }else if ( indexPath.section == 1 ){
        
        static NSString *cellIdentifier = @"WaimaiOrderDetailTableViewCell1";
        
        WaimaiOrderDetailTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if ( cell == nil ) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"WaimaiOrderDetailTableViewCell" owner:self options:nil];
            
            cell = (WaimaiOrderDetailTableViewCell1 *)[nib objectAtIndex:1];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        cell.m_name.text=[NSString stringWithFormat:@"%@",[self.m_orderdetailDIC objectForKey:@"LinkName"]];
        cell.m_phone.text=[NSString stringWithFormat:@"%@",[self.m_orderdetailDIC objectForKey:@"LinkPhone"]];
        cell.m_time.text=[NSString stringWithFormat:@"%@",[self.m_orderdetailDIC objectForKey:@"PeiSongTime"]];
        cell.m_address.text=[NSString stringWithFormat:@"%@",[self.m_orderdetailDIC objectForKey:@"Address"]];
        NSInteger m_status=[[NSString stringWithFormat:@"%@",[self.m_orderdetailDIC objectForKey:@"Status"]] integerValue];
        switch (m_status) {
            case 0:
                cell.m_status.text = @"待配送";
                [cell.m_status setTextColor:RGBA(62, 169, 24, 1)];
                break;
            case 1:
                cell.m_status.text = @"配送中";
                [cell.m_status setTextColor:RGBA(86, 167, 241, 1)];
                
                break;
            case 2:
                cell.m_status.text = @"已配送";
                [cell.m_status setTextColor:RGBA(86, 167, 241, 1)];
                
                break;
            case 3:
                cell.m_status.text = @"已退回";
                [cell.m_status setTextColor:RGBA(250, 38, 74, 1)];
                
                break;
            default:
                break;
        }

        [cell.m_phoneBtn addTarget:self action:@selector(callBtn) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
        
    }else{
        
        static NSString *cellIdentifier = @"WaimaiOrderDetailTableViewCell2";
        
        WaimaiOrderDetailTableViewCell2 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if ( cell == nil ) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"WaimaiOrderDetailTableViewCell" owner:self options:nil];
            
            cell = (WaimaiOrderDetailTableViewCell2 *)[nib objectAtIndex:2];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        cell.m_willpeisong.tag = 101;
        cell.m_backpeisong.tag = 102;
        cell.m_overpeisong.tag = 103;

        [cell.m_willpeisong addTarget:self action:@selector(doSomeActions:) forControlEvents:UIControlEventTouchUpInside];
        [cell.m_backpeisong addTarget:self action:@selector(doSomeActions:) forControlEvents:UIControlEventTouchUpInside];
        [cell.m_overpeisong addTarget:self action:@selector(doSomeActions:) forControlEvents:UIControlEventTouchUpInside];
        
        // 赋值
        NSInteger m_status=[[NSString stringWithFormat:@"%@",[self.m_orderdetailDIC objectForKey:@"Status"]] integerValue];
        switch (m_status) {
            case 0:
                cell.m_willpeisong.hidden = NO;
                cell.m_backpeisong.hidden = NO;
                cell.m_overpeisong.hidden = YES;
                break;
            case 1:
                cell.m_willpeisong.hidden = YES;
                cell.m_backpeisong.hidden = YES;
                cell.m_overpeisong.hidden = NO;
                break;
            case 2:
                cell.m_willpeisong.hidden = YES;
                cell.m_backpeisong.hidden = YES;
                cell.m_overpeisong.hidden = YES;
                break;
            case 3:
                cell.m_willpeisong.hidden = YES;
                cell.m_backpeisong.hidden = YES;
                cell.m_overpeisong.hidden = YES;
                break;
            default:
                break;
        }
        
        
        return cell;
    }
    
}

- (void)callBtn{
    
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
        
        NSString *phone = [NSString stringWithFormat:@"%@",[self.m_orderdetailDIC objectForKey:@"LinkPhone"]];
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
            
            UILabel *PriceAmount = [[UILabel alloc]initWithFrame:CGRectMake(WindowSizeWidth-120, 5, 80, 34)];
            PriceAmount.font = [UIFont systemFontOfSize:16.0f];
            PriceAmount.backgroundColor = [UIColor clearColor];
            PriceAmount.textColor = [UIColor redColor];
            PriceAmount.textAlignment = NSTextAlignmentRight;
            PriceAmount.text = [NSString stringWithFormat:@"￥%@",[self.m_orderdetailDIC objectForKey:@"PriceAmount"]];
            [tempView addSubview:PriceAmount];

            
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
        return 65.0f;
        
    }else if ( indexPath.section == 1 ){
        
        return 140.0f;
        
    }else{
        
        return 65.0f;
    }
    
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
    
    [self setSection:(int)btn.tag expand:!expand];
    
    // 刷新tableView 展开全部的列表的话则就刷新某一行
    //    [self.m_tableView reloadSections:[NSIndexSet indexSetWithIndex:btn.tag] withRowAnimation:UITableViewRowAnimationNone];
    
    [self.m_detailTableView reloadData];
    
    
}

-(void)doSomeActions:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    NSString *title;
    NSString *suretitle;
    
    if (btn.tag ==101) {
        title=@"确定开始配送？";
        suretitle=@"开始";
        UIAlertView *aler= [[UIAlertView alloc]initWithTitle:title message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:suretitle, nil];
        aler.tag = 101;
        [aler show];
    }else if (btn.tag ==102) {
        title=@"输入退回订单的原因";
        suretitle=@"确定";
        UIAlertView *aler= [[UIAlertView alloc]initWithTitle:title message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:suretitle, nil];
        aler.alertViewStyle = UIAlertViewStylePlainTextInput;
        aler.tag = 102;
        [aler show];
    }else if (btn.tag ==103) {
        title=@"确定外卖配送结束？";
        suretitle=@"确定";
        UIAlertView *aler= [[UIAlertView alloc]initWithTitle:title message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:suretitle, nil];
        aler.tag = 103;
        [aler show];
    }

    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    NSString *messageTextFieldString;
    if ([alertView cancelButtonIndex] != buttonIndex) {
        if (alertView.tag==102) {
            UITextField *messageTextField = [alertView textFieldAtIndex:0];
            messageTextFieldString = messageTextField.text;
        }
        switch (alertView.tag) {
            case 101:
                [self willpeisongAction];
                break;
            case 102:
                if (!messageTextFieldString.length) {
                    [SVProgressHUD showErrorWithStatus:@"请输入退回原因"];
                    return;
                }
                [self backpeisongAction: messageTextFieldString];
                break;
            case 103:
                [self overpeisongAction];
                break;
                
            default:
                break;
        }
    }
}



- (void)willpeisongAction
{
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    NSString *AllotWaiMaiOrderRecordID = [NSString stringWithFormat:@"%@",[self.m_orderdetailDIC objectForKey:@"AllotWaiMaiOrderRecordID"]];
    // 刷新请求数据接口
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId, @"cashierAccountID",
                                key,@"key",
                                AllotWaiMaiOrderRecordID,@"AllotWaiMaiOrderRecordID",
                                nil];
    
    [SVProgressHUD showWithStatus:@"数据提交中"];
    
    [requstClient request:@"ConfirmWaiMaiOrder.ashx" parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        NSDictionary* handlJson = [json objectWithData:data];
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
            // 设置成功座位后返回上一级
            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(peisongActionsBack) userInfo:nil repeats:NO];
            
            
        }else
        {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
        }
    } failured:^(NSError* error)
     {
         [SVProgressHUD showErrorWithStatus:error.description];
     }];
}


- (void)backpeisongAction:(NSString *)Description
{
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    NSString *AllotWaiMaiOrderRecordID = [NSString stringWithFormat:@"%@",[self.m_orderdetailDIC objectForKey:@"AllotWaiMaiOrderRecordID"]];
    // 刷新请求数据接口
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId, @"cashierAccountID",
                                key,@"key",
                                AllotWaiMaiOrderRecordID,@"AllotWaiMaiOrderRecordID",
                                Description,@"Description",
                                nil];
    
    [SVProgressHUD showWithStatus:@"数据提交中"];
    
    [requstClient request:@"SendBackWaiMaiOrder.ashx" parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        NSDictionary* handlJson = [json objectWithData:data];
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
            // 设置成功座位后返回上一级
            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(peisongActionsBack) userInfo:nil repeats:NO];
            
            
        }else
        {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
        }
    } failured:^(NSError* error)
     {
         [SVProgressHUD showErrorWithStatus:error.description];
     }];
    
}


- (void)overpeisongAction
{
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    NSString *AllotWaiMaiOrderRecordID = [NSString stringWithFormat:@"%@",[self.m_orderdetailDIC objectForKey:@"AllotWaiMaiOrderRecordID"]];
    // 刷新请求数据接口
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId, @"cashierAccountID",
                                key,@"key",
                                AllotWaiMaiOrderRecordID,@"AllotWaiMaiOrderRecordID",
                                nil];
    
    [SVProgressHUD showWithStatus:@"数据提交中"];
    
    [requstClient request:@"FinishedWaiMaiOrder.ashx" parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        NSDictionary* handlJson = [json objectWithData:data];
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
            // 设置成功座位后返回上一级
            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(peisongActionsBack) userInfo:nil repeats:NO];
            
            
        }else
        {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
        }
    } failured:^(NSError* error)
     {
         [SVProgressHUD showErrorWithStatus:error.description];
     }];
    
}

- (void)peisongActionsBack
{
    if ( delegate && [delegate respondsToSelector:@selector(PeisongAction)] ) {
        
        [delegate performSelector:@selector(PeisongAction)];
    }
   [self goBack];
}


@end
