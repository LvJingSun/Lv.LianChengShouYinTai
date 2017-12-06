//
//  AppDelegate.m
//  CashierDeskIphone
//
//  Created by mac on 13-8-27.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "AppDelegate.h"
#import "AppInitViewController.h"
#import "CommonUtil.h"
#import "HttpClientRequest.h"
#import "SVProgressHUD.h"
#import "Reachability.h"
#import "JPUSHService.h"
#import <AudioUnit/AudioUnit.h>
#import <AVFoundation/AVFoundation.h>
#import "RowNumberController.h"
#import "AppHttpClient.h"
#import "XWAlterview.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    //推送
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert) categories:nil];
        
    }else {
        
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert) categories:nil];
        
    }
    
    [JPUSHService setBadge:0];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"PushConfig" ofType:@"plist"];
    
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    [JPUSHService setupWithOption:launchOptions appKey:[dic objectForKey:@"APP_KEY"] channel:[dic objectForKey:@"CHANNEL"] apsForProduction:[[dic objectForKey:@"APS_FOR_PRODUCTION"] boolValue]advertisingIdentifier:nil];
    
    //没有运行的情况下接收消息
    if (launchOptions) {
        
        NSDictionary *remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        
        if (remoteNotification) {

        }
    }
    
    //
    self.m_isFirst = YES;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        
        // 设置状态栏的颜色
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    }else{
        
        // 设置状态栏的颜色
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;

    }
    
    // 设置状态栏是否隐藏
    [[UIApplication sharedApplication]setStatusBarHidden:YES];
    

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    AppInitViewController* startController = [[AppInitViewController alloc]initWithNibName:@"AppInitViewController" bundle:nil];
    _nav = [[UINavigationController alloc]initWithRootViewController:startController];
    _nav.delegate = self;
    self.window.rootViewController = self.nav;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    [[NSUserDefaults standardUserDefaults] setObject:[JPUSHService registrationID] forKey:@"registrationID"];
    
//    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
//
//    NSString *memberId = [userDefau objectForKey:@"memberId"];
//
//    AppHttpClient* httpClient = [AppHttpClient sharedClient];
//    NSDictionary *param1 = [NSDictionary dictionaryWithObjectsAndKeys:
//                            memberId, @"memberID",
//                            @"PhoneType_1",@"phoneType",
//                            [JPUSHService registrationID],@"registrationID",
//                            nil];
//
//    [httpClient request:@"ErpMerchantCenterAdd.ashx" parameters:param1 success:^(NSJSONSerialization* json){
//
//    }failure:^(NSError *error){
//
//    }];
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {

    //接收苹果服务器返回的token并将其发送给极光服务器
    [JPUSHService registerDeviceToken:deviceToken];
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {

    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
    //    NSInteger badge = [[aps valueForKey:@"badge"] integerValue];
    //    NSString *sound = [aps valueForKey:@"sound"]; //播放的声音
    // 取得自定义字段内容，userInfo就是后台返回的JSON数据，是一个字典
    [JPUSHService handleRemoteNotification:userInfo];
    
    if (application.applicationState == UIApplicationStateActive) {
        
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"tishiyin.caf" withExtension:nil];
        
        SystemSoundID soundID = 0;
        
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &soundID);
        
        AudioServicesPlaySystemSound(soundID);
        
    }
    
    application.applicationIconBadgeNumber = 0;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:content delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    alert.tag = 1111;
    
    [alert show];
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {

    [application registerForRemoteNotifications];
    
}

- (void)goToMssageViewController{
    //将字段存入本地，因为要在你要跳转的页面用它来判断,这里我只介绍跳转一个页面，
    NSUserDefaults *pushJudge = [NSUserDefaults standardUserDefaults];
    [pushJudge setObject:@"push" forKey:@"push"];
    [pushJudge synchronize];
    
    RowNumberController * VC = [[RowNumberController alloc]init];
    UINavigationController * Nav = [[UINavigationController alloc]initWithRootViewController:VC];//这里加导航栏是因为我跳转的页面带导航栏，如果跳转的页面不带导航，那这句话请省去。
    [self.window.rootViewController presentViewController:Nav animated:YES completion:nil];
    
}

- (void)applicationWillResignActive:(UIApplication *)application{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([viewController isKindOfClass:[AppInitViewController class]]) {
        navigationController.navigationBarHidden = YES;
    }
}


// 判断网络不好
- (BOOL)isConnectionAvailable{
    
    BOOL  isExistenceNetWork = YES;
    
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    
    switch ( [reach currentReachabilityStatus] ) {
        case NotReachable:
            isExistenceNetWork = NO;
            break;
        case ReachableViaWiFi:
            isExistenceNetWork = YES;
            break;
        case ReachableViaWWAN:
            isExistenceNetWork = YES;
            break;
            
        default:
            break;
    }
    
    if ( !isExistenceNetWork ) {
        
        [SVProgressHUD showErrorWithStatus:@"网络不给力，请稍后再试！"];
        
    }
    
    
    return isExistenceNetWork;
    
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
        
    if (buttonIndex == 1) {
        
        [self goToMssageViewController];
        
    }

}


@end
