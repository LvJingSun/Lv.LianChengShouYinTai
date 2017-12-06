//
//  ValidateResultViewController.h
//  CashierDeskIphone
//
//  Created by mac on 13-9-12.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//  验证结果页面

#import "BaseViewController.h"

#import "KeyValidateData.h"

@interface ValidateResultViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>;

@property (weak, nonatomic) IBOutlet UILabel        *m_titleLabel;

@property (nonatomic, strong) NSString              *m_typeString;  // 1为手动收银，0为快速收银


@property (strong, nonatomic) IBOutlet UIView       *m_HeaderView;

@property (strong, nonatomic) IBOutlet UIView       *m_footerView;

@property (strong ,nonatomic) KeyValidateData       *m_validateData;

@property (weak, nonatomic) IBOutlet UILabel        *m_numberCount;

@property (weak, nonatomic) IBOutlet UILabel        *m_usedKey;

@property (weak, nonatomic) IBOutlet UITableView    *m_tableView;
// 二维码扫描传递过来的keycode，用于请求参数
@property (nonatomic, strong) NSString              *m_keyCode;

// 用于存放有效的key值
@property (nonatomic, strong) NSMutableArray        *m_validateArray;

@property (weak, nonatomic) IBOutlet UIButton *m_sureBtn;

@property (weak, nonatomic) IBOutlet UIView *m_titleView;


// 返回按钮触发的事件
- (IBAction)backLastView:(id)sender;

// 确认收银触发的事件
- (IBAction)consoleSure:(id)sender;

// 请求数据
- (void) requestSubmit;

// 二维码扫描的key值请求数据
- (void) requestScanSubmit;

// 赋值
- (void) setTableViewValue;

@end












