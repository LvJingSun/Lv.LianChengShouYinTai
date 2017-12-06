//
//  FSB_ListViewController.m
//  CashierDeskIphone
//
//  Created by mac on 2017/7/5.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "FSB_ListViewController.h"
#import "FSB_ListModel.h"
#import "FSB_ListFrame.h"
#import "FSB_ListCell.h"
#import "FSB_Header.h"
#import "YonghuNoticeView.h"
#import "FSB_DetailViewController.h"

@interface FSB_ListViewController () <UITableViewDelegate,UITableViewDataSource> {

    FSB_ListModel *cancleModel;
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSMutableArray *array;

@end

@implementation FSB_ListViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"明细";
    
    [self allocWithTableview];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];

    [self requestForData];
    
}

- (void)allocWithTableview {
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = BGColor;
    
    YonghuNoticeView *headview = [[YonghuNoticeView alloc] init];
    
    headview.frame = CGRectMake(0, 0, SCREENWIDTH, headview.height);
    
    headview.titletext = @"⭐️【向左滑动】可撤销当天交易";
    
    tableview.tableHeaderView = headview;
    
    [self.view addSubview:tableview];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.array.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FSB_ListFrame *frame = self.array[indexPath.row];
    
    FSB_ListCell *cell = [[FSB_ListCell alloc] init];
    
    cell.frameModel = frame;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FSB_ListFrame *frame = self.array[indexPath.row];
    
    return frame.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    FSB_ListFrame *frame = self.array[indexPath.row];
    
    FSB_ListModel *model = frame.listModel;
    
    FSB_DetailViewController *vc = [[FSB_DetailViewController alloc] init];
    
    vc.tranModel = model;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewRowAction *emailAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"撤销" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        FSB_ListFrame *frame = self.array[indexPath.row];
        
        cancleModel = frame.listModel;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"是否要撤销该笔交易？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        [alert show];
        
    }];
    
    return @[emailAction];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 1:
        {
            
            [self rebackTran];
            
        }
            break;
            
        default:
            break;
    }
    
}

//撤销交易
- (void)rebackTran {

    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         cancleModel.TranID,@"YhGetID",
                         cancleModel.Num,@"Num",
                         nil];
    
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    
    [SVProgressHUD showWithStatus:@"撤销中"];
    
    [requstClient request:@"BackJinZhongZiNew_1.ashx" parameters:dic successed:^(JSONDecoder *jsonDecoder, id responseObject) {
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [jsonDecoder objectWithData:data];
        
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
            [self requestForData];
            
        }else
        {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
        }
        
    } failured:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:error.description];
        
    }];
    
}

- (void)requestForData {

    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"CashierAccountID",
                                nil];
    
    [requstClient request:@"FansMercTran_1.ashx" parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            
            NSArray *arr = handlJson[@"ybtrList"];
            
            NSMutableArray *mut = [NSMutableArray array];
            
            for (NSDictionary *dd in arr) {
                
                FSB_ListModel *model = [[FSB_ListModel alloc] initWithDict:dd];
                
                FSB_ListFrame *frame = [[FSB_ListFrame alloc] init];
                
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

}

@end
