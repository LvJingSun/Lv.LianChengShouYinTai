//
//  New_DetailController.m
//  CashierDeskIphone
//
//  Created by mac on 2017/2/28.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "New_DetailController.h"
#import "New_RecordModel.h"
#import "New_RecordFrame.h"
#import "New_RecordCell.h"
#import "MakeUpController.h"
#import "SVProgressHUD.h"
#import "HttpClientRequest.h"
#import "AppHttpClient.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface New_DetailController ()<UITableViewDelegate,UITableViewDataSource,New_CancleBtnDelegate>

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation New_DetailController

-(NSArray *)dataArray {
    
    if (_dataArray == nil) {
        
        NSMutableArray *mutarr = [NSMutableArray array];
        
        New_RecordFrame *frame = [[New_RecordFrame alloc] init];
        
        frame.record = self.record;
        
        [mutarr addObject:frame];
        
        _dataArray = mutarr;
        
    }
    
    return _dataArray;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"记录详情";
    
    [self initWithTableview];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    self.navigationItem.backBarButtonItem = backItem;
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    [self setRightBtn];
    
}

- (void)setRightBtn {
    
    UIButton *screenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    screenBtn.frame = CGRectMake(0, 0, 50, 20);
    
    [screenBtn setTitle:@"上传" forState:UIControlStateNormal];
    
    screenBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    
    [screenBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    [screenBtn addTarget:self action:@selector(screenBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *screenBarBtn=[[UIBarButtonItem alloc]initWithCustomView:screenBtn];
    
    self.navigationItem.rightBarButtonItem = screenBarBtn;
    
}

- (void)screenBtnClick {

    MakeUpController *vc = [[MakeUpController alloc] init];
    
    vc.record = self.record;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)initWithTableview {
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:tableview];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    New_RecordCell *cell = [[New_RecordCell alloc] init];
    
    cell.frameModel = self.dataArray[indexPath.row];
    
    cell.delegate = self;
    
    return cell;
    
}

- (void)cancleBtnClick {

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"是否要撤销该笔交易？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 1:
        {
            
            [self CancleTran];
            
        }
            break;
            
        default:
            break;
    }
    
}

//撤销
- (void)CancleTran {
    
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                self.record.TranRcdsid,@"YhGetID",
                                self.record.Jinzhongzi,@"Num",
                                nil];
    
    [SVProgressHUD showWithStatus:@"撤销中..."];
    
    [requstClient request:@"BackJinZhongZi.ashx" parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }else
        {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
        }
    } failured:^(NSError* error)
     {
         
         [SVProgressHUD showErrorWithStatus:error.description];
         
     }];
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    New_RecordFrame *frame = self.dataArray[indexPath.row];
    
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
