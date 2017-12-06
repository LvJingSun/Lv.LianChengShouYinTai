//
//  UserListViewController.m
//  CashierDeskIphone
//
//  Created by CityAndCity on 15-8-24.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "UserListViewController.h"

@interface UserListViewController ()<UIActionSheetDelegate>

{
    NSMutableArray *userListArr;//存放会员列表
    NSIndexPath *selectIndexPath;

}
@end

@implementation UserListViewController


+(UserListViewController *)ShareUserListVC
{
    static UserListViewController *ShareUser;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ShareUser = [[UserListViewController alloc] initWithNibName:@"UserListViewController" bundle:nil];
    });
    
    [ShareUser Loadrequest];
    
    return ShareUser;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationController.navigationBar.translucent = NO;
    userListArr = [[NSMutableArray alloc] init];
    self.userTableView.sectionIndexColor = [UIColor blackColor];
    self.indexAllKeys = [[NSMutableArray alloc] init];
    self.userListDic = [[NSMutableDictionary alloc] init];
    self.userTableView.hidden = YES;
    
    // 版本判断
    if ( isIOS7 ) {
        
         self.userTableView.sectionIndexBackgroundColor = [UIColor clearColor];
        
        [self.m_titleView setFrame:CGRectMake(0, 20, 320, 48)];
        
        [self.userTableView setFrame:CGRectMake(0, 68, 320,self.view.frame.size.height -68)];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
        label.backgroundColor = [UIColor blackColor];
        
        [self.view addSubview:label];
        
    }else{
        
        [self.m_titleView setFrame:CGRectMake(0, 0, 320, 48)];
        
        [self.userTableView setFrame:CGRectMake(0, 48, 320, self.view.frame.size.height - 48)];

    }
    
}


- (void)Loadrequest
{
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    HttpClientRequest *requestClient = [HttpClientRequest sharedInstance];
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:memberId,@"cashierAccountID",key,@"key", nil];
    if (userListArr.count==0) {
        [SVProgressHUD showWithStatus:@"数据加载中..."];
    }
    [requestClient request:@"VIPCardMemberList.ashx" parameters:parameters successed:^(JSONDecoder *json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        NSLog(@"userList===%@",handlJson);
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        if (success) {
            self.m_IsSelectSeat = [NSString stringWithFormat:@"%@",[handlJson valueForKey:@"IsSelectSeat"]];

            userListArr = [handlJson objectForKey:@"MemberList"];
            
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                // 处理耗时操作的代码块...
                        [self sortUsers];
                //通知主线程刷新
                dispatch_async(dispatch_get_main_queue(), ^{
                    //回调或者说是通知主线程刷新，
                        [SVProgressHUD dismiss];
                        self.userTableView.hidden = NO;
                        [self.userTableView reloadData];
                });
                
            });
        
        } else {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
        }
        
    } failured:^(NSError *error){
        [SVProgressHUD showErrorWithStatus:error.description];
    }];
}


-(void)sortUsers{
    if (userListArr.count != 0) {
        
        NSMutableArray *indallkeys = [[NSMutableArray alloc]initWithCapacity:0];
        
        [userListArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            NSDictionary *dic = (NSDictionary *)obj;
            
            NSString *pinyin = [self firstLetterForCompositeName:[dic objectForKey:@"RealName"]];
            
            NSArray *array = [self sortBypinyin:pinyin];
            
            [self.userListDic setObject:array forKey:pinyin];
            
        }];
        
        NSArray *allkeys  = [[self.userListDic allKeys] sortedArrayUsingSelector:@selector(compare:)];
        NSLog(@"allKeys==%@",allkeys);
         NSLog(@"userListDic==%@",self.userListDic);
        [indallkeys addObjectsFromArray:allkeys];
        self.indexAllKeys = indallkeys;

    }
    
    
//    [self.userTableView reloadData];
}

- (NSString *)firstLetterForCompositeName:(NSString *)cityString {
    
    if (![cityString length]) {
        return @"";
    }
    NSLog(@"cityString==%@",cityString);
    unichar charString = [cityString characterAtIndex:0];
     NSLog(@"%hu",charString);
    NSArray *array = pinYinWithoutToneOnlyLetter(charString);
    
    NSLog(@"array = %@",array);
    
    if ([array count]) {
        return [[[array objectAtIndex:0] substringToIndex:1] uppercaseString];
    }
    return @"";
}

- (NSMutableArray *)sortBypinyin:(NSString *)pinyin{
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (int i = 0; i< userListArr.count; i++) {
        
        NSDictionary *dic = [userListArr objectAtIndex:i];
        NSString *data_pinyin = [self firstLetterForCompositeName:[dic objectForKey:@"RealName"]];
        
//        NSString *data_pinyin = [self firstLetterForCompositeName:[userListArr objectAtIndex:i]];
        if ([data_pinyin isEqualToString:pinyin]) {
            [array addObject:[userListArr objectAtIndex:i]];
        }
    }
    
    return array;
}


