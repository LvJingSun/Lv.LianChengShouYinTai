//
//  Member_RecordsViewController.m
//  CashierDeskIphone
//
//  Created by mac on 2017/10/11.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "Member_RecordsViewController.h"
#import "Member_RecordModel.h"
#import "Member_RecordFrame.h"
#import "Member_RecordCell.h"
#import "FSB_Header.h"
#import "MJRefresh.h"

@interface Member_RecordsViewController () <UITableViewDelegate,UITableViewDataSource> {
    
    NSString *recordType;
    
    NSInteger pageIndex;
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, weak) UISegmentedControl *segmview;

@end

@implementation Member_RecordsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.title = @"充值记录";
    
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
    
    [http request:@"TopUpRecord.ashx" parameters:dic successed:^(JSONDecoder *jsonDecoder, id responseObject) {
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [jsonDecoder objectWithData:data];
        
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            
            NSArray *arr = handlJson[@"ListTopUp"];
            
            if (pageIndex == 1) {
                
                NSMutableArray *mut = [NSMutableArray array];
                
                for (NSDictionary *dd in arr) {
                    
                    Member_RecordModel *model = [[Member_RecordModel alloc] init];
                    
                    model.name = dd[@"Title"];
                    
                    model.count = dd[@"Amount"];
                    
                    model.date = dd[@"Date"];
                    
                    model.type = dd[@"TransactionType"];
                    
                    model.ID = dd[@"ID"];
                    
                    Member_RecordFrame *frame = [[Member_RecordFrame alloc] init];
                    
                    frame.recordModel = model;
                    
                    [mut addObject:frame];
                    
                }
                
                self.dataArray = mut;
                
            }else {
                
                NSMutableArray *temp = [NSMutableArray arrayWithArray:self.dataArray];
                
                for (NSDictionary *dd in arr) {
                    
                    Member_RecordModel *model = [[Member_RecordModel alloc] init];
                    
                    model.name = dd[@"Title"];
                    
                    model.count = dd[@"Amount"];
                    
                    model.date = dd[@"Date"];
                    
                    model.type = dd[@"TransactionType"];
                    
                    model.ID = dd[@"ID"];
                    
                    Member_RecordFrame *frame = [[Member_RecordFrame alloc] init];
                    
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
    
    UISegmentedControl *segmview = [[UISegmentedControl alloc] initWithItems:@[@"积分充值",@"会员卡充值"]];
    
    segmview.frame = CGRectMake(SCREENWIDTH * 0.25, 10, SCREENWIDTH * 0.5, 35);
    
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
    
    Member_RecordCell *cell = [[Member_RecordCell alloc] init];
    
    Member_RecordFrame *frame = self.dataArray[indexPath.row];
    
    cell.frameModel = frame;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Member_RecordFrame *frame = self.dataArray[indexPath.row];
    
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
