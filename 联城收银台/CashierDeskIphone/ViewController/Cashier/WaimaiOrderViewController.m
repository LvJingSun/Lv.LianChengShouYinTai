//
//  WaimaiOrderViewController.m
//  CashierDeskIphone
//
//  Created by mac on 15-8-28.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "WaimaiOrderViewController.h"

#import "WaimaiOrderCell.h"
#import "WaimaiOrderDetailViewController.h"

@interface WaimaiOrderViewController ()<Peisongdelegate>
{
    NSString *tableStatus;
}

@property (weak, nonatomic) IBOutlet UIView             *m_titleView;

@property (weak, nonatomic) IBOutlet UIView             *m_tempView;
@property (weak, nonatomic) IBOutlet UITableView        *m_tableView;
@property (weak, nonatomic) IBOutlet UIView *btnView;


- (IBAction)goBack:(id)sender;


@end

@implementation WaimaiOrderViewController

@synthesize m_orderList;

@synthesize m_SectionsSet;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        m_orderList = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_SectionsSet = [[NSMutableSet alloc]init];

        tableStatus = @"0";
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 版本判断
    if ( isIOS7 ) {
        
        [self.m_titleView setFrame:CGRectMake(0, 20, 320, 48)];
        [self.btnView setFrame:CGRectMake(0, 68, 320, 48)];
        
        if ( iPhone5 ) {
            
            [self.m_tempView setFrame:CGRectMake(0, 116, 320, [[UIScreen mainScreen]bounds].size.height - 20 - 96)];
            
        }else{
            
            [self.m_tempView setFrame:CGRectMake(0, 116, 320, [[UIScreen mainScreen]bounds].size.height)];
            
        }
        
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
        label.backgroundColor = [UIColor blackColor];
        
        [self.view addSubview:label];
        
    }else{
        
        [self.m_titleView setFrame:CGRectMake(0, 0, 320, 48)];
        
         [self.btnView setFrame:CGRectMake(0, 48, 320, 48)];
        [self.m_tempView setFrame:CGRectMake(0, 96, 320, self.view.frame.size.height - 96)];
        
    }
    self.m_tableView.hidden = YES;
    // ============
    [self requestOrder:@"0"];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

//外卖订单状态（0待确认配送，1待配送,2已配送完成,3已退回）
-(void) requestOrder:(NSString *)status{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId, @"CashierAccountID",
                                key,@"Key",status,@"Status",nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    HttpClientRequest *request = [HttpClientRequest sharedInstance];
    [request request:@"MyWaiMaiOrder.ashx" parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            m_orderList = [handlJson objectForKey:@"OrderList"];
            
            NSLog(@"%@",[m_orderList JSONString]);
            
            if (m_orderList.count>0) {
                
                self.m_tableView.hidden = NO;
                self.simpleLable.hidden = YES;
                [self.m_tableView reloadData];
            }else
            {
                self.m_tableView.hidden = YES;
                self.simpleLable.hidden = NO;
            }

           
        }else
        {
            self.m_tableView.hidden = YES;
            self.simpleLable.hidden = NO;
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
        }
    } failured:^(NSError* error)
     {
         self.m_tableView.hidden = YES;
         self.simpleLable.hidden = NO;
         [SVProgressHUD showErrorWithStatus:error.description];
     }];
    


}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBack:(id)sender{
    
    [self goBack];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    return self.m_orderList.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString  *cellIdentifier = @"WaimaiOrderCellIdentifier";
    
    WaimaiOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"WaimaiOrderCell" owner:self options:nil];
        
        cell = (WaimaiOrderCell *)[nib objectAtIndex:0];
        
    }
    
    if (self.m_orderList.count>0) {
        NSDictionary *OrderDic = [self.m_orderList objectAtIndex:indexPath.row];
        [cell SetValueWaimaiOrder:OrderDic];
    }
    
    
    return cell;

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 146.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//取消选中状态。。

    
    WaimaiOrderDetailViewController *VC = [[WaimaiOrderDetailViewController alloc]initWithNibName:@"WaimaiOrderDetailViewController" bundle:nil];
    VC.m_orderdetailDIC = [self.m_orderList objectAtIndex:indexPath.row];
    VC.delegate = self;
    [self.navigationController pushViewController:VC animated:YES];
    
    
    
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


- (IBAction)btnClick:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    NSInteger index = btn.tag;
    switch (index) {
        case 10:
        {
            self.waitDeliverBtn.selected = YES;
            self.delivery.selected = NO;
            self.finishDelivery.selected = NO;
            self.sendBackBtn.selected = NO;
            tableStatus = @"0";
            break;
        }
        case 11:
        {
            
            self.waitDeliverBtn.selected = NO;
            self.delivery.selected = YES;
            self.finishDelivery.selected = NO;
            self.sendBackBtn.selected = NO;
            tableStatus = @"1";
            break;
        }
        case 12:
        {
            self.waitDeliverBtn.selected = NO;
            self.delivery.selected = NO;
            self.finishDelivery.selected = YES;
            self.sendBackBtn.selected = NO;
            tableStatus = @"2";
            break;
        }
        case 13:
        {
            self.waitDeliverBtn.selected = NO;
            self.delivery.selected = NO;
            self.finishDelivery.selected = NO;
            self.sendBackBtn.selected = YES;
            tableStatus = @"3";
            break;
        }

        default:
            break;
    }
    [self requestOrder:tableStatus];
    
}


#pragma mark - Peisongdelegate
-(void)PeisongAction;
{
    [self requestOrder:tableStatus];

}








@end
