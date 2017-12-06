//
//  CashierlistViewController.m
//  CashierDeskIphone
//
//  Created by 冯海强 on 15-4-16.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "CashierlistViewController.h"
#import "CashierlistTableViewCell.h"
#import "CashiertimelistViewController.h"

@interface CashierlistViewController ()

@property (nonatomic,strong) NSMutableArray *Cashierarray;

@property (nonatomic, weak) UISegmentedControl *segmview;

@end

@implementation CashierlistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.Cashierarray = [[NSMutableArray alloc]init];
    //    self.m_Cashiertableview.hidden = YES;
    self.m_Cashiereview.hidden = YES;
    [self.m_Cashiertableview setDelegate:self];
    [self.m_Cashiertableview setDataSource:self];
    [self.m_Cashiertableview setPullDelegate:self];
    self.m_Cashiertableview.pullBackgroundColor = [UIColor whiteColor];
    self.m_Cashiertableview.useRefreshView = YES;
    self.m_Cashiertableview.useLoadingMoreView = YES;
    m_pageIndex = 1;
    
    // 版本判断
    if ( isIOS7 ) {
        
        [self.m_titleVIew setFrame:CGRectMake(0, 20, 320, 48)];
        
        if ( iPhone5 ) {
            
            [self.m_tempView setFrame:CGRectMake(0, 68, 320, [[UIScreen mainScreen]bounds].size.height - 20 - 48)];
            
        }else{
            
            [self.m_tempView setFrame:CGRectMake(0, 68, 320, [[UIScreen mainScreen]bounds].size.height)];
            
        }
        
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
        label.backgroundColor = [UIColor blackColor];
        
        [self.view addSubview:label];
        
    }else{
        
        [self.m_titleVIew setFrame:CGRectMake(0, 0, 320, 48)];
        
        [self.m_tempView setFrame:CGRectMake(0, 48, 320, self.view.frame.size.height - 48)];
        
    }

    [self requestPaySubmit];
    
//    [morebtn addTarget:self action:@selector(Cashiertimelist) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backLastView:(id)sender {
    
    [self goBack];
}

#pragma UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.Cashierarray.count;

    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70;
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    CashierlistTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray*cellarray=[[NSBundle mainBundle]
                           loadNibNamed:@"CashierlistTableViewCell" owner:self options:nil];
        cell =[cellarray objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    NSDictionary *dic = [self.Cashierarray objectAtIndex:indexPath.row];
    
    cell.moneylabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Amount"]];
    cell.namelabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"RealName"]];
    cell.timelabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"TransActionDate"]];


    return cell;
}





- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//取消选中状态。。
    
}

#pragma mark - PullTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {
    
    m_pageIndex = 1;
    
    [self performSelector:@selector(requestPaySubmit) withObject:nil];
    
    
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {
    
    m_pageIndex++;
    [self performSelector:@selector(requestPaySubmit) withObject:nil];
    
}

-(void)Cashiertimelist
{
    CashiertimelistViewController *VC = [[CashiertimelistViewController alloc]initWithNibName:@"CashiertimelistViewController" bundle:nil];
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)requestPaySubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    // 刷新请求数据接口 CRConfirmation 确认中,CRHasBeenPaid 已支付,CRRecognized 已确认
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId, @"cashierAccountID",
                                key,@"key",
                                [NSString stringWithFormat:@"%li",(long)m_pageIndex],@"pageIndex",
                                @"2",@"type",
                                @"20",@"pageSize",nil];
    if (self.Cashierarray.count ==0) {
        [SVProgressHUD showWithStatus:@"数据加载中..."];
    }
    
    [requstClient request:VIPCardCashierRecords parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            NSMutableArray *metchantShop = [handlJson valueForKey:@"recordList"];
            
            if (m_pageIndex == 1) {
                if (metchantShop == nil || metchantShop.count == 0) {
                    [self.Cashierarray removeAllObjects];
                    self.m_Cashiertableview.hidden = YES;
                    self.m_Cashiereview.hidden = NO;
                    return;
                    
                } else {
                    
                    self.Cashierarray = metchantShop;
                    self.m_Cashiereview.hidden = YES;
                    self.m_Cashiertableview.hidden = NO;
                    
                }
            } else {
                
                self.m_Cashiertableview.hidden = NO;
                
                if (metchantShop == nil || metchantShop.count == 0) {
                    m_pageIndex--;
                } else {
                    NSMutableArray *array = [[NSMutableArray alloc]initWithCapacity:0];
                    [array addObjectsFromArray:self.Cashierarray];
                    [array addObjectsFromArray:metchantShop];
                    self.Cashierarray = array;
                }
            }
            [self.m_Cashiertableview reloadData];
            
        } else {
            if (m_pageIndex > 1) {
                m_pageIndex--;
            }
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        self.m_Cashiertableview.pullLastRefreshDate = [NSDate date];
        self.m_Cashiertableview.pullTableIsRefreshing = NO;
        self.m_Cashiertableview.pullTableIsLoadingMore = NO;
        
        
        
    } failured:^(NSError* error)
     {
         [SVProgressHUD showErrorWithStatus:error.description];
         self.m_Cashiertableview.pullTableIsRefreshing = NO;
         self.m_Cashiertableview.pullTableIsLoadingMore = NO;
         
     }];
    
}

@end
