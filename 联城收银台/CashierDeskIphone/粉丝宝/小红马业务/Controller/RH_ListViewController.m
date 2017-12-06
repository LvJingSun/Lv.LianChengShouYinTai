//
//  RH_ListViewController.m
//  CashierDeskIphone
//
//  Created by mac on 2017/8/4.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_ListViewController.h"
#import "RH_ListTranModel.h"
#import "RH_ListTranFrame.h"
#import "RH_ListTranCell.h"
#import "FSB_Header.h"
#import "RH_DetailTranViewController.h"

@interface RH_ListViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSMutableArray *array;

@end

@implementation RH_ListViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"明细";
    
    [self allocWithTableview];
    
    [self requestForData];
    
}

- (void)allocWithTableview {
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = BGColor;
    
//    YonghuNoticeView *headview = [[YonghuNoticeView alloc] init];
//    
//    headview.frame = CGRectMake(0, 0, SCREENWIDTH, headview.height);
//    
//    headview.titletext = @"⭐️【向左滑动】可撤销当天交易";
//    
//    tableview.tableHeaderView = headview;
    
    [self.view addSubview:tableview];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.array.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RH_ListTranFrame *frame = self.array[indexPath.row];
    
    RH_ListTranCell *cell = [[RH_ListTranCell alloc] init];
    
    cell.frameModel = frame;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RH_ListTranFrame *frame = self.array[indexPath.row];
    
    return frame.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    RH_ListTranFrame *frame = self.array[indexPath.row];
    
    RH_ListTranModel *model = frame.listModel;
    
    RH_DetailTranViewController *vc = [[RH_DetailTranViewController alloc] init];
    
    vc.listModel = model;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)requestForData {
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"CashierAccountID",
                                nil];
    
    [requstClient request:@"RMctTran.ashx" parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            
            NSArray *arr = handlJson[@"ybtrList"];
            
            NSMutableArray *mut = [NSMutableArray array];
            
            for (NSDictionary *dd in arr) {
                
                RH_ListTranModel *model = [[RH_ListTranModel alloc] initWithDict:dd];
                
                RH_ListTranFrame *frame = [[RH_ListTranFrame alloc] init];
                
                frame.listModel = model;
                
                [mut addObject:frame];
                
            }
            
            self.array = mut;
            
            [self.tableview reloadData];
            
        }else
        {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
        }
    } failured:^(NSError* error)
     {
         
         [SVProgressHUD showErrorWithStatus:error.description];
         
     }];
    
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
