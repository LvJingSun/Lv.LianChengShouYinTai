//
//  FSB_UpLoadViewController.m
//  CashierDeskIphone
//
//  Created by mac on 2017/6/24.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "FSB_UpLoadViewController.h"
#import "FSB_Header.h"
#import "FSB_UpLoadFrame.h"
#import "FSB_UpLoadCell.h"
#import "FSB_TranInfoModel.h"

@interface FSB_UpLoadViewController () <UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSMutableArray *array;

@property (nonatomic, weak) UIButton *sureBtn;

@end

@implementation FSB_UpLoadViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"上传";
    
    [self allocWithTableview];
    
    NSMutableArray *mut = [NSMutableArray array];
    
    FSB_UpLoadFrame *frame = [[FSB_UpLoadFrame alloc] init];
    
    frame.tranModel = self.tranModel;
    
    [mut addObject:frame];
    
    self.array = mut;
    
}

- (void)allocWithTableview {
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = BGColor;
    
    [self.view addSubview:tableview];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.array.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FSB_UpLoadFrame *frame = self.array[indexPath.row];

    FSB_UpLoadCell *cell = [[FSB_UpLoadCell alloc] init];
    
    cell.frameModel = frame;
    
    self.sureBtn = cell.SureBtn;
    
    cell.InvoiceBlock = ^{
        
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
        
        [sheet showInView:self.view];
        
    };
    
    cell.SureBlock = ^{
        
        self.sureBtn.userInteractionEnabled = NO;
        
        [self checkData];
        
    };
   
    return cell;
    
}

//检测数据是否填写完整
- (void)checkData {
    
    FSB_UpLoadFrame *frame = self.array[0];
    
    FSB_TranInfoModel *carmodel = frame.tranModel;
    
    if (carmodel.InvoiceImg == nil) {
        
        [SVProgressHUD showErrorWithStatus:@"请选择发票图片"];
        
        self.sureBtn.userInteractionEnabled = YES;
        
    }else {
        
        [self pushData];
        
    }
    
}

- (void)pushData {

    FSB_UpLoadFrame *frame = self.array[0];
    
    NSDictionary *picDic = [NSMutableDictionary dictionary];
    
    [picDic setValue:UIImageJPEGRepresentation(frame.tranModel.InvoiceImg, 0.3) forKey:@"name1"];
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                frame.tranModel.acount,@"phone",
                                memberId,@"CashierAccountID",
                                frame.tranModel.goldCount,@"jinzhongzi",
                                frame.tranModel.redCopiesID,@"CycleType",
                                frame.tranModel.redCopiesName,@"part",
                                frame.tranModel.tranCount,@"TranAccount",
                                frame.tranModel.productName,@"goodsname",
                                frame.tranModel.staffID,@"yuangong",
                                @"2",@"status",
                                frame.tranModel.redCount,@"allaccount",
                                frame.tranModel.redType,@"Types",
                                frame.tranModel.merchantRedType,@"mctMode",
                                frame.tranModel.jifen,@"Jifen",
                                nil];
    
    [SVProgressHUD showWithStatus:@"赠送中..."];
    
    [requstClient multipartFormRequest:@"FansBusinessNew.ashx" parameter:parameters file:picDic successed:^(JSONDecoder *json, id responseObject) {
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
            [self saveProductName];
            
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
            
        }else
        {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
            self.sureBtn.userInteractionEnabled = YES;
            
        }

        
    } failured:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:error.description];
        
        self.sureBtn.userInteractionEnabled = YES;
        
    }];
    
}

//保存商品名
- (void)saveProductName {
    
    FSB_UpLoadFrame *frame = self.array[0];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSArray *lastArray = [defaults valueForKey:@"productNameArray"];
    
    NSMutableArray *productNameArray = [NSMutableArray array];
    
    [productNameArray addObjectsFromArray:lastArray];
    
    BOOL isContain = [lastArray containsObject:frame.tranModel.productName];
    
    if (!isContain) {
        
        [productNameArray addObject:frame.tranModel.productName];
        
    }
    
    [defaults setObject:productNameArray forKey:@"productNameArray"];
    
    [defaults synchronize];
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    FSB_UpLoadFrame *frame = self.array[indexPath.row];
    
    return frame.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0:
        {
            [self PaiZhao];
        }
            break;
        case 1:
        {
            [self XiangCe];
        }
            break;
            
        default:
            break;
    }
    
}

- (void)PaiZhao {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        
        picker.delegate = self;
        
        picker.allowsEditing = YES;
        
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:nil];
        
    }else {
        
        [SVProgressHUD showErrorWithStatus:@"你的设备暂不支持拍照"];
        
    }
    
}

- (void)XiangCe {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        
        picker.delegate = self;
        
        picker.allowsEditing = YES;
        
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:picker animated:YES completion:nil];
        
    }else {
        
        [SVProgressHUD showErrorWithStatus:@"你的设备暂不支持选取相册"];
        
    }
    
}

//拍照完成实现的代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    for (FSB_UpLoadFrame *frame in self.array) {
        
        frame.tranModel.InvoiceImg = image;
        
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.tableview reloadData];
    
}

//点击cancle实现的代理
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
