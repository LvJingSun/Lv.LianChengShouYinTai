//
//  FSB_DetailViewController.m
//  CashierDeskIphone
//
//  Created by mac on 2017/7/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "FSB_DetailViewController.h"
#import "FSB_Header.h"
#import "FSB_DetailHeadview.h"
#import "FSB_ListModel.h"
#import "FSB_DetailCell.h"
#import "FSB_DetailImgCell.h"
#import <UIImageView+WebCache.h>

@interface FSB_DetailViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableview;

@end

@implementation FSB_DetailViewController

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
    
    headview.nameLab.text = self.tranModel.Memberid;
    
    headview.countLab.text = self.tranModel.Num;
    
    if ([self.tranModel.TranStatus isEqualToString:@"1"]) {
        
        headview.statusLab.text = self.tranModel.Commit;
        
    }else if ([self.tranModel.TranStatus isEqualToString:@"2"]) {
    
        headview.statusLab.text = @"已退回";
        
    }else if ([self.tranModel.TranStatus isEqualToString:@"3"]) {
    
        headview.statusLab.text = @"已撤销";
        
    }
    
    tableview.tableHeaderView = headview;
    
    [self.view addSubview:tableview];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        
        return 8;
        
    }else {
    
        return 1;
        
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        
        FSB_DetailCell *cell = [[FSB_DetailCell alloc] init];
        
        if (indexPath.row == 0) {
            
            cell.titleLab.text = @"商品信息";
            
            cell.valueLab.text = self.tranModel.Goodsname;
            
        }else if (indexPath.row == 1) {
            
            cell.titleLab.text = @"交易金额";
            
            cell.valueLab.text = self.tranModel.TranAccount;
            
        }else if (indexPath.row == 2) {
            
            cell.titleLab.text = @"红包金额";
            
            cell.valueLab.text = self.tranModel.Allaccount;
            
        }else if (indexPath.row == 3) {
            
            cell.titleLab.text = @"操作人员";
            
            cell.valueLab.text = self.tranModel.CashierAccountID;
            
        }else if (indexPath.row == 4) {
            
            cell.titleLab.text = @"店铺信息";
            
            cell.valueLab.text = self.tranModel.MerchantShopID;
            
        }else if (indexPath.row == 5) {
            
            cell.titleLab.text = @"促销员";
            
            cell.valueLab.text = self.tranModel.Yuangong;
            
        }else if (indexPath.row == 6) {
            
            cell.titleLab.text = @"交易时间";
            
            cell.valueLab.text = self.tranModel.CreateDate;
            
        }else if (indexPath.row == 7) {
            
            cell.titleLab.text = @"交易单号";
            
            cell.valueLab.text = self.tranModel.TranID;
            
        }
        
        return cell;
        
    }else {
    
        FSB_DetailImgCell *cell = [[FSB_DetailImgCell alloc] init];
        
        cell.titleLab.text = @"发票凭证";
        
        [cell.iconImg sd_setImageWithURL:[NSURL URLWithString:self.tranModel.fileUrlP] placeholderImage:[UIImage imageNamed:@"RH_发票占位.png"]];
        
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

}

@end
