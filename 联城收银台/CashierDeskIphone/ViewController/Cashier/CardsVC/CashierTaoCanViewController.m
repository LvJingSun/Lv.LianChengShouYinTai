//
//  CashierTaoCanViewController.m
//  CashierDeskIphone
//
//  Created by mac on 15-6-9.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "CashierTaoCanViewController.h"

#import "BCloundMenuTableViewCell.h"

@interface CashierTaoCanViewController ()

@property (weak, nonatomic) IBOutlet UIView *m_titleView;
@property (weak, nonatomic) IBOutlet UIView *m_tempView;


- (IBAction)backLastView:(id)sender;

- (IBAction)sureClicked:(id)sender;

@end

@implementation CashierTaoCanViewController

@synthesize m_taocanArray;

@synthesize m_dic;

@synthesize m_phoneString;

@synthesize m_flagDic;

@synthesize m_ordersId;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_taocanArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_dic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        m_flagDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 版本判断
    if ( isIOS7 ) {
        
        [self.m_titleView setFrame:CGRectMake(0, 20, 320, 48)];
        
        if ( iPhone5 ) {
            
            NSLog(@"heigh3 = %f",[[UIScreen mainScreen]bounds].size.height - 50);

            [self.m_tempView setFrame:CGRectMake(0, 68, 320, [[UIScreen mainScreen]bounds].size.height - 20 - 48 - 50)];
            
        }else{
            
            if ( iPhone4 ) {
                
                [self.m_tempView setFrame:CGRectMake(0, 68, 320, [[UIScreen mainScreen]bounds].size.height - 48 - 20 - 50)];

            }else{
                
                [self.m_tempView setFrame:CGRectMake(0, 68, 320, [[UIScreen mainScreen]bounds].size.height - 48 - 50)];

            }
            
        }
        
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
        label.backgroundColor = [UIColor blackColor];
        
        [self.view addSubview:label];
        
    }else{
        
        [self.m_titleView setFrame:CGRectMake(0, 0, 320, 48)];
        
        [self.m_tempView setFrame:CGRectMake(0, 48, 320, self.view.frame.size.height - 48 - 50)];
        
    }
    
    [self.m_buttomView setFrame:CGRectMake(0, [[UIScreen mainScreen]bounds].size.height - 50, WindowSizeWidth, 50)];

    self.m_emptyLabel.hidden = YES;
    self.m_tableView.hidden = YES;
    self.m_buttomView.hidden = YES;
    
    // 初始化tableView
    [self reloadTableView];
    
    // 请求数据
    [self menuListRequestSubmit];

    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backLastView:(id)sender {
    
    [self goBack];
    
}

- (IBAction)sureClicked:(id)sender {
    
    NSString *string = @"";
    
    for (int i = 0; i < self.m_flagDic.count; i++) {
        
        NSMutableDictionary *dic = [self.m_flagDic objectForKey:[NSNumber numberWithInt:i]];
        
        if ( dic.count != 0 ) {
            
            NSString *amout = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Amount"]];
            
            NSString *menuId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"CloudMenuOrderDetailId"]];
            
            NSString *l_string = @"";
            
            if ( ![amout isEqualToString:@"0"] ) {
                
                // 拼接成json字符
                // l_string = [self dictionaryToJson:self.m_flagDic];
                
                l_string = [NSString stringWithFormat:@"{\"CloudMenuOrderDetailId\":\"%@\",\"Amount\":\"%@\"},",menuId,amout];
                
                
            }
            
            string = [string stringByAppendingString:l_string];
            
            
        }
      
    
    }

    if ( string.length != 0) {

        // 设置拼接的字符串
        string = [string substringWithRange:NSMakeRange(0, string.length - 1)];
        
        self.m_ordersId = [NSString stringWithFormat:@"\{\"orderlist\":[%@]}",string];

        
    }else{
        
        [SVProgressHUD showErrorWithStatus:@"请选择要使用的产品"];
        
        return;
        
    }
    
    
    NSLog(@"m_ordersId = %@",self.m_ordersId);

    
    
    // 请求数据
    [self uesedMenuRequest];


   

}

