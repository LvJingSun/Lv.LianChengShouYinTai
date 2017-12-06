//
//  WaimaiOrderDetailViewController.h
//  CashierDeskIphone
//
//  Created by mac on 15-9-12.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"

@protocol Peisongdelegate <NSObject>

-(void)PeisongAction;

@end

@interface WaimaiOrderDetailViewController : BaseViewController

//菜单
@property (nonatomic, strong) NSDictionary    *m_orderdetailDIC;
// 判断是否是展开还是闭合的集合
@property (nonatomic, strong) NSMutableSet          *m_SectionsSet;
@property (strong, nonatomic) UIWebView             *m_webView;

@property (weak, nonatomic) IBOutlet UIView *m_titleView;
@property (weak, nonatomic) IBOutlet UITableView *m_detailTableView;

@property (nonatomic, assign) id <Peisongdelegate> delegate;

@property (nonatomic, copy) NSString *AVLIST;//要求，如口味；

@end
