//
//  AppInitViewController.m
//  CashierDeskIphone
//
//  Created by mac on 13-8-27.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "AppInitViewController.h"
#import "Configuration.h"
#import "LoginViewController.h"

@interface AppInitViewController ()


@property (weak, nonatomic) IBOutlet UIImageView *m_imageView;

@end

@implementation AppInitViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
        
    [self performSelector:@selector(pushLoginController) withObject:nil afterDelay:2.0f];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationController.navigationBar.translucent = NO;
  
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    // 当前页面不显示状态栏，离开后显示状态栏
    [[UIApplication sharedApplication]setStatusBarHidden:NO];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushLoginController
{
    LoginViewController* login = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    [self.navigationController pushViewController:login animated:YES];
}

@end
