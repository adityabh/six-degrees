//
//  Dream.m
//  SixDegrees
//
//  Created by Steven Wu on 2015-02-21.
//  Copyright (c) 2015 Steven Wu. All rights reserved.
//

#import "Dream.h"

@implementation Dream

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"dreamId" : @"id",
             @"userId" : @"user_id",
             @"dreamType" : @"dream_type",
             @"createdAt" : @"created_at",
             @"updatedAt" : @"updated_at",
             @"dreamDescription" : @"description",
             };
}

@end
