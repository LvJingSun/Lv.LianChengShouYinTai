//
//  FSB_TypeViewController.m
//  CashierDeskIphone
//
//  Created by mac on 2017/6/16.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "FSB_TypeViewController.h"
#import "RH_RechargeViewController.h"
#import "FSB_Header.h"
#import "TypeHeadView.h"
#import "FSB_RechargeViewController.h"

@interface FSB_TypeViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableview;

@end

@implementation FSB_TypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"分类";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self allocWithTableview];
    
}

- (void)allocWithTableview {
    
    TypeHeadView *headview = [[TypeHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT * 0.2 + 160)];

    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64)];
    
    self.tableview = tableview;
    
    tableview.tableHeaderView = headview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:tableview];
    
    headview.RHblock = ^{
        
        //进入小红马页面
        RH_RechargeViewController *vc = [[RH_RechargeViewController alloc] init];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    };
    
    headview.FSBblock = ^{
        
        //进入粉丝宝页面
        FSB_RechargeViewController *vc = [[FSB_RechargeViewController alloc] init];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    };
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    return nil;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 0;
    
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
