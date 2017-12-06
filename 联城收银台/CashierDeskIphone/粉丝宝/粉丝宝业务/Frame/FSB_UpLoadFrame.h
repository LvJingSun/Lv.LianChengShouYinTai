//
//  FSB_UpLoadFrame.h
//  CashierDeskIphone
//
//  Created by mac on 2017/6/24.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FSB_TranInfoModel;

@interface FSB_UpLoadFrame : NSObject

@property (nonatomic, assign) CGRect acountTitleF;

@property (nonatomic, assign) CGRect acountF;

@property (nonatomic, assign) CGRect acountLineF;

@property (nonatomic, assign) CGRect nameTitleF;

@property (nonatomic, assign) CGRect nameF;

@property (nonatomic, assign) CGRect nameLineF;

@property (nonatomic, assign) CGRect productTitleF;

@property (nonatomic, assign) CGRect productF;

@property (nonatomic, assign) CGRect productLineF;

@property (nonatomic, assign) CGRect tranCountTitleF;

@property (nonatomic, assign) CGRect tranCountF;

@property (nonatomic, assign) CGRect tranCountLineF;

@property (nonatomic, assign) CGRect redCountTitleF;

@property (nonatomic, assign) CGRect redCountF;

@property (nonatomic, assign) CGRect redCountLineF;

@property (nonatomic, assign) CGRect redCopiesTitleF;

@property (nonatomic, assign) CGRect redCopiesF;

@property (nonatomic, assign) CGRect redCopiesLineF;

@property (nonatomic, assign) CGRect goldCountTitleF;

@property (nonatomic, assign) CGRect goldCountF;

@property (nonatomic, assign) CGRect goldCountLineF;

@property (nonatomic, assign) CGRect staffTitleF;

@property (nonatomic, assign) CGRect staffF;

@property (nonatomic, assign) CGRect staffLineF;

@property (nonatomic, assign) CGRect InvoiceTitleF;

@property (nonatomic, assign) CGRect AddInvoiceBtnF;

@property (nonatomic, assign) CGRect SureBtnF;

@property (nonatomic, assign) CGRect SureBtnBGViewF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) FSB_TranInfoModel *tranModel;

@end
