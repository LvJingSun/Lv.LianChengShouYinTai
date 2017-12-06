//
//  UserInfoView.h
//  CashierDeskIphone
//
//  Created by mac on 13-9-8.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ImageCache.h"

@interface UserInfoView : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_areaLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_addressLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_userNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_timeLabel;

@property (weak, nonatomic) IBOutlet UIButton *m_logoutBtn;

@property (weak, nonatomic) IBOutlet UIImageView *m_imageView;

@property (weak, nonatomic) ImageCache *imageCache;





- (void)setValue;

@end


@interface ReceivablesCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *m_todayImg;

@property (weak, nonatomic) IBOutlet UIImageView *m_weekImg;

@property (weak, nonatomic) IBOutlet UIImageView *m_monthImg;

@property (weak, nonatomic) IBOutlet UILabel *m_todayLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_weekLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_monthLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_todayPrice;

@property (weak, nonatomic) IBOutlet UILabel *m_weekPrice;

@property (weak, nonatomic) IBOutlet UILabel *m_monthPrice;

@property (weak, nonatomic) IBOutlet UILabel *m_timeLabel;

@property (weak, nonatomic) IBOutlet UIButton *m_RefreshBtn;


@end

@interface CommonCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *m_nameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *m_imageView;

@property (weak, nonatomic) IBOutlet UIImageView *m_accessImgV;


@end

@interface VersionCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_versionLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_newVersionLabel;

@property (weak, nonatomic) IBOutlet UIButton *m_updateBtn;




@end