//
//  Message.m
//  SixDegrees
//
//  Created by Bhalla, Aditya on 7/19/15.
//  Copyright (c) 2015 Steven Wu. All rights reserved.
//

#import "Message.h"

@implementation Message

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"messageId" : @"id",
             @"content" : @"content",
             @"dreamId" : @"dream_id",
             @"userId" : @"user_id",
             @"createdAt" : @"created_at",
             @"updatedAt" : @"updated_at",
             @"recipientId" : @"recipient_id"
             };
}


@end
