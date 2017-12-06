//
//  Ca_MenuOrderViewController.h
//  CashierDeskIphone
//
//  Created by mac on 15-7-1.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"
#import "DownSheet.h"

@interface Ca_MenuOrderViewController : BaseViewController<DownSheetDelegate,UIAlertViewDelegate>{
    
    
    NSMutableArray              *menta;
    
}

@property (nonatomic, strong) NSString              *m_orderId;

// 判断是否是展开还是闭合的集合
@property (nonatomic, strong) NSMutableSet          *m_SectionsSet;

// 存放订单数据的数组
@property (nonatomic, strong) NSMutableArray        *m_orderList;

@property (strong, nonatomic) UIWebView             *m_webView;

// 存放网络返回的数据
@property (nonatomic, strong) NSDictionary          *m_dic;


// 存放座位的id
@property (nonatomic, strong) NSString              *m_seatId;
// 存放座位列表的数据
@property (nonatomic, strong) NSMutableArray        *m_seatList;
// 存放座位名称的字符
@property (nonatomic, strong) NSString              *m_seatNameString;

// 存放订单的状态
@property (nonatomic, strong) NSString              *m_status;


// 座位列表请求数据
- (void)seatRequestSubmit;

// 详情请求数据
- (void)orderDetailRequest;
// 取消订单操作
- (void)cancelOrderRequest;

@end