- (void)uesedMenuRequest{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    // 刷新请求数据接口
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId, @"cashierAccountID",
                                key,@"key",
                                [NSString stringWithFormat:@"%@",self.m_ordersId],@"orders",nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [requstClient request:@"UseOrderDetail.ashx" parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
           
            
            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(backLastView) userInfo:nil repeats:NO];
            
            
        }else
        {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
        }
        
    } failured:^(NSError* error)
     {
         
         [SVProgressHUD showErrorWithStatus:error.description];
     }];
    
    
}

- (void)backLastView{
    
    [self goBack];
    
}

- (void)reloadTableView{
    
    [self.m_tableView initTableViewDataSourceAndDelegate:^NSInteger(UITableView *tableView,NSInteger section)
     {
         return self.m_taocanArray.count;
         
     } setCellForIndexPathBlock:^UITableViewCell *(UITableView *tableView,NSIndexPath *indexPath)
     {
         
         BCloundMenuTaocanCell *cell=[tableView dequeueReusableCellWithIdentifier:@"BCloundMenuTaocanCellIdentifier"];
         
         if ( !cell )
         {
             cell = [[[NSBundle mainBundle]loadNibNamed:@"BCloundMenuTableViewCell" owner:self options:nil]objectAtIndex:2];
             [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
             
         }
         if ( self.m_taocanArray.count != 0 ) {
             
             NSDictionary *dic = [self.m_taocanArray objectAtIndex:indexPath.row];
             
             cell.m_labelname.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MenuName"]];
             
             cell.m_labelpice.text = [NSString stringWithFormat:@"%@元",[dic objectForKey:@"MenuPrice"]];

             [cell setImagePath:[dic objectForKey:@"MenuImage"]];
             
             cell.m_usedCount.text = [NSString stringWithFormat:@"已用%@份 剩余%@份 总共%@份",[dic objectForKey:@"UsedAmount"],[dic objectForKey:@"SyAmount"],[dic objectForKey:@"MenuAmount"]];
             
             cell.m_time.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"CreateDate"]];
             
         }
         
         NSMutableDictionary *dic = [self.m_flagDic objectForKey:[NSNumber numberWithInt:indexPath.row]];
         
         NSString *Istring = [dic objectForKey:@"Amount"];
         
         if ((!Istring) ||([Istring isEqualToString:@"0"])) {
             
             cell.m_Btnjian.hidden = cell.m_Btnnum.hidden = YES;
             
             // 设置加号的颜色
//             [cell.m_Btnjia.titleLabel setTextColor:[UIColor darkGrayColor]];
//             
//             [cell.m_Btnjia.layer setBorderColor:[UIColor darkGrayColor].CGColor];//边框颜色
             
         }else
             
         {
             cell.m_Btnjian.hidden = cell.m_Btnnum.hidden = NO;
             
             [cell.m_Btnnum setTitle:[NSString stringWithFormat:@"%@",Istring] forState:UIControlStateNormal];
             // 设置加号的颜色
//             [cell.m_Btnjia.titleLabel setTextColor:[UIColor redColor]];
//             
//             [cell.m_Btnjia.layer setBorderColor:[UIColor redColor].CGColor];//边框颜色
             
         }

         
         
         cell.m_Btnjia.tag = indexPath.row;
         cell.m_Btnjian.tag = indexPath.row;

         [cell.m_Btnjia addTarget:self action:@selector(Addnum:) forControlEvents:UIControlEventTouchUpInside];
         
         [cell.m_Btnjian addTarget:self action:@selector(Jiannum:) forControlEvents:UIControlEventTouchUpInside];
         
         
         return cell;
         
         
     } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         
         
     }];
    
    [self.m_tableView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.m_tableView.layer setBorderWidth:0];
    
    
}