//添加索引序列
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{

    return self.indexAllKeys;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.indexAllKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if (self.indexAllKeys.count==0) {
        return 0;
    }
    
    NSString *str = [self.indexAllKeys objectAtIndex:section];
    
    NSArray *usersArr = [self.userListDic objectForKey:str];
    
    return usersArr.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    UIView* l_View = [[UIView alloc] init];
//     UIView* l_View = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WindowSizeWidth, 30)];
    l_View.backgroundColor = [UIColor lightGrayColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, WindowSizeWidth, 22)];
    titleLabel.textColor=[UIColor darkGrayColor];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:15.0];
    titleLabel.backgroundColor = [UIColor clearColor];
    
    NSString *str = [self.indexAllKeys objectAtIndex:section];
    titleLabel.text = str;
    
    [l_View addSubview:titleLabel];
    
    return l_View;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30.0f;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 55.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"userCell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
     UserListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"UserListCell" owner:self options:nil];
        
        cell = (UserListCell *)[nib objectAtIndex:0];
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSString *key = [self.indexAllKeys objectAtIndex:indexPath.section];
    NSArray *arr = [self.userListDic objectForKey:key];
    NSDictionary *dic = [arr objectAtIndex:indexPath.row];
    cell.nickName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"RealName"]];
    cell.phoneNumber.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Account"]];
    [cell.headImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"PhotoBigUrl"]]] placeholderImage:[UIImage imageNamed:@"moren.png"]];
    UILongPressGestureRecognizer *longTap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    longTap.minimumPressDuration = 1.0;
    [cell addGestureRecognizer:longTap];
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.userTableView deselectRowAtIndexPath:indexPath animated:YES];
//    NSString *key = [self.indexAllKeys objectAtIndex:indexPath.section];
//    NSArray *arr = [self.userListDic objectForKey:key];
//  
//     NSMutableDictionary *dic = [arr objectAtIndex:indexPath.row];
//    [self.delegate setTextField:[dic objectForKey:@"Account"]];
//    [self.navigationController popViewControllerAnimated:YES];
//    [self.navigationController popToViewController:consoleHand animated:YES];
    
    selectIndexPath = indexPath;
    [self ChoseMember];
    
}

-(void)longPress:(UILongPressGestureRecognizer *)gesture{

    if(gesture.state == UIGestureRecognizerStateBegan)
    {
      NSIndexPath *indexPath = [self.userTableView indexPathForCell:((UITableViewCell *)gesture.view)];
//        NSIndexPath * indexPath = [self.userTableView indexPathForRowAtPoint:point];
        
        if(indexPath == nil){
            
            return ;
        }
        selectIndexPath = indexPath;
        UIMenuController *menuController = [UIMenuController sharedMenuController];
        UIMenuItem *item1 = [[UIMenuItem alloc] initWithTitle:@"查看详情" action:@selector(VIPDetail:)];
        UIMenuItem *item2 = [[UIMenuItem alloc] initWithTitle:@"选择" action:@selector(VIPSelect:)];
        NSArray *menus = [NSArray arrayWithObjects:item1, item2, nil];
        [menuController setMenuItems:menus];
        [menuController setArrowDirection:UIMenuControllerArrowDown];
        [menuController  setTargetRect:[self.userTableView rectForRowAtIndexPath:indexPath] inView:self.userTableView];
        [menuController setMenuVisible:YES animated:YES];
    }
}

-(void)VIPDetail:(id)sender{
    NSString *key = [self.indexAllKeys objectAtIndex:selectIndexPath.section];
    NSArray *arr = [self.userListDic objectForKey:key];
    NSMutableDictionary *dic = [arr objectAtIndex:selectIndexPath.row];
    CardMemeberDetaiViewController *carMemeber = [[CardMemeberDetaiViewController alloc]initWithNibName:@"CardMemeberDetaiViewController" bundle:nil];
    carMemeber.m_dic = dic;
    carMemeber.m_status = self.m_IsSelectSeat;
    [self.navigationController pushViewController:carMemeber animated:YES];
}

-(void)VIPSelect:(id)sender{
    NSString *key = [self.indexAllKeys objectAtIndex:selectIndexPath.section];
    NSArray *arr = [self.userListDic objectForKey:key];
    NSMutableDictionary *dic = [arr objectAtIndex:selectIndexPath.row];
    [self.delegate setTextField:[dic objectForKey:@"Account"]];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIMenuController

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(VIPSelect:) ||
        action == @selector(VIPDetail:)) {
        return YES;
    }
    return NO;//隐藏系统默认的菜单项
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)ChoseMember
{
    
    UIActionSheet *sheet  = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"选择",@"查看详情", nil];
    sheet.tag = 10001;
    [sheet showInView:self.view];
}


- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 10001)
    {
        if (buttonIndex==0)
        {
            [self VIPSelect:nil];
        }
        
        if (buttonIndex == 1) {
            
            [self VIPDetail:nil];

        }
    }
    
}

- (IBAction)backButClick:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
