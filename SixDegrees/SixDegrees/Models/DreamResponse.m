//
//  DreamResponse.m
//  SixDegrees
//
//  Created by Steven Wu on 2015-03-15.
//  Copyright (c) 2015 Steven Wu. All rights reserved.
//

#import "DreamResponse.h"
#import "Dream.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"

@implementation DreamResponse

+ (NSValueTransformer *)dreamJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:Dream.class];
}


@end
