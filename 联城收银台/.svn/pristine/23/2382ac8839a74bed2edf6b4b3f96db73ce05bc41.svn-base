//
//  BCloundMenuViewController.m
//  CashierDeskIphone
//
//  Created by 冯海强 on 15-5-22.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "BCloundMenuViewController.h"
#import "BCloundMenuTableViewCell.h"

@interface BCloundMenuViewController ()
{
    CGFloat Viewheight;
    NSInteger SelectLeft;
    NSInteger SelectRight;
    
    NSString *CloudMenuClass;
}
@property(nonatomic,strong) NSMutableArray * BCMLeftArray;
@property(nonatomic,strong) NSMutableArray * BCMRightArray;

//@property(nonatomic,strong) NSMutableDictionary * BCMLeftDic;
@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;

@end

@implementation BCloundMenuViewController
@synthesize BCMLeftTableview;
@synthesize BCMRightTableview;

@synthesize m_flagDic;

@synthesize m_countDic;

- (void)viewDidLoad {
    [super viewDidLoad];
    // 版本判断
    if ( isIOS7 ) {
        if ( iPhone5 ) {
            Viewheight = [[UIScreen mainScreen]bounds].size.height - 20 - 48;
        }else{
            Viewheight = [[UIScreen mainScreen]bounds].size.height;
        }
        
    }else{
        Viewheight = self.view.frame.size.height - 48;
    }
    self.BCMLeftArray = [[NSMutableArray alloc]initWithCapacity:0];
    self.BCMRightArray = [[NSMutableArray alloc]initWithCapacity:0];
//    self.BCMLeftDic = [[NSMutableDictionary alloc]initWithCapacity:0];
    m_flagDic = [[NSMutableDictionary alloc]initWithCapacity:0];
    
    m_countDic = [[NSMutableDictionary alloc]initWithCapacity:0];
    
//    [self.BCMLeftArray addObject:@"冷菜"];
//    [self.BCMLeftArray addObject:@"干锅"];
//    [self.BCMLeftArray addObject:@"素菜"];
//    [self.BCMLeftArray addObject:@"点心"];
    
//    [self.BCMRightArray addObject:@"百叶丝"];
//    [self.BCMRightArray addObject:@"海带结"];
//    [self.BCMRightArray addObject:@"花生米"];
//    
//    [self.BCMRightArray addObject:@"炒白菜"];
//    [self.BCMRightArray addObject:@"水煮青菜"];
//    
//    [self.BCMRightArray addObject:@"黄焖猪手"];
//    [self.BCMRightArray addObject:@"干锅包菜"];
//    [self.BCMRightArray addObject:@"黄焖牛肉"];
//    [self.BCMRightArray addObject:@"红烧肉"];
    
    [self AllocLeftTB];

    [self AllocRithTB];
    
    self.BCMLeftTableview.frame = CGRectMake(0, 0, 90, Viewheight);
    CGRect frame=self.BCMLeftTableview.frame;
    frame.size.height=0;
    [self.BCMLeftTableview setFrame:frame];
    self.BCMRightTableview.frame = CGRectMake(91, 0, Viewheight-91, Viewheight);
    CGRect frame1=self.BCMRightTableview.frame;
    frame1.size.height=0;
    [self.BCMRightTableview setFrame:frame1];
    self.m_linelabel.frame = CGRectMake(90, 0, 1, Viewheight);
    CGRect frame2=self.m_linelabel.frame;
    frame2.size.height=0;
    [self.m_linelabel setFrame:frame2];
    
    self.m_emptyLabel.hidden = YES;
    
    SelectLeft = 0;
    SelectRight = 0;
    
    // 请求类别的数据
    [self categoryRequest];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UINetworking
- (void)categoryRequest{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    // 刷新请求数据接口
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId, @"cashierAccountID",
                                key,@"key",nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [requstClient request:@"CloudMenuClassList.ashx" parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            self.BCMLeftArray = (NSMutableArray *)[handlJson valueForKey:@"MenuClassList"];
            
            // 标记值的字典-每个类别里面有不同的选择的一个set
            for (int i = 0; i < self.BCMLeftArray.count; i++) {
                
                [self.m_flagDic setObject:[NSMutableDictionary dictionary] forKey:[NSNumber numberWithInt:i]];
                
                // 记录左边tableView的数字的显示的值
                [self.m_countDic setObject:@"0" forKey:[NSString stringWithFormat:@"%i",i]];
                
            }
                        
            [BCMLeftTableview reloadData];
            
            if ( self.BCMLeftArray.count != 0 ) {
                
                if ( SelectLeft >= self.BCMLeftArray.count ) {
                    
                    SelectLeft = self.BCMLeftArray.count - 1;
                    
                }
                
                NSDictionary *dic = [self.BCMLeftArray objectAtIndex:SelectLeft];
              
                NSString *cloudMenuClassId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"CloudMenuClassID"]];
                
//                self.m_menuClassId = [NSString stringWithFormat:@"%@",cloudMenuClassId];
                
                
                [self CloudMenuList:cloudMenuClassId];
                
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

//云菜单子类别列表
-(void)CloudMenuList:(NSString *)cloudMenuClassId{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    // 刷新请求数据接口
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId, @"cashierAccountID",
                                key,@"key",
                                cloudMenuClassId,@"cloudMenuClassId",nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [requstClient request:@"CloudMenuList.ashx" parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
//            if ( self.BCMRightArray.count != 0 ) {
//                
//                [self.BCMRightArray removeAllObjects];
//                
//            }
            
            self.BCMRightArray = (NSMutableArray *)[handlJson valueForKey:@"MenuList"];
            
            if ( self.BCMRightArray.count != 0 ) {
                
                self.m_emptyLabel.hidden = YES;

            }else{
                
                self.m_emptyLabel.hidden = NO;

            }
            
            
            [BCMRightTableview reloadData];
            
        }else
        {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
        }
    } failured:^(NSError* error)
     {
         
         [SVProgressHUD showErrorWithStatus:error.description];
     }];
    
}



 #pragma mark 云菜单
 - (void)AllocLeftTB{
 
     [BCMLeftTableview initTableViewDataSourceAndDelegate:^NSInteger(UITableView *tableView,NSInteger section)
 
     {
         return self.BCMLeftArray.count;
 
     } setCellForIndexPathBlock:^UITableViewCell *(UITableView *tableView,NSIndexPath *indexPath)
 
     {
 
         BCloundMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BCloundMenuTableViewCell"];
    
         if (!cell)
        
         {
           
             cell = [[[NSBundle mainBundle]loadNibNamed:@"BCloundMenuTableViewCell" owner:self options:nil]objectAtIndex:0];
           
             [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
             
             
             cell.m_amoutLabel.layer.masksToBounds = YES;
             cell.m_amoutLabel.layer.cornerRadius = 10.0f;
             
 
        }
     
         
         if ( self.BCMLeftArray.count != 0 ) {
             
            NSDictionary *dic = [self.BCMLeftArray objectAtIndex:indexPath.row];
             
             cell.m_labeltext.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MenuClassName"]];
             
             
             if (SelectLeft == indexPath.row) {
                 
                 cell.m_labeltext.textColor = RGBA(239, 154, 85, 1);
                 
             }else{
                 
                 cell.m_labeltext.textColor = [UIColor blackColor];
                 
             }

         }
         
         
         // 根据值来判断红点数字的显示
         NSMutableDictionary *dic = [self.m_flagDic objectForKey:[NSNumber numberWithInt:indexPath.row]];
         
         NSString *count = [NSString stringWithFormat:@"%@",[self.m_countDic objectForKey:[NSString stringWithFormat:@"%i",indexPath.row]]];
         
         if ( dic.count != 0 ) {
             
             if ( ![count isEqualToString:@"0"] ) {
                 
                 cell.m_amoutLabel.hidden = NO;
                 
                 cell.m_amoutLabel.text = [NSString stringWithFormat:@"%@",count];
            
             }else{
                 
                 cell.m_amoutLabel.hidden = YES;

             }
             
          
             
         }else{
             
             cell.m_amoutLabel.hidden = YES;
         }
         
         return cell;
 
    
     } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath)
  
     {
 
         if (indexPath.row != self.BCMLeftArray.count) {
             
             SelectLeft = indexPath.row;
             
             NSDictionary *dic = [self.BCMLeftArray objectAtIndex:indexPath.row];
             
             NSString *cloudMenuClassId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"CloudMenuClassID"]];
             
             [self.BCMLeftTableview reloadData];
             [self CloudMenuList:cloudMenuClassId];
         }
 
       }];
     
     [self.BCMLeftTableview.layer setBorderColor:[UIColor lightGrayColor].CGColor];
 
    
     [self.BCMLeftTableview.layer setBorderWidth:0];
 }

 
 - (void)AllocRithTB{
 
 
     [self.BCMRightTableview initTableViewDataSourceAndDelegate:^NSInteger(UITableView *tableView,NSInteger section)
 
     {
 
         return self.BCMRightArray.count;
 
 
     } setCellForIndexPathBlock:^UITableViewCell *(UITableView *tableView,NSIndexPath *indexPath)
 
     {
 
         BCloundMenuTableViewCell1 *cell=[tableView dequeueReusableCellWithIdentifier:@"BCloundMenuTableViewCell"];
 
         if (!cell)
 
         {
             cell = [[[NSBundle mainBundle]loadNibNamed:@"BCloundMenuTableViewCell" owner:self options:nil]objectAtIndex:1];
 
             [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
 
         }
     
         if ( self.BCMRightArray.count != 0 ) {
             
             NSDictionary *dic = [self.BCMRightArray objectAtIndex:indexPath.row];
             
             cell.m_labelname.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MenuName"]];
             
             cell.m_labelpice.text = [NSString stringWithFormat:@"￥%@",[dic objectForKey:@"MenuPrice"]];
             
             [cell setImagePath:[dic objectForKey:@"MenuImage"]];

         }
         
         NSMutableDictionary *dic = [self.m_flagDic objectForKey:[NSNumber numberWithInt:SelectLeft]];
         
         NSMutableDictionary *l_dic = [dic objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
         
         NSString *Istring = [l_dic objectForKey:@"amount"];
         
         if ((!Istring) ||([Istring isEqualToString:@"0"])) {
       
             cell.m_Btnjian.hidden = cell.m_Btnnum.hidden = YES;
             
             // 设置加号的颜色
             [cell.m_Btnjia.titleLabel setTextColor:[UIColor darkGrayColor]];
             
             [cell.m_Btnjia.layer setBorderColor:[UIColor darkGrayColor].CGColor];//边框颜色
     
         }else
    
         {
             cell.m_Btnjian.hidden = cell.m_Btnnum.hidden = NO;
         
             [cell.m_Btnnum setTitle:[NSString stringWithFormat:@"%@",Istring] forState:UIControlStateNormal];
             // 设置加号的颜色
             [cell.m_Btnjia.titleLabel setTextColor:[UIColor redColor]];

             [cell.m_Btnjia.layer setBorderColor:[UIColor redColor].CGColor];//边框颜色
    
         }
     
         cell.m_Btnjia.tag = indexPath.row;
         
         cell.m_Btnjian.tag = indexPath.row;

         [cell.m_Btnjia addTarget:self action:@selector(Addnum:) forControlEvents:UIControlEventTouchUpInside];
     
         [cell.m_Btnjian addTarget:self action:@selector(Jiannum:) forControlEvents:UIControlEventTouchUpInside];

 
         return cell;
  
     } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath)
 
     {
         SelectRight = indexPath.row;

     }];
 
 
     [self.BCMRightTableview.layer setBorderColor:[UIColor lightGrayColor].CGColor];
 
     [self.BCMRightTableview.layer setBorderWidth:0];
     
 }

- (void)Addnum:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    NSMutableDictionary *dic = [self.m_flagDic objectForKey:[NSNumber numberWithInt:SelectLeft]];
    
    // 存放数组的总个数
    [dic setObject:[NSString stringWithFormat:@"%i",self.BCMRightArray.count] forKey:@"TotalCount"];
    
    NSMutableDictionary *l_dic = [dic objectForKey:[NSString stringWithFormat:@"%ld",(long)btn.tag]];

    NSString *Istring = [l_dic objectForKey:@"amount"];

    int nownum ;

    if ((!Istring) ||([Istring isEqualToString:@"0"])) {
        
        nownum = 1;
        
        // 存放字典中的值
        NSString *count = [self.m_countDic objectForKey:[NSString stringWithFormat:@"%i",SelectLeft]];
        
        int countValue = [count intValue];
        
        countValue = countValue + 1;
        
        [self.m_countDic setObject:[NSString stringWithFormat:@"%i",countValue] forKey:[NSString stringWithFormat:@"%i",SelectLeft]];

    }else{
        
        NSString *num = [NSString stringWithFormat:@"%@",Istring];
        
        nownum = [num intValue]+1;
       
    }
    
    // 将选择的菜单的值记录到字典里面
    NSMutableDictionary *l_dic22 = [[NSMutableDictionary alloc]initWithCapacity:0];
    
    NSMutableDictionary *dic1 = [self.BCMRightArray objectAtIndex:btn.tag];
    
    [l_dic22 setObject:[dic1 objectForKey:@"CloudMenuID"] forKey:@"menuId"];
    [l_dic22 setObject:[NSString stringWithFormat:@"%d",nownum] forKey:@"amount"];
    
    [l_dic22 setObject:[dic1 objectForKey:@"MenuPrice"] forKey:@"price"];
    
    [dic setObject:l_dic22 forKey:[NSString stringWithFormat:@"%ld",(long)btn.tag]];
    
    [self.BCMRightTableview reloadData];
    
    // 刷新左边的tableView
    NSArray *arr = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:SelectLeft inSection:0], nil];
    
    [self.BCMLeftTableview reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];
    
}

