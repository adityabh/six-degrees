//
//  DreamContent.m
//  SixDegrees
//
//  Created by Bhalla, Aditya on 7/19/15.
//  Copyright (c) 2015 Steven Wu. All rights reserved.
//

#import "DreamContent.h"
#import "Dream.h"
#import "Message.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"


@implementation DreamContent

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    // model_property_name : json_field_name
    return @{
             @"dream" : @"dream",
             @"messages" : @"messages"
             };
}

+ (NSValueTransformer *)dreamJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:Dream.class];
}

+ (NSValueTransformer *)messagesJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:Message.class];
}

@end