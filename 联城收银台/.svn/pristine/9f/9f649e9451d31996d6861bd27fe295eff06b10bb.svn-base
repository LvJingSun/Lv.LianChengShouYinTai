//
//  CashiertimelistViewController.m
//  CashierDeskIphone
//
//  Created by 冯海强 on 15-4-17.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "CashiertimelistViewController.h"
#import "CashiertimelistTableViewCell.h"

#import "HistorycashierViewController.h"

@interface CashiertimelistViewController ()

@end

@implementation CashiertimelistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.m_sempitview.hidden = YES;
    [self.m_tableview setDelegate:self];
    [self.m_tableview setDataSource:self];
    [self.m_tableview setPullDelegate:self];
    self.m_tableview.pullBackgroundColor = [UIColor whiteColor];
    self.m_tableview.useRefreshView = YES;
    self.m_tableview.useLoadingMoreView = YES;
    m_pageIndex = 1;
    // 版本判断
    if ( isIOS7 ) {
        
        [self.m_titleVIew setFrame:CGRectMake(0, 20, 320, 48)];
        
        if ( iPhone5 ) {
            
            [self.m_tempView setFrame:CGRectMake(0, 68, 320, [[UIScreen mainScreen]bounds].size.height - 20 - 48)];
            
        }else{
            
            [self.m_tempView setFrame:CGRectMake(0, 68, 320, [[UIScreen mainScreen]bounds].size.height)];
            
        }
        
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
        label.backgroundColor = [UIColor blackColor];
        
        [self.view addSubview:label];
        
    }else{
        
        [self.m_titleVIew setFrame:CGRectMake(0, 0, 320, 48)];
        
        [self.m_tempView setFrame:CGRectMake(0, 48, 320, self.view.frame.size.height - 48)];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backLastView:(id)sender {
    
    [self goBack];
}

#pragma UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //    return self.Cashierarray.count;
    return 4;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 55;
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    CashiertimelistTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray*cellarray=[[NSBundle mainBundle]
                           loadNibNamed:@"CashiertimelistTableViewCell" owner:self options:nil];
        cell =[cellarray objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    if (indexPath.row % 2 == 1) {
        cell.contentView.backgroundColor =[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    }else{
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    return cell;
}





- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HistorycashierViewController *VC = [[HistorycashierViewController alloc]initWithNibName:@"HistorycashierViewController" bundle:nil];
    [self.navigationController pushViewController:VC animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//取消选中状态。。
    
}

#pragma mark - PullTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {
    
    m_pageIndex = 1;
    
    [self performSelector:@selector(CardRequestSubmit) withObject:nil];
    
    
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {
    
    m_pageIndex++;
    [self performSelector:@selector(CardRequestSubmit) withObject:nil];
    
}


@end
