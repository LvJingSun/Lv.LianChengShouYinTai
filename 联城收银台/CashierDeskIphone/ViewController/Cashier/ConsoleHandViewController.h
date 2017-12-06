//
//  ConsoleHandViewController.h
//  CashierDeskIphone
//
//  Created by mac on 13-9-12.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//  手动收银

#import "BaseViewController.h"
#import "CbalanceViewController.h"
#import <ZXingWidgetController.h>
#import "WaimaiOrderViewController.h"
#import "UserListViewController.h"

#import "CategoryView.h"


@interface ConsoleHandViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextFieldDelegate,ZXingDelegate,CategoryDelegate,ChangeContentDelegate>
{
    CbalanceViewController *_CbalanceVC;
    
    IBOutlet UIButton *Cardrecordbtn;
}

- (IBAction)waimaiBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *m_cardTextField;
//@property (weak, nonatomic) IBOutlet UIButton *m_minusBtn;
//
//@property (weak, nonatomic) IBOutlet UIButton *m_plusBtn;

@property (assign, nonatomic) NSInteger m_number;

//@property (weak, nonatomic) IBOutlet UITextField *m_numberTextField;
//
//@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@property (strong, nonatomic) IBOutlet UIView *m_footerView;

@property (nonatomic, strong) NSMutableArray  *m_array;

// 当前活动的textField
@property (nonatomic, strong) UITextField   *m_activeTextField;

@property (nonatomic, strong) NSMutableDictionary  *m_dic;

@property (weak, nonatomic) IBOutlet UIView *m_titleVIew;

@property (nonatomic, strong) NSString *m_stringType;

// 菜单的订单列表
@property (nonatomic, strong) NSMutableArray        *m_orderList;


// 返回按钮触发的事件
- (IBAction)backLastView:(id)sender;

//// 减小数字
//- (IBAction)minusClicked:(id)sender;
//
//// 增加数字
//- (IBAction)m_plusClicked:(id)sender;

// 验证按钮触发的事件
- (IBAction)vidateClicked:(id)sender;

// 判断输入框里值是否为空
- (BOOL)emptyString;

// 请求数据
- (void)requestSubmit;

- (IBAction)userListClick:(id)sender;


@property (nonatomic,strong) IBOutlet UIView *m_handView;


@end
