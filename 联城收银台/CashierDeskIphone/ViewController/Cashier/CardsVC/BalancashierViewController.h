//
//  BalancashierViewController.h
//  CashierDeskIphone
//
//  Created by 冯海强 on 15-4-16.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"
#import "CommonUtil.h"
#import "UIImageView+AFNetworking.h"
#import "ImageCache.h"
#import "DownSheet.h"
#import "BCloundMenuViewController.h"

typedef void (^ReturniscleanBlock)(NSString *showBool);

@interface BalancashierViewController : BaseViewController<UITextFieldDelegate,DownSheetDelegate>
{
    IBOutlet UITextField *moneytextfield;
    
    BOOL BCMOpened;//类别
    
    BCloundMenuViewController   *downView;
    
    NSString                    *mentiu;
    IBOutlet UIButton           *mentiubtn;
    NSMutableArray              *menta;
    
    
    float  sum;
        
}

@property (weak, nonatomic) IBOutlet UIView         *m_titleVIew;
@property (weak, nonatomic) IBOutlet UIView         *m_tempView;

//确认信息
@property (weak, nonatomic) IBOutlet UIView         *m_confirmView;
@property (weak, nonatomic) IBOutlet UILabel        *m_namelabel;
@property (weak, nonatomic) IBOutlet UILabel        *m_phonelabel;
@property (weak, nonatomic) IBOutlet UIImageView    *m_photoView;

@property (weak, nonatomic) IBOutlet UIButton       *m_pushdownbtn;

// 请求数据用的goosID
@property (nonatomic, strong) NSString              *m_goodsId;


@property (nonatomic,strong) NSDictionary           *m_dic;
@property (weak, nonatomic) ImageCache              *imageCache;

@property (nonatomic, copy) ReturniscleanBlock      returnBoolBlock;

// 存放选择菜单的数据
@property (nonatomic, strong) NSMutableDictionary   *m_flagDic;
// 存放座位的id
@property (nonatomic, strong) NSString              *m_seatId;
// 存放作为列表的数据
@property (nonatomic, strong) NSMutableArray        *m_seatList;

@property (nonatomic, copy) NSString *shouyin_Type; //1-会员卡 2-积分 3-红包

- (void)returnText:(ReturniscleanBlock)block;





@end
