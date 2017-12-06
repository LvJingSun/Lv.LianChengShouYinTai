//
//  N_ShouYinListViewController.m
//  CashierDeskIphone
//
//  Created by mac on 2017/10/18.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "N_ShouYinListViewController.h"
#import "N_ShouYinModel.h"
#import "N_ShouYinFrame.h"
#import "N_ShouYinCell.h"
#import "FSB_Header.h"
#import "MJRefresh.h"

@interface N_ShouYinListViewController () <UITableViewDelegate,UITableViewDataSource> {
    
    NSString *recordType;
    
    NSInteger pageIndex;
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, weak) UISegmentedControl *segmview;

@end

@implementation N_ShouYinListViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.title = @"收银记录";
    
    [self allocWithTableview];
    
    recordType = @"0";
    
    pageIndex = 1;
    
    [self requestForData];
    
}

- (void)requestForData {
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    HttpClientRequest *http = [HttpClientRequest sharedInstance];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         recordType,@"Type",
                         memberId,@"CashierAccountID",
                         [NSString stringWithFormat:@"%ld",(long)pageIndex],@"pageIndex",
                         nil];
    
    NSLog(@"%@",dic);
    
    [http request:@"CashierRecordAll.ashx" parameters:dic successed:^(JSONDecoder *jsonDecoder, id responseObject) {
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [jsonDecoder objectWithData:data];
        
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            
            NSArray *arr = handlJson[@"ListTopUp"];
            
            if (pageIndex == 1) {
                
                NSMutableArray *mut = [NSMutableArray array];
                
                for (NSDictionary *dd in arr) {
                    
                    N_ShouYinModel *model = [[N_ShouYinModel alloc] initWithDict:dd];
                    
                    N_ShouYinFrame *frame = [[N_ShouYinFrame alloc] init];
                    
                    frame.recordModel = model;
                    
                    [mut addObject:frame];
                    
                }
                
                self.dataArray = mut;
                
            }else {
                
                NSMutableArray *temp = [NSMutableArray arrayWithArray:self.dataArray];
                
                for (NSDictionary *dd in arr) {
                    
                    N_ShouYinModel *model = [[N_ShouYinModel alloc] initWithDict:dd];
                    
                    N_ShouYinFrame *frame = [[N_ShouYinFrame alloc] init];
                    
                    frame.recordModel = model;
                    
                    [temp addObject:frame];
                    
                }
                
                self.dataArray = temp;
                
            }
            
            [self.tableview reloadData];
            
            [self endRefreshing];
            
        }else {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
            if (pageIndex > 1) {
                
                pageIndex --;
                
            }
            
            [self endRefreshing];
            
        }
        
    } failured:^(NSError *error) {
        
        if (pageIndex > 1) {
            
            pageIndex --;
            
        }
        
        [SVProgressHUD showErrorWithStatus:error.description];
        
        [self endRefreshing];
        
    }];
    
}

- (void)allocWithTableview {
    
    UISegmentedControl *segmview = [[UISegmentedControl alloc] initWithItems:@[@"积分记录",@"红包记录",@"会员卡记录"]];
    
    segmview.frame = CGRectMake(SCREENWIDTH * 0.15, 10, SCREENWIDTH * 0.7, 35);
    
    segmview.layer.masksToBounds = YES;
    
    segmview.layer.cornerRadius = 17.5;
    
    segmview.layer.borderColor = NAVTextColor.CGColor;
    
    segmview.layer.borderWidth = 1;
    
    self.segmview = segmview;
    
    segmview.selectedSegmentIndex = 0;
    
    segmview.tintColor = NAVTextColor;
    
    [segmview addTarget:self action:@selector(segmchange:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:segmview];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(segmview.frame) + 10, SCREENWIDTH, SCREENHEIGHT - 64 - 10 - CGRectGetMaxY(segmview.frame))];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = BGColor;
    
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        pageIndex = 1;
        
        [self requestForData];
        
    }];
    
    tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        pageIndex ++;
        
        [self requestForData];
        
    }];
    
    [self.view addSubview:tableview];
    
}

- (void)endRefreshing {
    
    [self.tableview.mj_header endRefreshing];
    
    [self.tableview.mj_footer endRefreshing];
    
}

- (void)segmchange:(UISegmentedControl *)segm {
    
    switch (segm.selectedSegmentIndex) {
        case 0:
        {
            
            recordType = @"0";
            
            pageIndex = 1;
            
            [self requestForData];
            
        }
            break;
            
        case 1:
        {
            
            recordType = @"2";
            
            pageIndex = 1;
            
            [self requestForData];
            
        }
            break;
            
        case 2:
        {
            
            recordType = @"1";
            
            pageIndex = 1;
            
            [self requestForData];
            
        }
            break;
            
        default:
            break;
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    N_ShouYinCell *cell = [[N_ShouYinCell alloc] init];
    
    N_ShouYinFrame *frame = self.dataArray[indexPath.row];
    
    cell.frameModel = frame;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    N_ShouYinFrame *frame = self.dataArray[indexPath.row];
    
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