- (void)Addnum:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    
    NSMutableDictionary *dic = [self.m_flagDic objectForKey:[NSNumber numberWithInt:btn.tag]];

    NSString *Istring = [dic objectForKey:@"Amount"];
    
    // 将选择的菜单的值记录到字典里面
    NSMutableDictionary *dic1 = [self.m_taocanArray objectAtIndex:btn.tag];
    
    int nownum;

    if ((!Istring) ||([Istring isEqualToString:@"0"])) {
        
        nownum = 1;
        
    }else{
        
        NSString *num = [NSString stringWithFormat:@"%@",Istring];
        
        nownum = [num intValue]+1;
        
        
        // 判断选择的使用份数不能超过剩余的份数
        NSString *syCount = [NSString stringWithFormat:@"%@",[dic1 objectForKey:@"SyAmount"]];
        
        if ( nownum > [syCount intValue] ) {
            
            // 个数不能超过剩余的份数
            [SVProgressHUD showErrorWithStatus:@"使用份数不能超过剩余的份数"];
            
            nownum = [syCount intValue];
            
        }
        
    }
    
    
    [dic setObject:[dic1 objectForKey:@"CloudMenuOrderDetailID"] forKey:@"CloudMenuOrderDetailId"];
    [dic setObject:[NSString stringWithFormat:@"%d",nownum] forKey:@"Amount"];
    
    // 刷新左边的tableView
    NSArray *arr = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:btn.tag inSection:0], nil];
    
    [self.m_tableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];
    
}

- (void)Jiannum:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    NSMutableDictionary *dic = [self.m_flagDic objectForKey:[NSNumber numberWithInt:btn.tag]];

    NSString *Istring = [dic objectForKey:@"Amount"];

    int nownum;
    
    if ((!Istring) ||([Istring isEqualToString:@"0"])) {
        
        nownum = 0;

    }else{
        
        NSString *num = [NSString stringWithFormat:@"%@",Istring];
        
        nownum = [num intValue] - 1;
        
    }
    
    NSMutableDictionary *dic1 = [self.m_taocanArray objectAtIndex:btn.tag];
    
    [dic setObject:[dic1 objectForKey:@"CloudMenuOrderDetailID"] forKey:@"CloudMenuOrderDetailId"];
    [dic setObject:[NSString stringWithFormat:@"%d",nownum] forKey:@"Amount"];
    
    // 刷新左边的tableView
    NSArray *arr = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:btn.tag inSection:0], nil];
    
    [self.m_tableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];
    
}

- (void)menuListRequestSubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    // 刷新请求数据接口
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId, @"cashierAccountID",
                                key,@"key",
                                [NSString stringWithFormat:@"%@",self.m_phoneString],@"account",nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [requstClient request:@"GetOrderDetail.ashx" parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            
            NSLog(@"json = %@",handlJson);
            
            [SVProgressHUD dismiss];
            
            self.m_taocanArray = [handlJson valueForKey:@"orderList"];
            
            if ( self.m_taocanArray.count != 0 ) {
                
                self.m_emptyLabel.hidden = YES;
                self.m_tableView.hidden = NO;
                self.m_buttomView.hidden = NO;
                
                [self.m_tableView reloadData];
                
                // 标记值的字典-每个类别里面有不同的选择的一个set
                for (int i = 0; i < self.m_taocanArray.count; i++) {
                    
                    [self.m_flagDic setObject:[NSMutableDictionary dictionary] forKey:[NSNumber numberWithInt:i]];
                }

            }else{
                
                self.m_emptyLabel.hidden = NO;
                self.m_tableView.hidden = YES;
                self.m_buttomView.hidden = YES;
                
                self.m_emptyLabel.text = @"您暂时没有未使用的产品";
                
            }
            
        }else
        {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
        }
        
    } failured:^(NSError* error)
     {
         
         [SVProgressHUD showErrorWithStatus:error.description];
     }];
  
}



@end
