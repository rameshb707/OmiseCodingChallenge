//
//  JsonParser.h
//  Omise-iOS
//
//  Created on 2014/11/12.
//  Copyright (c) 2014年 Omise Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Token.h"
#import "Card.h"
#import "Cards.h"

@interface JsonParser : NSObject

-(Token*)parseOmiseToken:(NSString*)json;

@end
