//
//  DreamResponse.h
//  SixDegrees
//
//  Created by Steven Wu on 2015-03-15.
//  Copyright (c) 2015 Steven Wu. All rights reserved.
//

#import "SDModel.h"

@class Dream;

@interface DreamResponse : SDModel

@property (strong, nonatomic, readonly) NSNumber *status;
@property (strong, nonatomic, readonly) NSString *message;
@property (strong, nonatomic, readonly) Dream *dream;

@end