- (void)Jiannum:(id)sender
{
    
    UIButton *btn = (UIButton *)sender;
    
    NSMutableDictionary *dic = [self.m_flagDic objectForKey:[NSNumber numberWithInt:SelectLeft]];
    
    // 存放数组的总个数
    [dic setObject:[NSString stringWithFormat:@"%i",self.BCMRightArray.count] forKey:@"TotalCount"];

    
    NSMutableDictionary *l_dic = [dic objectForKey:[NSString stringWithFormat:@"%ld",(long)btn.tag]];
    
    NSString *Istring = [l_dic objectForKey:@"amount"];
    
    int nownum;
   
    if ([Istring isEqualToString:@"1"]) {
        
         nownum = 0;
        
        // 存放字典中的值
        NSString *count = [self.m_countDic objectForKey:[NSString stringWithFormat:@"%i",SelectLeft]];
        
        int countValue = [count intValue];
        
        countValue = countValue - 1;
        
        [self.m_countDic setObject:[NSString stringWithFormat:@"%i",countValue] forKey:[NSString stringWithFormat:@"%i",SelectLeft]];
        
    }else{
        
        NSString *num = [NSString stringWithFormat:@"%@",Istring];
        
        nownum = [num intValue] - 1;
        
    }

    // 将选择的菜单的值记录到字典里面
    NSMutableDictionary *l_dic11 = [[NSMutableDictionary alloc]initWithCapacity:0];
    
    NSMutableDictionary *dic1 = [self.BCMRightArray objectAtIndex:btn.tag];
    
    [l_dic11 setObject:[dic1 objectForKey:@"CloudMenuID"] forKey:@"menuId"];
    [l_dic11 setObject:[NSString stringWithFormat:@"%d",nownum] forKey:@"amount"];
    
    [l_dic11 setObject:[dic1 objectForKey:@"MenuPrice"] forKey:@"price"];
    
    [dic setObject:l_dic11 forKey:[NSString stringWithFormat:@"%ld",(long)btn.tag]];
    
  
    [self.BCMRightTableview reloadData];

    // 刷新左边的tableView
    NSArray *arr = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:SelectLeft inSection:0], nil];
    
    [self.BCMLeftTableview reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];
    
}



@end
