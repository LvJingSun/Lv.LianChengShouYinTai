//
//  HttpClientRequest.m
//  CashierDeskIphone
//
//  Created by Steven.lv on 13-9-1.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "Configuration.h"
#import "HttpClientRequest.h"
#import "AFJSONRequestOperation.h"
static HttpClientRequest* _sharedHttpClient = nil;

@implementation HttpClientRequest
+(HttpClientRequest*)sharedInstance
{
    if (_sharedHttpClient == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _sharedHttpClient = [[HttpClientRequest alloc]initWithBaseURL:[NSURL URLWithString:CDHTTPRequestURL]];
        });
    }
    return _sharedHttpClient;
}

- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    //设置头域
    [self setDefaultHeader:@"Accept" value:@"text/plain"];
    return self;
}

-(void)request:(NSString *)path parameters:(NSDictionary *)parameters successed:(void (^)(JSONDecoder *))successed failured:(void (^)(NSError *error))failure
{
    HttpClientRequest* request = [self request:path parameters:parameters successed:<#^(JSONDecoder *jsonDecoder)successed#> failured:<#^(NSError *error)failure#>]
}

@end
