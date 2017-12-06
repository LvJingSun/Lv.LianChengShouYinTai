//
//  RecordsViewController.m
//  CashierDeskIphone
//
//  Created by mac on 13-9-8.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "RecordsViewController.h"

#import "CashierRecordsCell.h"

#import "ConsumerData.h"

@interface RecordsViewController ()

@end

@implementation RecordsViewController

@synthesize m_leftBtn;

@synthesize m_rightBtn;

@synthesize m_tableView;

@synthesize m_stringType;

@synthesize m_pageSize;

@synthesize m_keyArray;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.m_pageSize = 1;
        
        m_keyArray = [[NSMutableArray alloc]initWithCapacity:0];
        
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
        
        [self.m_titleView setFrame:CGRectMake(0, 20, 320, 48)];
        
        if ( iPhone5 ) {
            
            [self.m_tableView setFrame:CGRectMake(0, 68, 320, [[UIScreen mainScreen]bounds].size.height - 20 - 48)];

        }else{
            
            [self.m_tableView setFrame:CGRectMake(0, 68, 320, [[UIScreen mainScreen]bounds].size.height + 20)];

        }
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
        label.backgroundColor = [UIColor blackColor];
        
        [self.view addSubview:label];
        
    }else{
        
        [self.m_titleView setFrame:CGRectMake(0, 0, 320, 48)];
        
        [self.m_tableView setFrame:CGRectMake(0, 48, 320, self.view.frame.size.height - 48)];
    }
    
    [self.m_tableView setPullDelegate:self];
    
    [self.m_tableView setPullBackgroundColor:[UIColor whiteColor]];
    
    self.m_tableView.useRefreshView = YES;
    
    self.m_tableView.useLoadingMoreView= YES;
    
    self.m_emptyLabel.hidden = YES;
    
    self.m_tableView.hidden = YES;

    
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    // 设置默认选中第一个
    [self setLeftBtn:YES rightBtn:NO];
        
    self.m_stringType = @"0";
    
//    self.m_emptyLabel.hidden = YES;
//
//    self.m_tableView.hidden = YES;
    
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


- (void)setLeftBtn:(BOOL)aLeft rightBtn:(BOOL)aRight{
    
    m_leftBtn.selected = aLeft;
    
    m_rightBtn.selected = aRight;
    
    self.m_pageSize = 1;
    
    if ( aLeft ) {
        
        m_leftBtn.userInteractionEnabled = NO;
        
        m_rightBtn.userInteractionEnabled = YES;
        
        // key值收银记录请求数据
        [self requestKeySubmit];
        
    }else{
        
        m_leftBtn.userInteractionEnabled = YES;
        
        m_rightBtn.userInteractionEnabled = NO;
        
        // 消费收银请求记录
        [self requestConsumerSubmit];
    }
    
}

- (IBAction)btnClicked:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    
    if ( btn.tag == 10 ) {
        
        self.m_stringType = @"0";

        [self setLeftBtn:YES rightBtn:NO];
        
    }else{
        
        self.m_stringType = @"1";

        [self setLeftBtn:NO rightBtn:YES];
    }
    
    [m_tableView reloadData];

}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.m_keyArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIdentifier = @"CashierRecordsCellIdentifier";
    
    CashierRecordsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CashierRecordsCell" owner:self options:nil];
        
        cell = (CashierRecordsCell *)[nib objectAtIndex:0];
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    // 判断是key值收银还是消费收银-消费收银key值不显示
    if ( [self.m_stringType isEqualToString:@"0"] ) {
        
        cell.m_keyLabel.hidden = NO;
        
    }else{
        
        cell.m_keyLabel.hidden = YES;
    }
    
    if ( self.m_keyArray.count != 0 ) {
        
        // 赋值
        ConsumerDetailData *data = (ConsumerDetailData *)[self.m_keyArray objectAtIndex:indexPath.row];
        cell.m_timeLabel.text = [NSString stringWithFormat:@"收银时间：%@",data.CreateDate];
        cell.m_priceLabel.text = [NSString stringWithFormat:@"%.2f",[data.Amount floatValue]];
        cell.m_phoneLabel.text = [NSString stringWithFormat:@"%@ ( %@ )",data.Phone,data.RealName];
     
        cell.m_keyLabel.text = [NSString stringWithFormat:@"KEY值：%@",data.KeyCode];
        
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70.0f;
}


