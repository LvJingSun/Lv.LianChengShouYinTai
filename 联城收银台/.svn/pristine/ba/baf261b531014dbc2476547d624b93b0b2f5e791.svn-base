//
//  BaseViewController.m
//  CashierDeskIphone
//
//  Created by mac on 13-8-30.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"

#import "Reachability.h"

@interface BaseViewController ()

@property(nonatomic,strong) UIScrollView* rootScrollView;

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
  
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    // 设置view的背景颜色
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_background.png"]];
    
    self.needHiddenDone = YES;
    keyboardShow = NO;
    self.rootScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
   
    
    self.navigationController.navigationBar.translucent = NO;
   
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
//     [super viewDidAppear:animated];
}


- (void)viewDidDisappear:(BOOL)animated {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleKeyboardWillHide:(NSNotification *)notification
{
    if (self.doneInKeyboardButton.superview)
    {
        [self.doneInKeyboardButton removeFromSuperview];
    }
    if (!keyboardShow) {
        return;
    }
    if (self.rootScrollView != nil) {
        NSDictionary *info = [notification userInfo];
        NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
        CGSize keybroundSize = [value CGRectValue].size;
        CGRect viewFrame = [self.rootScrollView frame];
        viewFrame.size.height += keybroundSize.height;
        self.rootScrollView.frame = viewFrame;
    }
    keyboardShow = NO;
}

- (void)handleKeyboardDidShow:(NSNotification *)notification
{
    // create custom button
    if (self.doneInKeyboardButton == nil)
    {
        self.doneInKeyboardButton = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
        if (screenHeight==568.0f) {//爱疯5
            self.doneInKeyboardButton.frame = CGRectMake(0, 568 - 53, 106, 53);
        } else {//3.5寸
            self.doneInKeyboardButton.frame = CGRectMake(0, 480 - 53, 106, 53);
        }
        self.doneInKeyboardButton.adjustsImageWhenHighlighted = NO;
        self.doneInKeyboardButton.hidden=self.needHiddenDone;
        [self.doneInKeyboardButton setImage:[UIImage imageNamed:@"btn_done_up.png"] forState:UIControlStateNormal];
        [self.doneInKeyboardButton setImage:[UIImage imageNamed:@"btn_done_down.png"] forState:UIControlStateHighlighted];
        [self.doneInKeyboardButton addTarget:self action:@selector(finishAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    // locate keyboard view
    UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
    if (self.doneInKeyboardButton.superview == nil)
    {
        [tempWindow addSubview:self.doneInKeyboardButton];    // 注意这里直接加到window上
    }
    self.doneInKeyboardButton.hidden=self.needHiddenDone;
    if (keyboardShow) {
        return;
    }
    if (self.rootScrollView != nil) {
        NSDictionary *info = [notification userInfo];
        NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
        CGSize keybroundSize = [value CGRectValue].size;
        CGRect viewFrame = [self.rootScrollView frame];
        viewFrame.size.height -= keybroundSize.height;
        self.rootScrollView.frame = viewFrame;
        //[self performSelector:@selector(moveToActiveView) withObject:nil afterDelay:0.5];
        [self moveToActiveView];
    }
    keyboardShow = YES;
}

- (void)moveToActiveView {
    if (self.activeField != nil) {
        //CGRect textFieldRect = [self.activeField frame];
        CGRect textFieldRect = [self.activeField.superview frame];
        //NSLog(@"(%.0f,%.0f,%.0f,%.0f,)", textFieldRect.origin.x, textFieldRect.origin.y, textFieldRect.size.width, textFieldRect.size.height);
        [self.rootScrollView scrollRectToVisible:textFieldRect animated:YES];
    }
}

//隐藏键盘的方法
-(void)hidenKeyboard {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];//关闭键盘
}

- (void)finishAction
{
    [self hidenKeyboard];
}

- (IBAction)showNumberPadKeyboard:(id)sender
{
    self.needHiddenDone = NO;
    self.doneInKeyboardButton.hidden = self.needHiddenDone;
}

- (IBAction)hideNumberPadKeyboard:(id)sender
{
    self.needHiddenDone = YES;
    self.doneInKeyboardButton.hidden = self.needHiddenDone;
}

- (void)goBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) hideGradientBackground:(UIView*)theView
{
    for (UIView * subview in theView.subviews)
    {
        if ([subview isKindOfClass:[UIImageView class]])
            subview.hidden = YES;
        
        [self hideGradientBackground:subview];
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
        
        [SVProgressHUD showErrorWithStatus:@"网络已断开,请检查网络！"];
        
    }
    
    
    return isExistenceNetWork;
    
}



@end
