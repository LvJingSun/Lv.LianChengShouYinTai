//
//  CashierTaoCanViewController.h
//  CashierDeskIphone
//
//  Created by mac on 15-6-9.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  美容行业的情况下套餐页面

#import "BaseViewController.h"

#import "UITableView+DataSourceBlocks.h"
#import "TableViewWithBlock.h"


@class TableViewWithBlock;


@interface CashierTaoCanViewController : BaseViewController

@property (nonatomic,strong) IBOutlet TableViewWithBlock *m_tableView;
@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;
@property (weak, nonatomic) IBOutlet UIView *m_buttomView;

@property (nonatomic, strong) NSMutableArray             *m_taocanArray;

@property (nonatomic, strong) NSMutableDictionary           *m_dic;

// 存放手机号码的字符串
@property (nonatomic, strong) NSString                      *m_phoneString;

// 存放数据
@property (nonatomic,retain) NSMutableDictionary            *m_flagDic;

@property (nonatomic, strong) NSString                      *m_ordersId;

@end
