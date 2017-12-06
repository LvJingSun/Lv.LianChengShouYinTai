//
//  ErWeiMaView.m
//  CashierDeskIphone
//
//  Created by mac on 16/9/28.
//  Copyright © 2016年 MaxLinksTec. All rights reserved.
//

#import "ErWeiMaView.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@implementation ErWeiMaView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithRed:0/255. green:0/255. blue:0/255. alpha:0.8];
        
        UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.1, SCREEN_HEIGHT * 0.25, SCREEN_WIDTH * 0.8, SCREEN_HEIGHT * 0.5)];
        
        bgview.backgroundColor = [UIColor whiteColor];
        
        bgview.layer.cornerRadius = 5;
        
        [self addSubview:bgview];
        
        UIButton *noBtn = [[UIButton alloc] initWithFrame:CGRectMake(bgview.frame.size.width - 30, 10, 20, 20)];
        
        [noBtn setImage:[UIImage imageNamed:@"search_clear_normal.png"] forState:UIControlStateNormal];
        
        [noBtn addTarget:self action:@selector(noBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [bgview addSubview:noBtn];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, bgview.frame.size.height - 50, bgview.frame.size.width, 40)];
        
        label.text = @"邀请注册城与城会员";
        
        label.numberOfLines = 0;
        
        label.textAlignment = NSTextAlignmentCenter;
        
        label.textColor = [UIColor darkGrayColor];
        
        label.font = [UIFont systemFontOfSize:15];
        
        [bgview addSubview:label];
        
        CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
        
        [filter setDefaults];
        
        NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
        
        NSString *erweima = [userDefau objectForKey:@"erweima"];
        
        NSData *data = [erweima dataUsingEncoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",erweima);
        
        [filter setValue:data forKeyPath:@"inputMessage"];
        
        CIImage *outputImage = [filter outputImage];
        
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(bgview.frame.size.width * 0.15, 50, bgview.frame.size.width * 0.7, bgview.frame.size.height - 110)];
        
//        imageview.image = [UIImage imageWithCIImage:outputImage scale:2.0 orientation:UIImageOrientationUp];
        
        imageview.image = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:imageview.frame.size.width];
        
        [bgview addSubview:imageview];

    }
    
    return self;
    
}

- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

- (void)noBtnClick {

    if (self) {
        
        [self removeFromSuperview];
        
    }
    
}

@end
