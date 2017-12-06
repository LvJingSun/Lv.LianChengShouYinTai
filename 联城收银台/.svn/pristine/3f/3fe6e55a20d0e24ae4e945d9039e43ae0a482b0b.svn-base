//
//  NotificationViewController.m
//  CashierDeskIphone
//
//  Created by mac on 13-9-8.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "NotificationViewController.h"

#import "NotificationCell.h"

#import "NotificationDetailViewController.h"

#import "NotificationData.h"

#import "AppDelegate.h"


@interface NotificationViewController ()

@end

@implementation NotificationViewController

@synthesize m_array;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_array = [[NSMutableArray alloc]initWithCapacity:0];
        
        self.isFirst = YES;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 版本判断
    if ( isIOS7 ) {
                
        if ( iPhone5 ) {
                        
            [self.m_tableView setFrame:CGRectMake(0, 20, 320, [[UIScreen mainScreen]bounds].size.height - 40)];
        }else{
            
            
            [self.m_tableView setFrame:CGRectMake(0, 20, 320, self.view.frame.size.height - 20)];
        }

        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
        label.backgroundColor = [UIColor blackColor];
        
        [self.view addSubview:label];
        
        
    }else{
                
        if ( iPhone5 ) {
                        
            [self.m_tableView setFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height - 20)];
            
        }else{
                        
            [self.m_tableView setFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height + 68)];
        }
             
    }
    
    // 隐藏控件
    self.m_tableView.hidden = YES;
    self.m_emptyLabel.hidden = YES;
   
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear: animated];
    
    self.navigationController.navigationBar.translucent = NO;
    
    // 请求数据
    [self requestSubmit];
    
 
    if ( self.isFirst ) {
        
        self.isFirst = NO;
        
        // 版本判断
        if ( isIOS7 ) {
            
            if ( iPhone5 ) {
                
                [self.m_tableView setFrame:CGRectMake(0, 20, 320, [[UIScreen mainScreen]bounds].size.height - 40)];
            }else{
                
                
                [self.m_tableView setFrame:CGRectMake(0, 20, 320, self.view.frame.size.height - 20)];
            }
            
        }else{
            
            
            if ( iPhone5 ) {
                
                [self.m_tableView setFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height - 20)];
                
            }else{
                
                [self.m_tableView setFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height + 68)];
            }
            
        }
        
    }else{
        
        // 版本判断
        if ( isIOS7 ) {
            
            if ( iPhone5 ) {
                
                [self.m_tableView setFrame:CGRectMake(0, 0, 320, [[UIScreen mainScreen]bounds].size.height - 40)];
            }else{
                
                
                [self.m_tableView setFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
            }
            
        }else{
                        
            if ( iPhone5 ) {
                
                [self.m_tableView setFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height)];
                
            }else{
                
                [self.m_tableView setFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height + 68)];
            }
            
        }
    }
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    
    [self setM_emptyLabel:nil];
    [super viewDidUnload];
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
                                key,@"key",nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [requstClient request:CDHTTPRequestNotificationList parameters:parameters successed:^(JSONDecoder*json,id responseObject){
            
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
       
        NotificationData *notifationData = [[NotificationData alloc]initWithJsonObject:handlJson];
                
        BOOL success = [notifationData.status boolValue];
        
        if (success) {
            
            [self.m_array removeAllObjects];
                        
            [self.m_array addObjectsFromArray:notifationData.noticeList];
            
            // 判断数组是否为空
            if ( self.m_array.count != 0 ) {
                
                self.m_tableView.hidden = NO;
                
                self.m_emptyLabel.hidden = YES;
                
            }else{
                
                self.m_tableView.hidden = YES;
                
                self.m_emptyLabel.hidden = NO;
            }
            
            [self.m_tableView reloadData];
            
            [SVProgressHUD dismiss];
            
        }else
        {
            
            [SVProgressHUD showErrorWithStatus:notifationData.msg];
            
        }
    } failured:^(NSError* error)
     {
         NSLog(@"error:%@",error.description);
         
         [SVProgressHUD showErrorWithStatus:error.description];
     }];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
   return [self.m_array count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"NotificellIdentifier";
    
    NotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
         NSArray* bundles = [[NSBundle mainBundle]loadNibNamed:@"NotificationCell" owner:self options:nil];

         cell = (NotificationCell *)[bundles objectAtIndex:0];
    

        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    if ( self.m_array.count != 0 ) {
        
        NoticeData *data = (NoticeData *)[self.m_array objectAtIndex:indexPath.row];
        // 赋值
        cell.m_titleLabel.text = [NSString stringWithFormat:@"%@",data.Title];
        
        cell.m_timeLabel.text = [NSString stringWithFormat:@"%@",data.ModifyDate];
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NoticeData *data = (NoticeData *)[self.m_array objectAtIndex:indexPath.row];
    
    NotificationDetailViewController *VC = [[NotificationDetailViewController alloc]initWithNibName:@"NotificationDetailViewController" bundle:nil];
    
    VC.m_noticeId = data.NoticeId;
    [self.navigationController pushViewController:VC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70.0f;
}


@end
