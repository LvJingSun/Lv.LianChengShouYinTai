//
//  Configuration.h
//  CashierDeskIphone
//
//  Created by mac on 13-8-27.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#ifndef CashierDeskIphone_Configuration_h
#define CashierDeskIphone_Configuration_h

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.00f green:((float)((rgbValue & 0xFF00) >> 8))/255.00f blue:((float)(rgbValue & 0xFF))/255.00f alpha:1.0]

#define UIColorFromRGBWithAlpha(hexValue,alpha)  [UIColor colorWithRed:((hexValue >> 16) & 0x000000FF)/255.0f green:((hexValue >> 8) & 0x000000FF)/255.0f blue:((hexValue) & 0x000000FF)/255.0 alpha:alpha];

#define isRetina_4 ([UIScreen instancesRespondToSelector:@selector(currentMode)]?CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size):NO)

#define CreatImageByUrl(name)                       [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:name ofType:imgTypeIsPng]]
#define imgTypeIsPng                               @"png"
#define CreatImageByName(name)                     [UIImage imageNamed:name]


// 网络接口配置 正式 221.228.197.77:8010   测试 222.191.251.180:8010
#define CDHTTPRequestURL                            @"http://221.228.197.77:8010/CashierDesk/"

//#define CDHTTPRequestLogin                          @"CommCashLogin.ashx" //登陆

#define CDHTTPRequestLogin                          @"CommCashLogin_1.ashx" //登陆

// 更多页面刷新数据-收款统计
#define CDHTTPRequestReshData                       @"CashStatistics.ashx"
// 关于我们、帮助
#define CDHTTPRequestMore                           @"MoreAbout.ashx"

// key值验证
#define CDHTTPRequestKeyValidate                    @"ConfirmMemberKeyCode.ashx"

// 确认收银
#define CDHTTPRequestConfirm                        @"ConfirmCash_1.ashx"

// 消费收银——确认收银操作
#define CDHTTPRequestHandCashier                    @"ConsumerCashier_1.ashx"

// 公告列表
#define CDHTTPRequestNotificationList               @"NoticeList.ashx"
// 公告详情
#define CDHTTPRequestNotificationDetail             @"NoticeDetail.ashx"

//确认中、已确认
#define CDHTTPRequestConsumer                       @"ConsumerCashRegisterRecord.ashx"

// key值收银记录
#define CDHTTPRequestKeyConsumer                    @"ConfirmCashRecognized.ashx"

// 消费收银——取消操作
#define CDHTTPRequestCustomerCancel                 @"ConsumerCancel.ashx"

// 消费收银——确认操作
#define CDHTTPRequestCustomerConfirm                @"ConsumerConfirm.ashx"

// 修改密码
#define CDHTTPRequestModify                         @"ChangePassword.ashx"

// 公众邀请码获得手机号
#define CDHTTPRequestPhone                         @"IsExist.ashx"


// 券券key值验证
#define CDHTTPRequestQuanquanKeyValidate                    @"VoucherKeyCheck.ashx"
// 券券key值收银
#define CDHTTPRequestQuanquanKeyConfirm                     @"VoucherKeyConfirm.ashx"
//会员卡支付先确认信息
//#define CHTTPRequestcardVIPCardCheckm                    @"VIPCardCheck.ashx"
#define CHTTPRequestcardVIPCardCheckm                    @"VIPCardCheck_1.ashx"
//会员卡收银发起收银
//#define CHTTPRequestVIPCardPay                          @"VIPCardPay.ashx"
#define CHTTPRequestVIPCardPay                          @"Cashier_clickbtn.ashx"
//会员卡收银记录
#define VIPCardCashierRecords                       @"VIPCardCashierRecords.ashx"

#define RGBACKTAB  [UIColor colorWithRed:72/255.f green:162/255.f blue:245/255.f alpha:1.0]


//常设返回信息
#define statusOfReturn                              @"status"
#define MsgOfReturn                                 @"msg"
#define sdatetime                                   @"sDatetime"

//用户数据结构
#define cashierAccountId                            @"CashierAccountId"
#define mctlogo                                     @"MctLogo"
#define mctname                                     @"MctName"
#define shopname                                    @"ShopName"
//#define address                                     @"Address"
#define realname                                    @"RealName"
#define account                                     @"Account"
#define lastlogindate                               @"LastLoginDate"
#define dayreceivablescount                         @"DayReceivablesCount"
#define workreceivablescount                        @"WorkReceivablesCount"
#define monthreceivablescount                       @"MonthReceivablesCount"
#define statisticaldate                             @"StatisticalDate"
#endif