- (void)requestKeySubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    if ( self.m_pageSize == 1 ) {
        
        [self.m_keyArray removeAllObjects];
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    // 刷新请求数据接口 ======== status 状态的值 ========
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId, @"cashierAccountId",
                                key,@"key",
                                [NSString stringWithFormat:@"%i",self.m_pageSize],@"pageIndex",nil];
    
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [requstClient request:CDHTTPRequestKeyConsumer parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        ConsumerData *Data = [[ConsumerData alloc]initWithJsonObject:handlJson];
                
        BOOL success = [Data.status boolValue];
        
        if (success) {
            
            [self.m_keyArray addObjectsFromArray:Data.confirmCashRecognized];
            
            if ( self.m_keyArray.count != 0 ) {
                
                self.m_emptyLabel.hidden = YES;
                
                self.m_tableView.hidden = NO;
                
            }else{
                
                self.m_emptyLabel.hidden = NO;
                
                self.m_emptyLabel.text = @"暂无KEY值收银的记录!";
                
                self.m_tableView.hidden = YES;
            }
            
            
            [SVProgressHUD dismiss];
            
            [self.m_tableView reloadData];
                        
        }else
        {
            
            [SVProgressHUD showErrorWithStatus:Data.msg];
            
            
        }
        
        self.m_tableView.pullLastRefreshDate = [NSDate date];
        
        self.m_tableView.pullTableIsRefreshing = NO;
        
        self.m_tableView.pullTableIsLoadingMore = NO;

        
        
    } failured:^(NSError* error)
     {
         [SVProgressHUD showErrorWithStatus:error.description];
         
         self.m_tableView.pullTableIsRefreshing = NO;
         
         self.m_tableView.pullTableIsLoadingMore = NO;


     }];

}

- (void)requestConsumerSubmit{
    
    if ( self.m_pageSize == 1 ) {
        
        [self.m_keyArray removeAllObjects];
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
        
    // 刷新请求数据接口 已确认 CRConfirmation 确认中,CRHasBeenPaid 已支付,CRRecognized 已确认
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId, @"cashierAccountId",
                                key,@"key",
                                [NSString stringWithFormat:@"%i",self.m_pageSize],@"pageIndex",
                                @"CRRecognized",@"status",nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [requstClient request:CDHTTPRequestConsumer parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        ConsumerData *Data = [[ConsumerData alloc]initWithJsonObject:handlJson];
                
        BOOL success = [Data.status boolValue];
        
        if (success) {
            
            [self.m_keyArray addObjectsFromArray:Data.confirmCashRecognized];
            
            if ( self.m_keyArray.count != 0 ) {
                
                self.m_emptyLabel.hidden = YES;
                
                self.m_tableView.hidden = NO;
                
            }else{
                
                self.m_emptyLabel.hidden = NO;
                
                self.m_emptyLabel.text = @"暂无消费收银的记录!";
                
                self.m_tableView.hidden = YES;
            }
            
            [SVProgressHUD dismiss];
            
            [self.m_tableView reloadData];
            
                       
        }else
        {
            
            [SVProgressHUD showErrorWithStatus:Data.msg];
           
        }
        
        self.m_tableView.pullLastRefreshDate = [NSDate date];
        
        self.m_tableView.pullTableIsRefreshing = NO;

        self.m_tableView.pullTableIsLoadingMore = NO;
        
        
    } failured:^(NSError* error)
     {
         
         [SVProgressHUD showErrorWithStatus:error.description];
         
         self.m_tableView.pullTableIsRefreshing = NO;

         self.m_tableView.pullTableIsLoadingMore = NO;

     }];

}

#pragma mark - PullTableViewDelegate

- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {
    
    self.m_pageSize = 1;
    
    if (  [self.m_stringType isEqualToString:@"0"] ) {
        
        [self performSelector:@selector(requestKeySubmit) withObject:nil];

    }else {
        
        [self performSelector:@selector(requestConsumerSubmit) withObject:nil];

    }

}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {
    
    self.m_pageSize ++;
    
    if (  [self.m_stringType isEqualToString:@"0"] ) {
        
        [self performSelector:@selector(requestKeySubmit) withObject:nil];
        
    }else {
        
        [self performSelector:@selector(requestConsumerSubmit) withObject:nil];
        
    }
    
}

@end
