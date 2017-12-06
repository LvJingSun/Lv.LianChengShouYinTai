//
//  HttpClientRequest.h
//  CashierDeskIphone
//
//  Created by Steven.lv on 13-9-1.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "AFHTTPClient.h"
#import "JSONKit.h"
@interface HttpClientRequest : AFHTTPClient

- (void)request:(NSString*)path parameters:(NSDictionary*)parameters successed:(void(^)(JSONDecoder* jsonDecoder))successed failured:(void(^)(NSError* error))failure;

@end
