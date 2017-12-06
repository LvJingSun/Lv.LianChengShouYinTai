//
//  RH_InPutFrame.h
//  CashierDeskIphone
//
//  Created by mac on 2017/6/16.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RH_TranInfoModel;

@interface RH_InPutFrame : NSObject

@property (nonatomic, assign) CGRect productTitleF;

@property (nonatomic, assign) CGRect productF;

@property (nonatomic, assign) CGRect productLineF;

@property (nonatomic, assign) CGRect redCountTitleF;

@property (nonatomic, assign) CGRect redCountF;

@property (nonatomic, assign) CGRect redCountLineF;

@property (nonatomic, assign) CGRect redCopiesTitleF;

@property (nonatomic, assign) CGRect redCopiesF;

@property (nonatomic, assign) CGRect redCopiesLineF;

@property (nonatomic, assign) CGRect redProportionTitleF;

@property (nonatomic, assign) CGRect redProportionF;

@property (nonatomic, assign) CGRect redProportionLineF;

@property (nonatomic, assign) CGRect goldCountTitleF;

@property (nonatomic, assign) CGRect goldCountF;

@property (nonatomic, assign) CGRect goldCountLineF;

//@property (nonatomic, assign) CGRect staffTitleF;
//
//@property (nonatomic, assign) CGRect staffF;
//
//@property (nonatomic, assign) CGRect staffLineF;

@property (nonatomic, assign) CGRect SureBtnF;

@property (nonatomic, assign) CGRect SureBtnBGViewF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) RH_TranInfoModel *tranModel;

@end
