//
//  User.m
//  SixDegrees
//
//  Created by Steven Wu on 2015-02-21.
//  Copyright (c) 2015 Steven Wu. All rights reserved.
//

#import "User.h"

@implementation User

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"userId" : @"id",
             @"firstName" : @"first_name",
             @"lastName" : @"last_name",
             @"createdAt" : @"created_at",
             @"updatedAt" : @"updated_at",
             };
}

@end
