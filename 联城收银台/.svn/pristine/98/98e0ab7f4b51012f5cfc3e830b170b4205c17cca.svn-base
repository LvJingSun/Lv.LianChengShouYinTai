//
//  QuanquanResultViewController.m
//  CashierDeskIphone
//
//  Created by mac on 15-3-13.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "QuanquanResultViewController.h"

#import "QuanquanData.h"

#import "UIImageView+AFNetworking.h"

#import "QRCodeGenerator.h"

@interface QuanquanResultViewController ()

@property (weak, nonatomic) IBOutlet UIView *m_titleView;

@property (weak, nonatomic) IBOutlet UIView *m_tempView;

@property (weak, nonatomic) IBOutlet UIScrollView *m_scrollerView;

@property (weak, nonatomic) IBOutlet UIImageView *m_imageView;

@property (weak, nonatomic) IBOutlet UIImageView *m_codeImgV;

@property (weak, nonatomic) IBOutlet UILabel *m_allName;
@property (weak, nonatomic) IBOutlet UILabel *m_title;
@property (weak, nonatomic) IBOutlet UILabel *m_time;
@property (weak, nonatomic) IBOutlet UILabel *m_code;
@property (weak, nonatomic) IBOutlet UILabel *m_desprition;

@property (weak, nonatomic) IBOutlet UILabel *m_shopName;
@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;

// 返回按钮触发的事件
- (IBAction)goback:(id)sender;
// 确认收银按钮触发的事件
- (IBAction)confirmClicked:(id)sender;

@end

@implementation QuanquanResultViewController

@synthesize m_quanquanString;

@synthesize imagechage;

@synthesize m_keyValue;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        imagechage = [[ImageCache alloc]init];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationController.navigationBar.translucent = NO;
    
    
    // 版本判断
    if ( isIOS7 ) {
        
        [self.m_titleView setFrame:CGRectMake(0, 20, 320, 48)];
        
        if ( iPhone5 ) {
            
            [self.m_tempView setFrame:CGRectMake(0, 68, 320, [[UIScreen mainScreen]bounds].size.height - 20 - 48)];

        
            [self.m_scrollerView setFrame:CGRectMake(0, 68, 320, [[UIScreen mainScreen]bounds].size.height - 20 - 48)];

        
        }else{
    
            [self.m_tempView setFrame:CGRectMake(0, 68, 320, [[UIScreen mainScreen]bounds].size.height)];

        
            [self.m_scrollerView setFrame:CGRectMake(0, 68, 320, [[UIScreen mainScreen]bounds].size.height)];

        }
        
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
        label.backgroundColor = [UIColor blackColor];
        
        [self.view addSubview:label];
        
    }else{
        
        [self.m_titleView setFrame:CGRectMake(0, 0, 320, 48)];
        
        [self.m_tempView setFrame:CGRectMake(0, 48, 320, self.view.frame.size.height - 48)];

        [self.m_scrollerView setFrame:CGRectMake(0, 48, 320, self.view.frame.size.height - 48)];

    }
    
    
    
    self.m_imageView.layer.cornerRadius = 30.0f;
    self.m_imageView.layer.masksToBounds = YES;
    
    [self.m_scrollerView setContentSize:CGSizeMake(320, 500)];
    
    self.m_scrollerView.hidden = YES;
    
    self.m_emptyLabel.hidden = YES;
    
    
    // 券券请求数据验证结果
    [self quanquanSureRequest];
    
}


