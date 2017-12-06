//
//  RH_DetailTranViewController.m
//  CashierDeskIphone
//
//  Created by mac on 2017/8/4.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_DetailTranViewController.h"
#import "FSB_Header.h"
#import "RH_ListTranModel.h"
#import "FSB_DetailCell.h"
#import "FSB_DetailImgCell.h"
#import <UIImageView+WebCache.h>
#import "FSB_DetailHeadview.h"

@interface RH_DetailTranViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableview;

@end

@implementation RH_DetailTranViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"详情";
    
    [self allocWithTableview];
    
}

- (void)allocWithTableview {
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = BGColor;
    
    FSB_DetailHeadview *headview = [[FSB_DetailHeadview alloc] init];
    
    headview.frame = CGRectMake(0, 0, SCREENWIDTH, headview.height);
    
    headview.nameLab.text = self.listModel.Memberid;
    
    headview.countLab.text = self.listModel.Num;
        
    headview.statusLab.text = @"服务费";
    
    tableview.tableHeaderView = headview;
    
    [self.view addSubview:tableview];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return 7;
        
    }else {
        
        return 1;
        
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        FSB_DetailCell *cell = [[FSB_DetailCell alloc] init];
        
        if (indexPath.row == 0) {
            
            cell.titleLab.text = @"车辆信息";
            
            cell.valueLab.text = self.listModel.Goodsname;
            
        }else if (indexPath.row == 1) {
            
            cell.titleLab.text = @"车牌号";
            
            cell.valueLab.text = self.listModel.CarNo;
            
        }else if (indexPath.row == 2) {
            
            cell.titleLab.text = @"红包金额";
            
            cell.valueLab.text = self.listModel.Allaccount;
            
        }else if (indexPath.row == 3) {
            
            cell.titleLab.text = @"红包份数";
            
            cell.valueLab.text = self.listModel.TotalPart;
            
        }else if (indexPath.row == 4) {
            
            cell.titleLab.text = @"店铺信息";
            
            cell.valueLab.text = self.listModel.MerchantID;
            
        }else if (indexPath.row == 5) {
            
            cell.titleLab.text = @"交易时间";
            
            cell.valueLab.text = self.listModel.CreateDate;
            
        }else if (indexPath.row == 6) {
            
            cell.titleLab.text = @"交易单号";
            
            cell.valueLab.text = self.listModel.TranID;
            
        }
        
        return cell;
        
    }else {
        
        FSB_DetailImgCell *cell = [[FSB_DetailImgCell alloc] init];
        
        cell.titleLab.text = @"购车凭证";
        
        [cell.iconImg sd_setImageWithURL:[NSURL URLWithString:self.listModel.CarInvoiceImg] placeholderImage:[UIImage imageNamed:@"RH_发票占位.png"]];
        
        return cell;
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        FSB_DetailCell *cell = [[FSB_DetailCell alloc] init];
        
        return cell.height;
        
    }else {
        
        FSB_DetailImgCell *cell = [[FSB_DetailImgCell alloc] init];
        
        return cell.height;
        
    }
    
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
