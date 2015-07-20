//
//  UserDream.m
//  SixDegrees
//
//  Created by Steven Wu on 2015-02-21.
//  Copyright (c) 2015 Steven Wu. All rights reserved.
//

#import "UserDream.h"

#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"
#import "DreamContent.h"
#import "User.h"

@implementation UserDream

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    // model_property_name : json_field_name
    return @{
             @"content" : @"content",
             @"user" : @"user"
             };
}

+ (NSValueTransformer *)contentJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:DreamContent.class];
}

+ (NSValueTransformer *)userJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:User.class];
}
@end
