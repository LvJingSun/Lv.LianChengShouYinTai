//
//  HistorycashierViewController.m
//  CashierDeskIphone
//
//  Created by 冯海强 on 15-4-16.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "HistorycashierViewController.h"
#import "HistorycashierTableViewCell.h"

@interface HistorycashierViewController ()

@end

@implementation HistorycashierViewController

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
    
    return 70;
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    HistorycashierTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray*cellarray=[[NSBundle mainBundle]
                           loadNibNamed:@"HistorycashierTableViewCell" owner:self options:nil];
        cell =[cellarray objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    return cell;
}





- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
