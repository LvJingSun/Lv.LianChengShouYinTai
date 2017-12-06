//
//  QFFRecordsController.m
//  CashierDeskIphone
//
//  Created by mac on 16/8/24.
//  Copyright © 2016年 MaxLinksTec. All rights reserved.
//

#import "QFFRecordsController.h"
#import "QFFDetailCell.h"
#import "SVProgressHUD.h"
#import "HttpClientRequest.h"
#import "AppHttpClient.h"
#import "New_DetailController.h"
#import "New_RecordModel.h"
#import "YonghuNoticeView.h"
// 屏幕宽度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

// 屏幕高度
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface QFFRecordsController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate> {

    NSString *cashierID;
    
    NSString *_YhGetID;
    
    NSString *_Num;
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, weak) UILabel *noLabel;

@end

@implementation QFFRecordsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    cashierID = memberId;
    
    self.title = @"充值记录";
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BJImage.png"]];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    self.navigationController.navigationBarHidden = NO;
    
    UILabel *nolabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 150, SCREEN_WIDTH - 100, 30)];
    
    self.noLabel = nolabel;
    
    nolabel.text = @"暂无记录";
    
    nolabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:nolabel];
    
    [self initWithTableview];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    self.navigationItem.backBarButtonItem = backItem;
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
}

-(void)viewWillAppear:(BOOL)animated {

    [self requestdata];
    
}

- (void)initWithTableview {
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = [UIColor clearColor];
    
    YonghuNoticeView *headview = [[YonghuNoticeView alloc] init];
    
    headview.frame = CGRectMake(0, 0, SCREEN_WIDTH, headview.height);
    
    headview.titletext = @"⭐️【向左滑动】可撤销当天交易";
    
    tableview.tableHeaderView = headview;
    
    [self.view addSubview:tableview];
    
}

-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewRowAction *emailAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"撤销" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        NSDictionary *dic = self.dataArray[indexPath.row];
        
        _YhGetID = dic[@"TranRcdsid"];
        
        _Num = dic[@"Jinzhongzi"];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"是否要撤销该笔交易？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        [alert show];
        
    }];
    
    return @[emailAction];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    switch (buttonIndex) {
        case 1:
        {
        
            [self CancleTranWithID:_YhGetID WithNum:_Num];
            
        }
            break;
            
        default:
            break;
    }
    
}

//撤销
- (void)CancleTranWithID:(NSString *)recID WithNum:(NSString *)number {

    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                recID,@"YhGetID",
                                number,@"Num",
                                nil];
    
    [SVProgressHUD showWithStatus:@"撤销中..."];
    
    [requstClient request:@"BackJinZhongZi.ashx" parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
            [self requestdata];
            
        }else
        {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
        }
    } failured:^(NSError* error)
     {
         
         [SVProgressHUD showErrorWithStatus:error.description];
         
     }];

    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = self.dataArray[indexPath.row];

    QFFDetailCell *cell = [[QFFDetailCell alloc] init];
    
    cell.nameLab.text = dic[@"Memberid"];
    
    cell.timeLab.text = dic[@"CreateDate"];
    
    cell.countLab.text = dic[@"Jinzhongzi"];
    
    cell.productLab.text = dic[@"goodsname"];
    
    cell.yuangongLab.text = [NSString stringWithFormat:@"促销员:%@",dic[@"yuangong"]];
    
    cell.jineLab.text = [NSString stringWithFormat:@"消费:%@",dic[@"TranAccount"]];
    
    if ([dic[@"status"] isEqualToString:@"已提交"]) {
        
        cell.statusLab.textColor = [UIColor greenColor];
        
    }else if ([dic[@"status"] isEqualToString:@"已撤销"]) {
    
        cell.statusLab.textColor = [UIColor redColor];
        
    }else if ([dic[@"status"] isEqualToString:@"已退回"]) {
        
        cell.statusLab.textColor = [UIColor redColor];
        
    }
    
    cell.statusLab.text = [NSString stringWithFormat:@"%@",dic[@"status"]];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    QFFDetailCell *cell = [[QFFDetailCell alloc] init];
    
    return cell.height;
    
}

- (void)requestdata {
    
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                cashierID,@"CashierAccountID",
                                nil];
    
    [SVProgressHUD showWithStatus:@"获取数据中..."];
    
    [requstClient request:@"GetGldTranList_1.ashx" parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            NSArray *temp = [handlJson objectForKey:@"ybtrList"];
            
            if (temp.count == 0) {
                
                self.noLabel.hidden = NO;
                
                self.tableview.hidden = YES;
                
            }else {
                
                self.noLabel.hidden = YES;
                
                self.tableview.hidden = NO;
            
                self.dataArray = temp;
                
            }
            
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    New_DetailController *vc = [[New_DetailController alloc] init];
    
    NSDictionary *dic = self.dataArray[indexPath.row];
    
    New_RecordModel *record = [[New_RecordModel alloc] initWithDict:dic];
    
    vc.record = record;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

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
