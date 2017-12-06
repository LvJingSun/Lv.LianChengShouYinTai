//
//  UserListViewController.h
//  CashierDeskIphone
//
//  Created by CityAndCity on 15-8-24.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"
#import "JPinYinUtil.h"
#import "UserListCell.h"
#import "UIImageView+AFNetworking.h"
#import "CardMemeberDetaiViewController.h"

@protocol ChangeContentDelegate <NSObject>

-(void)setTextField:(NSString *)textStr;

@end

@interface UserListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *m_titleView;
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
// 存放排序字母的数组
@property (nonatomic, strong) NSMutableArray            *indexAllKeys;
// 存放排序后数据的字典
@property (nonatomic, strong) NSMutableDictionary       *userListDic;

//模式
@property (nonatomic, strong) NSString          *m_IsSelectSeat;

@property(nonatomic, assign) id<ChangeContentDelegate> delegate;

- (IBAction)backButClick:(id)sender;

+(UserListViewController *)ShareUserListVC;

@end
