//
//  RootViewController.m
//  CashierDeskIphone
//
//  Created by mac on 13-9-8.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "RootViewController.h"
#import "Configuration.h"
#import "ImageResource.h"
#import "MoreViewController.h"
#import "ConsoleViewController.h"
#import "RecordsViewController.h"
#import "NotificationViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppHttpClient.h"
#import "XWAlterview.h"

#import "N_HomeViewController.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        UIImage *img1 = [self getImage:menuiconseconsole];
        UIImage *img11 = [self getImage:menuicondefconsole];
        
        
        UITabBarItem* itemOne = [[UITabBarItem alloc]initWithTitle:@"收银台" image:nil tag:100];
        [itemOne setFinishedSelectedImage:img1 withFinishedUnselectedImage:img11];
       
//        ConsoleViewController* console = [[ConsoleViewController alloc]initWithNibName:@"ConsoleViewController" bundle:nil];
        
        N_HomeViewController *console = [[N_HomeViewController alloc] init];
        
        [console setTabBarItem:itemOne];
        
        
        UIImage *img2 = [self getImage:menuiconserecord];
        UIImage *img22 = [self getImage:menuicondefrecord];
        
        UITabBarItem* itemTwo = [[UITabBarItem alloc]initWithTitle:@"收银记录" image:nil tag:101];
        [itemTwo setFinishedSelectedImage:img2 withFinishedUnselectedImage:img22];
        RecordsViewController* records = [[RecordsViewController alloc]initWithNibName:@"RecordsViewController" bundle:nil];
        [records setTabBarItem:itemTwo];
        
        
        UIImage *img3 = [self getImage:menuiconseannouncement];
        UIImage *img33 = [self getImage:menuicondefannouncement];
        
        UITabBarItem* itemThree = [[UITabBarItem alloc]initWithTitle:@"通知" image:nil tag:102];
        [itemThree setFinishedSelectedImage:img3 withFinishedUnselectedImage:img33];
        NotificationViewController* notification = [[NotificationViewController alloc]initWithNibName:@"NotificationViewController" bundle:nil];
        [notification setTabBarItem:itemThree];
        
        
        UIImage *img4 = [self getImage:menuiconsemore];
        UIImage *img44 = [self getImage:menuicondefmore];
        
        
        UITabBarItem* itemFour = [[UITabBarItem alloc]initWithTitle:@"更多" image:nil tag:103];
        [itemFour setFinishedSelectedImage:img4 withFinishedUnselectedImage:img44];
        MoreViewController* controller = [[MoreViewController alloc]initWithNibName:@"MoreViewController" bundle:nil];
        [controller setTabBarItem:itemFour];
        
        [self setViewControllers:[NSArray arrayWithObjects:console,records,notification,controller, nil] animated:YES];
//        [self.tabBar.layer setBorderColor:[UIColor redColor].CGColor];
//        [self.tabBar.layer setBorderWidth:1.0f];
        
        //图片高度必须为49 2x为98;
        self.tabBar.selectionIndicatorImage = [UIImage imageNamed:tabbarItembghighImg]; //CreatImageByUrl(tabbarItembghighImg);
        self.tabBar.backgroundImage = [UIImage imageNamed:tabbarItembgNormalImg]; //CreatImageByUrl(tabbarItembgNormalImg);
        
        // 设置tabBar上的字体的颜色
        NSArray* items = self.tabBar.items;
        for (UITabBarItem* item in items) {
            [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],UITextAttributeTextColor, nil] forState:UIControlStateNormal];
            [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],UITextAttributeTextColor, nil] forState:UIControlStateSelected];
        }
        
    }
    return self;
}

- (UIImage *)getImage:(NSString *)aimagName{
    
    UIImage* selectedImage = [UIImage imageNamed:aimagName];
    
    // 判断在8以上的版本不添加渲染使用原图
    if ( isIOS8 ) {
        
        //声明这张图片用原图(别渲染)
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
    }
    
    
    return selectedImage;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;

    
    self.delegate = self;
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated {

    [self versionRequest];
        
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.navigationController.navigationBarHidden = YES;
    
}

//版本检测
- (void)versionRequest{
    
    //当前版本信息
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    
    NSError *error;
    
    NSString *urlstr = [NSString stringWithFormat:@"https:itunes.apple.com/lookup?id=717895910"];
    
    NSURL *url = [NSURL URLWithString:urlstr];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    
    if (error) {
        
    }
    
    NSArray *array = [dic objectForKey:@"results"];
    
    if (![array count]) {
        
    }
    
    NSDictionary *infodic = [array objectAtIndex:0];
    
    NSString *appstoreVersion = [infodic objectForKey:@"version"];
    
    //下载链接
    NSString *downLoad = [infodic objectForKey:@"trackViewUrl"];
    
//    double demoVersion = [version doubleValue];
//    
//    double newVersion = [appstoreVersion doubleValue];
    
    if ([self CompareDemoVersion:version WithAppStoreVersion:appstoreVersion]) {
        
//        XWAlterview *alert = [[XWAlterview alloc] initWithIcon:@"icon_120.png" Content:@"收银台新版本发布啦！功能更加优化，体验更棒！" Title:@"版本更新" Cancle:@"稍后再说" Sure:@"立即下载"];
        
        XWAlterview *alert = [[XWAlterview alloc] initWithIcon:@"icon_120.png" Content:@"收银台新版本发布啦！功能更加优化，体验更棒！" Title:@"版本更新" Sure:@"立即下载"];
        
        alert.rightBlock = ^(){
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:downLoad]];
            
        };
        
        [alert show];
        
    }
    
}

- (BOOL)CompareDemoVersion:(NSString *)demoVersion WithAppStoreVersion:(NSString *)appstoreVersion {
    
    NSMutableArray *demoArr = [NSMutableArray arrayWithArray:[demoVersion componentsSeparatedByString:@"."]];
    
    NSMutableArray *appstoreArr = [NSMutableArray arrayWithArray:[appstoreVersion componentsSeparatedByString:@"."]];
    
    // 补全版本信息为相同位数
    while (demoArr.count < appstoreArr.count) {
        
        [demoArr addObject:@"0"];
        
    }
    while (appstoreArr.count < demoArr.count) {
        
        [appstoreArr addObject:@"0"];
        
    }
    
    BOOL compareResutl = NO;
    
    for(NSUInteger i = 0; i < demoArr.count; i++){
        
        NSInteger versionNumber1 = [demoArr[i] integerValue];
        
        NSInteger versionNumber2 = [appstoreArr[i] integerValue];
        
        if (versionNumber1 < versionNumber2) {
            
            compareResutl = YES;
            
            break;
            
        }else if (versionNumber2 < versionNumber1){
            
            compareResutl = NO;
            
            break;
            
        }else{
            
            compareResutl = NO;
            
        }
        
    }
    
    return compareResutl;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
