//
//  MakeUpController.m
//  CashierDeskIphone
//
//  Created by mac on 2017/2/28.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "MakeUpController.h"
#import "Q_PictureCell.h"
#import "SVProgressHUD.h"
#import "HttpClientRequest.h"
#import "AppHttpClient.h"
#import "New_RecordModel.h"
#import <UIButton+WebCache.h>
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface MakeUpController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate> {
    
    NSInteger TAG;
    
    UIImage *heTongIMG;
    
    UIImage *faPiaoIMG;
    
    //存储图片的字典
    NSMutableDictionary *pictures;
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, weak) UIButton *hetongBtn;

@property (nonatomic, weak) UIButton *fapiaoBtn;

@end

@implementation MakeUpController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"上传凭证";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initWithTableview];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSString *cellID = [NSString stringWithFormat:@"cellID%ld%ld",(long)indexPath.section,(long)indexPath.row];
    
    Q_PictureCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[Q_PictureCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    self.hetongBtn = cell.hetongBtn;
    
    cell.hetongBtn.tag = 1;
    
    if (![self.record.pic1 isEqualToString:@""]) {
        
        [cell.hetongBtn sd_setImageWithURL:[NSURL URLWithString:self.record.pic1] forState:0];
        
    }
    
    [cell.hetongBtn addTarget:self action:@selector(selectImage:) forControlEvents:UIControlEventTouchUpInside];
    
    self.fapiaoBtn = cell.fapiaoBtn;
    
    cell.fapiaoBtn.tag = 2;
    
    if (![self.record.pic2 isEqualToString:@""]) {
        
        [cell.fapiaoBtn sd_setImageWithURL:[NSURL URLWithString:self.record.pic2] forState:0];
        
    }
    
    [cell.fapiaoBtn addTarget:self action:@selector(selectImage:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.sureBtn setTitle:@"确认上传" forState:0];
    
    [cell.sureBtn addTarget:self action:@selector(SureClick) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
    
}

- (void)initWithTableview {
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:tableview];
    
}

- (void)selectImage:(UIButton *)sender{
    
    TAG = sender.tag;
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
    
    [sheet showInView:self.view];
    
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

//拍照选取图片
- (void)PaiZhao {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        
        picker.delegate = self;
        
        picker.allowsEditing = YES;
        
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:nil];
        
    }else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的设备不支持拍照功能！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        
        [alert show];
        
    }
    
}

//相册选取图片
- (void)XiangCe {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        
        picker.delegate = self;
        
        picker.allowsEditing = YES;
        
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:picker animated:YES completion:nil];
        
    }else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的设备不支持相册功能！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        
        [alert show];
        
    }
    
}

//点击cancle实现的代理
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//-(void)viewWillAppear:(BOOL)animated {
//
//    if (![self.record.pic1 isEqualToString:@""]) {
//        
//        [self.hetongBtn sd_setImageWithURL:[NSURL URLWithString:self.record.pic1] forState:0 placeholderImage:[UIImage imageNamed:@"selectImg.png"]];
//        
//        heTongIMG = self.hetongBtn.imageView.image;
//        
//    }
//    
//    if (![self.record.pic2 isEqualToString:@""]) {
//        
//        [self.fapiaoBtn sd_setImageWithURL:[NSURL URLWithString:self.record.pic2] forState:0 placeholderImage:[UIImage imageNamed:@"selectImg.png"]];
//        
//        faPiaoIMG = self.fapiaoBtn.imageView.image;
//        
//    }
//    
//}

//拍照完成实现的代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    if (TAG == 1) {
        
        [self.hetongBtn setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:0];
        
//        heTongIMG = image;
        
    }else if (TAG == 2) {
        
        [self.fapiaoBtn setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:0];
        
//        faPiaoIMG = image;
        
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//确认赠送按钮点击
- (void)SureClick {
    
    heTongIMG = self.hetongBtn.imageView.image;
    
    faPiaoIMG = self.fapiaoBtn.imageView.image;
    
    if (heTongIMG == nil && faPiaoIMG == nil) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择(合同/销售单/收据/发票)图片" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        [alert show];
        
    }else {
        
        pictures = [[NSMutableDictionary alloc] init];
        
        if (heTongIMG != nil) {
            
            [pictures setValue:UIImageJPEGRepresentation(heTongIMG, 0.3) forKey:@"name1"];
            
        }
        
        if (faPiaoIMG != nil) {
            
            [pictures setValue:UIImageJPEGRepresentation(faPiaoIMG, 0.3) forKey:@"name2"];
            
        }
        
        [self pushData];
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Q_PictureCell *cell = [[Q_PictureCell alloc] init];
    
    return cell.height;
    
}

- (void)pushData {
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];

    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"CashierAccountID",
                                self.record.TranRcdsid,@"TranID",
                                nil];
    
    [SVProgressHUD showWithStatus:@"上传中..."];
    
    [requstClient multipartFormRequest:@"MctUpdateLogo.ashx" parameter:parameters file:pictures successed:^(JSONDecoder *json, id responseObject) {
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:4] animated:YES];
            
        }else
        {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
        }
        
    } failured:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:error.description];
        
    }];
    
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
