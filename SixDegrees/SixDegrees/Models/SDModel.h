//
//  SDModel.h
//  SixDegrees
//
//  Created by Steven Wu on 2014-10-19.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface SDModel : MTLModel <MTLJSONSerializing>

+ (NSDictionary *)JSONKeyPathsByPropertyKey;

@end
