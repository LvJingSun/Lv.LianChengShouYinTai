//
//  UserInfoView.m
//  CashierDeskIphone
//
//  Created by mac on 13-9-8.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "UserInfoView.h"

#import "CommonUtil.h"

#import "UIImageView+AFNetworking.h"

@implementation UserInfoView

@synthesize m_addressLabel;

@synthesize m_areaLabel;

@synthesize m_logoutBtn;

@synthesize m_nameLabel;

@synthesize m_timeLabel;

@synthesize m_userNameLabel;

@synthesize m_imageView;

@synthesize imageCache;

//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code
//    }
//    return self;
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setValue{
    
    NSString *path = [CommonUtil getValueByKey:MCTLOGO];
    
    UIImage *reSizeImage = [self.imageCache getImage:path];
   
    if (reSizeImage != nil) {
        self.m_imageView.image = reSizeImage;
        return;
    }

    __weak UserInfoView *weakCell = self;

    // 图片加载
    [self.m_imageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[CommonUtil getValueByKey:MCTLOGO]]] placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        
        self.m_imageView.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
        
        [weakCell setNeedsLayout];
        
        // imageView的属性-设置图片填充满整个imageView
//        self.m_imageView.contentMode = UIViewContentModeScaleAspectFill;    
        
        [self.imageCache addImage:self.m_imageView.image andUrl:[CommonUtil getValueByKey:MCTLOGO]];
        
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        
        
    }];

}

@end


@implementation ReceivablesCell

@synthesize m_todayImg;

@synthesize m_todayLabel;

@synthesize m_todayPrice;

@synthesize m_weekImg;

@synthesize m_weekLabel;

@synthesize m_weekPrice;

@synthesize m_monthImg;

@synthesize m_monthLabel;

@synthesize m_monthPrice;

@synthesize m_timeLabel;

@synthesize m_RefreshBtn;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


@end


@implementation CommonCell

@synthesize m_nameLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


@end

@implementation VersionCell

@synthesize m_newVersionLabel;

@synthesize m_versionLabel;

@synthesize m_updateBtn;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


@end
