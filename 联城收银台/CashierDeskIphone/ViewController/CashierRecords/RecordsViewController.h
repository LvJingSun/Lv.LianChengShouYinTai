//
//  RecordsViewController.h
//  CashierDeskIphone
//
//  Created by mac on 13-9-8.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//  收银记录

#import "BaseViewController.h"

#import "PullTableView.h"

@interface RecordsViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,PullTableViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *m_leftBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_rightBtn;

@property (weak, nonatomic) IBOutlet PullTableView *m_tableView;

@property (nonatomic, strong) NSString *m_stringType;

// 记录当前页
@property (nonatomic, assign) NSInteger   m_pageSize;
// 存放数据的数组
@property (nonatomic, strong) NSMutableArray  *m_keyArray;

@property (weak, nonatomic) IBOutlet UIView *m_titleView;


@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;

- (void)setLeftBtn:(BOOL)aLeft rightBtn:(BOOL)aRight;

- (IBAction)btnClicked:(id)sender;


// key值收银请求数据
- (void)requestKeySubmit;
// 消费收银记录请求数据
- (void)requestConsumerSubmit;

@end
