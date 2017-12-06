//
//  CommonUtil.h
//  bazhifuApp
//
//  Created by mac on 13-6-8.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

// 输入的用户名
static NSString * const ACCOUNT = @"account";
// 用户的id
static NSString * const MEMBER_ID = @"memberId";
// 密码
static NSString * const PWD = @"pwd";
// 用户名
static NSString * const NICK = @"nick";
// 时差
static NSString * const SERVER_TIME_DIFF = @"serverTimeDiff";
// 用户名是否保存记录
static NSString * const CHECK_ACCOUNT = @"checkAccount";
// 密码是否保存记录
static NSString * const CHECK_PWD = @"checkPassword";

static NSString * const OPERATION_INCOME = @"Income";

static NSString * const OPERATION_EXPENDITURE = @"Expenditure";

static NSString * const KEY_TYPE_ACTIVITY = @"Activity";//活动

static NSString * const KEY_TYPE_SERVICE = @"Service";//服务资源

static NSString * const LOCK_STATUS = @"lockStatus";

static NSString * const LOCK_MESSAGE = @"lockMessage";

static NSString * const VLD_STATUS_AUDIT = @"Audit";//审核中

static NSString * const VLD_STATUS_INVALID = @"Invalid";//无效

static NSString * const VLD_STATUS_VALID = @"Valid";//有效

static NSString * const VLD_STATUS_NOT_CERTIFIED = @"NotCertified";//未认证

static NSString * const REAL_ACCOUNT_NAME = @"realAccountName";

static NSString * const REAL_ACCOUNT_IDCARD = @"realAccountIdcard";

static NSString * const TYPE_CITY = @"city";

static NSString * const TYPE_CATEGORY = @"category";


static NSString * const PHONE = @"phone";

static NSString * const ADDRESS = @"address";

static NSString * const DAYCOUNT = @"DayReceivablesCount";

static NSString * const DAYMONEY = @"DayReceivablesMoney";

static NSString * const LASTLOGINTIME = @"LastLoginDate";

static NSString * const MCTLOGO = @"MctLogo";

static NSString * const MCTNAME = @"MctName";

static NSString * const MONTHCOUNT = @"MonthReceivablesCount";

static NSString * const MONTHMONEY = @"MonthReceivablesMoney";

static NSString * const SHOPNAME = @"ShopName";

static NSString * const STATISTDATE = @"StatisticalDate";

static NSString * const WEEKCOUNT = @"WeekReceivablesCount";

static NSString * const WEEKMONEY = @"WeekReceivablesMoney";

static NSString * const VERSION = @"versionNumber";

static NSString * const APPURL = @"appurl";

// 登录里面标志商户是点单模式还是美容模式
static NSString * const ISSELECTSEAT = @"IsSelectSeat";



@interface CommonUtil : NSObject

+ (NSString *) getServerKey;

+ (NSString *) getDocumentPath:(NSString *)fileName;

+ (id) getValueByKey:(NSString *)key;

+ (void) addValue:(id)object andKey:(NSString *)key;

+ (NSDictionary *) transactionTypeDict;

+ (NSDictionary *) operationsDict;

+ (NSDictionary *) statusDict;

+ (NSDictionary *) keyStatusDict;

+ (UIColor *)colorWithHexValue:(NSUInteger)hexValue alpha:(CGFloat)alpha;

+ (UIColor *)selectBackgroundColor;

+ (UIColor *)selectTabBarTitleColor;

+ (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)reSize;

@end
