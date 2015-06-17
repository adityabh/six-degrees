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
             @"uid" : @"id",
             @"name" : @"name",
             @"firstName" : @"first_name",
             @"lastName" : @"last_name",
             @"gender" : @"last_name",
             @"timezone" : @"timezone",
             @"email" : @"email",
             };
}

@end
