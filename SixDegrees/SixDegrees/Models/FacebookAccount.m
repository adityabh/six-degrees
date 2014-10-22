//
//  FacebookAccount.m
//  SixDegrees
//
//  Created by Steven Wu on 2014-10-19.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

#import "FacebookAccount.h"

@implementation FacebookAccount

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"sdFacebookUserId" : @"id",
             @"firstName" : @"first_name",
             @"lastName" : @"last_name",
             };
}

@end
