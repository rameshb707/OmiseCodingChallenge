//
//  Omise_iOS.h
//  Omise
//
//  Created on 2014/11/10.
//  Copyright (c) 2014 Omise Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Token.h"
#import "TokenRequest.h"
#import "JsonParser.h"
#import "OmiseError.h"

@protocol OmiseRequestDelegate <NSObject>
-(void)omiseOnSucceededToken:(Token*)token;
-(void)omiseOnFailed:(NSError*)error;
@end


@interface Omise : NSObject <NSURLConnectionDelegate>

@property (nonatomic) id<OmiseRequestDelegate> delegate;

-(void)requestToken:(TokenRequest*)tokenRequest;

@end
