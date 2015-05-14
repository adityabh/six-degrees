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
             @"email" : @"email",
             @"firstName" : @"first_name",
             @"lastName" : @"last_name",
             @"name" : @"name",
             @"gender" : @"gender",
             @"image" : @"image",
             @"provider" : @"provider",
             @"timezone" : @"timezone",
             @"uid" : @"uid",
             @"authenticationToken" : @"authentication_token",
             @"createdAt" : @"created_at",
             @"updatedAt" : @"updated_at",
             @"avatarUpdatedAt" : @"avatar_updated_at",
             @"avatarFileSize" : @"avatar_file_size",
             @"avatarFileName" : @"avatar_file_name",
             @"avatarContentType" : @"avatar_content_type",
             @"admin" : @"admin"
             };
}

@end
