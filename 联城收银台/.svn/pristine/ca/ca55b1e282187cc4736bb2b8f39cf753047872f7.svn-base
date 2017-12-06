//
//  CbalanceViewController.h
//  CashierDeskIphone
//
//  Created by mac on 13-9-8.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"

#import <ZXingWidgetController.h>

#import "PullTableView.h"

@interface CbalanceViewController : BaseViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,ZXingDelegate,PullTableViewDelegate,UIAlertViewDelegate>{
    
    UIActivityIndicatorView* activity;

    UILabel     *activityLabel;
    
    BOOL ISscaning;//正在扫；
    
}

@property (weak, nonatomic) IBOutlet UIButton *m_leftBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_rightBtn;
// 两个btn的切换值记录
@property (nonatomic, strong) NSString *m_stringType;

@property (weak, nonatomic) IBOutlet UIView *m_quickView;

@property (weak, nonatomic) IBOutlet UIView *m_handView;

@property (weak, nonatomic) IBOutlet UIScrollView *m_scrollerView;

@property (weak, nonatomic) IBOutlet UIView *m_titleVIew;

@property (weak, nonatomic) IBOutlet UIImageView *m_slideImag;

@property (weak, nonatomic) IBOutlet UIButton *m_red_leftBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_red_midBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_red_rightBtn;

@property (strong, nonatomic) IBOutlet UIView *m_firstView;

@property (weak, nonatomic) IBOutlet UITextField *m_phoneTextField;

@property (weak, nonatomic) IBOutlet UITextField *m_priceTextField;


@property (strong, nonatomic) IBOutlet UIView *m_secondView;

@property (weak, nonatomic) IBOutlet PullTableView *m_secondTableView;

@property (strong, nonatomic) IBOutlet UIView *m_thirdView;

@property (weak, nonatomic) IBOutlet PullTableView *m_thirdTableVIew;

@property (nonatomic, assign) NSInteger   m_pageSize;
// 存放数据的数组 - 待确认
@property (strong, nonatomic) NSMutableArray  *m_consumerArray;
// 已支付的数据
@property (strong, nonatomic) NSMutableArray  *m_payConsumerArray;

// 用于辨别选中的是第几个按钮
@property (nonatomic, strong) NSString       *m_typeString;
// 取消操作的记录
@property (nonatomic,assign)  NSInteger      m_index;
// 确定操作的记录
@property (nonatomic,assign)  NSInteger      m_ConformIndex;
// 空数据时的提示
@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_emptySureLabel;
// 记录二维码的扫描结果字符
@property (nonatomic, strong) NSString       *m_ScanString;

@property (weak, nonatomic) IBOutlet UIView *m_tempView;

@property (weak, nonatomic) IBOutlet UIImageView *m_imageView;

@property (nonatomic, strong) UIButton *FinishButton;

@property (nonatomic, strong) UIButton *doneButton;

@property (nonatomic, assign) BOOL needDone;

@property (nonatomic,assign) BOOL keyShow;

@property (nonatomic, strong) UITextField *m_activityField;

// 记录是key值的还是手机号码的二维码扫描 1为key值  2为手机号码
@property(nonatomic, assign) int m_scanIndex;

@property (nonatomic, strong) UIImageView *readline;


@property (nonatomic, strong) ZXingWidgetController *mWidgetController;



- (void)setLeftBtn:(BOOL)aLeft rightBtn:(BOOL)aRight;

// 左右按钮的切换
- (IBAction)btnClicked:(id)sender;

// 快速收银
- (IBAction)quickCash:(id)sender;

// 手动收银
- (IBAction)handCash:(id)sender;


- (void)setLeft:(BOOL)aLeft midBtn:(BOOL)aMid rightBtn:(BOOL)aRight;

// 选择三种状态
- (IBAction)changStateClicked:(id)sender;

// 确认收银按钮触发的事件
- (IBAction)makeSure:(id)sender;

// 消费收银请求数据 - 消费结账
- (void)requestSubmit;

// 请求数据-待付款
- (void)requestPaySubmit;

// 待确认请求数据
- (void)requestCustomerPay;

// 取消操作
- (void)customerCancel:(id)sender;

// 确认操作
- (void)customerConfirm:(id)sender;


// 用扫描来的公众邀请码去获得手机号
- (void)validatePhone:(NSString *)aPhone;

- (IBAction)showKeyboard:(id)sender;
- (IBAction)hideKeyboard:(id)sender;


@property (strong, nonatomic) UINavigationController *navigationController;

@end