- (void)quanquanSureRequest{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    // 刷新请求数据接口
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId, @"cashierAccountId",
                                key,@"key",
                                [NSString stringWithFormat:@"%@",self.m_quanquanString],@"keyCode",nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    NSLog(@"params = %@",parameters);
    
    [requstClient request:CDHTTPRequestQuanquanKeyValidate parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        QuanquanData *keyData = [[QuanquanData alloc]initWithJsonObject:handlJson];
        
        BOOL success = [keyData.status boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            self.m_scrollerView.hidden = NO;
            
            self.m_emptyLabel.hidden = YES;

            
            // 赋值
            self.m_title.text = [NSString stringWithFormat:@"%@",keyData.Title];
            
            self.m_desprition.text = [NSString stringWithFormat:@"%@",keyData.Description];
            
            self.m_allName.text = [NSString stringWithFormat:@"%@",keyData.AllName];
            
            self.m_time.text = [NSString stringWithFormat:@"有效期：%@-%@",keyData.MinDateTime,keyData.MaxDateTime];
            
            
            NSMutableArray *shopList = [[NSMutableArray alloc]initWithCapacity:0];
        
            [shopList addObjectsFromArray:keyData.VouMctShopList];
            
            // 可使用的店铺
            if ( shopList.count != 0 ) {
                
                NSString *nameString = @"";
                
                for (int i = 0; i < shopList.count; i++) {
                    
                    QuanquanShopData *shopData = (QuanquanShopData *)[shopList objectAtIndex:i];
                    
                    NSString *name = [NSString stringWithFormat:@"%@",shopData.MctShopName];
                    
                    // 赋值
                    if ( i != shopList.count - 1 ) {
                        
                        nameString = [nameString stringByAppendingString:[NSString stringWithFormat:@"%@,",name]];
                        
                    }else{
                        
                        nameString = [nameString stringByAppendingString:[NSString stringWithFormat:@"%@",name]];
                        
                    }
                    
                    self.m_shopName.text = [NSString stringWithFormat:@"可使用店铺:%@",nameString];
                    
                }
                
            }else{
                
                self.m_shopName.text = @"";
                
            }
            
            // 对券券码进行赋值
            NSString *KeyValue = [NSString stringWithFormat:@"%@",keyData.KeyValue];
           
            // 赋值用于确认收银请求参数
            self.m_keyValue = [NSString stringWithFormat:@"%@",KeyValue];
            
            self.m_code.text = [NSString stringWithFormat:@"%@",KeyValue];
            
            // 对券券码进行生成二维码，用于收银台页面的扫描
            UIImage *codeImage = [QRCodeGenerator qrImageForString:KeyValue imageSize:self.m_codeImgV.frame.size.width];
            [self.m_codeImgV setImage:codeImage];
            
            // 图片进行赋值
            NSString *headImage = [NSString stringWithFormat:@"%@",keyData.LogoMidUrl];
            UIImage *reSizeImage = [imagechage getImage:headImage];
            if (reSizeImage != nil)
            {
                self.m_imageView.image = [CommonUtil scaleImage:reSizeImage toSize:CGSizeMake(60, 60)];
            }
            else{
                
                [self.m_imageView setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:headImage]]
                                        placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                                 success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                                     
                                                     self.m_imageView.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                                                     
                                                 }
                                                 failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                                     
                                                 }];
            }
            
            
            
            
            
            
        }else
        {
            
            [SVProgressHUD showErrorWithStatus:keyData.msg];
            
            
            self.m_emptyLabel.hidden = NO;
            
            self.m_emptyLabel.text = [NSString stringWithFormat:@"%@",keyData.msg];
            
//            // 返回上一级
//            [self goback:nil];
//            
            
        }
    } failured:^(NSError* error)
     {
         NSLog(@"error:%@",error.description);
         
         [SVProgressHUD showErrorWithStatus:error.description];
     }];
    
}



- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goback:(id)sender {
    
    [self goBack];
    
}

- (IBAction)confirmClicked:(id)sender {
    
    // 确认收银请求网络
    [self requestSubmit];
    
}

// 请求数据
- (void)requestSubmit{
   
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    NSLog(@"%@,%@",[CommonUtil getValueByKey:MEMBER_ID],[CommonUtil getServerKey]);
    
    // 刷新请求数据接口
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId, @"cashierAccountId",
                                key,@"key",
                                self.m_keyValue,@"keyCode",nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    NSLog(@"parms = %@",parameters);
    
    [requstClient request:CDHTTPRequestQuanquanKeyConfirm parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        BaseRetData *Data = [[BaseRetData alloc]initWithJsonObject:handlJson];
        
        NSLog(@"json = %@",json);
        
        BOOL success = [Data.status boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            // 收银成功后返回上两个页面
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示"
                                                               message:Data.msg
                                                              delegate:self
                                                     cancelButtonTitle:@"确定"
                                                     otherButtonTitles: nil];
            alertView.tag = 1000;
            
            [alertView show];
            
        }else
        {
            
            [SVProgressHUD showErrorWithStatus:Data.msg];
            
        }
    } failured:^(NSError* error)
     {
         NSLog(@"error:%@",error.description);
         
         [SVProgressHUD showErrorWithStatus:error.description];
     }];
    
    
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 1000 ) {
        
        if ( buttonIndex == 0 ) {
            
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count] - 3] animated:YES];
        }
    }
}


@end
