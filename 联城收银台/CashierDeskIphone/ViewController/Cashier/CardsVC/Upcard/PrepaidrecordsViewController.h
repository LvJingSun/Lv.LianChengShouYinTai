//
//  PrepaidrecordsViewController.h
//  CashierDeskIphone
//
//  Created by 冯海强 on 15-4-23.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"

#import "PullTableView.h"

@interface PrepaidrecordsViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,PullTableViewDelegate>

{
    int m_pageIndex;
    
}
@property (nonatomic,strong) NSMutableArray *Cashierarray;

@property (nonatomic, strong) NSArray *huahuaArray;

@property (weak, nonatomic) IBOutlet UIView *m_titleVIew;
@property (weak, nonatomic) IBOutlet UIView *m_tempView;

@property (weak, nonatomic) IBOutlet UILabel *m_Cashiereview;
@property (weak, nonatomic) IBOutlet PullTableView *m_Cashiertableview;

@property (nonatomic, copy) NSString *type;
@end