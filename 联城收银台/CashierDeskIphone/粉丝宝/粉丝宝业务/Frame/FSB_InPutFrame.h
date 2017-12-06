//
//  FSB_InPutFrame.h
//  CashierDeskIphone
//
//  Created by mac on 2017/6/16.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FSB_TranInfoModel;

@interface FSB_InPutFrame : NSObject

@property (nonatomic, assign) CGRect productTitleF;

@property (nonatomic, assign) CGRect productF;

@property (nonatomic, assign) CGRect productLineF;

@property (nonatomic, assign) CGRect tranCountTitleF;

@property (nonatomic, assign) CGRect tranCountF;

@property (nonatomic, assign) CGRect tranCountLineF;

//红包类型标题
@property (nonatomic, assign) CGRect redTypeTitleF;

//选择商户
@property (nonatomic, assign) CGRect type_merchantF;

//选择平台
@property (nonatomic, assign) CGRect type_pingtaiF;

//提示标题
@property (nonatomic, assign) CGRect noticeF;

//选择会员卡余额
@property (nonatomic, assign) CGRect merchant_huiyuankaF;

//选择可提现
@property (nonatomic, assign) CGRect merchant_tixianF;

//红包类型线
@property (nonatomic, assign) CGRect redTypeLineF;


@property (nonatomic, assign) CGRect redCountTitleF;

@property (nonatomic, assign) CGRect redCountF;

@property (nonatomic, assign) CGRect redCountLineF;

@property (nonatomic, assign) CGRect redCopiesTitleF;

@property (nonatomic, assign) CGRect redCopiesF;

@property (nonatomic, assign) CGRect redCopiesLineF;

@property (nonatomic, assign) CGRect jifenCountTitleF;

@property (nonatomic, assign) CGRect jifenCountF;

@property (nonatomic, assign) CGRect jifenCountLineF;

@property (nonatomic, assign) CGRect goldCountTitleF;

@property (nonatomic, assign) CGRect goldCountF;

@property (nonatomic, assign) CGRect goldCountLineF;

@property (nonatomic, assign) CGRect staffTitleF;

@property (nonatomic, assign) CGRect staffF;

@property (nonatomic, assign) CGRect staffLineF;

@property (nonatomic, assign) CGRect SureBtnF;

@property (nonatomic, assign) CGRect SureBtnBGViewF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) FSB_TranInfoModel *tranModel;

- (CGFloat)getCellHeight;

@end
