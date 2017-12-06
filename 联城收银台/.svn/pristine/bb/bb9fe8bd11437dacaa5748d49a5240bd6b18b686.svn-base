//
//  MenuOrderDetailViewController.h
//  CashierDeskIphone
//
//  Created by mac on 15-6-11.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"
#import "UITableView+DataSourceBlocks.h"
#import "TableViewWithBlock.h"
#import "DownSheet.h"

@class TableViewWithBlock;


@interface MenuOrderDetailViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,DownSheetDelegate>{
    
    BOOL B_rightOpened;
    
    NSMutableArray              *menta;


}

@property (nonatomic, strong) NSString          *m_orderId;

@property (nonatomic,strong) NSMutableArray     *m_orderDetailList;

// 存放订单的状态值 Status 1表示已支付 0表示未支付
@property (nonatomic, strong) NSString          *m_status;

@property (nonatomic, strong) NSMutableArray    *B_RightArray;
// 存放座位列表的数据
@property (nonatomic, strong) NSMutableArray        *m_seatList;

@property (strong, nonatomic) UIWebView             *m_webView;

// 存放网络返回的数据
@property (nonatomic, strong) NSDictionary          *m_dic;

// 判断是否是展开还是闭合的集合
@property (nonatomic, strong) NSMutableSet          *m_SectionsSet;

// 记录座位的值
@property (nonatomic, strong) NSString              *m_seatName;


// 取消订单操作
- (void)cancelOrderRequest;

// 详情请求数据
- (void)orderDetailRequest;

// 更换座位
- (void)ChangeSeat;

// 更换座位请求数据
- (void) chooseSeatRequest:(NSString *)seatId;

@end
