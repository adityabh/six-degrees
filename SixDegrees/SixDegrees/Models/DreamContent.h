//
//  DreamContent.h
//  SixDegrees
//
//  Created by Bhalla, Aditya on 7/19/15.
//  Copyright (c) 2015 Steven Wu. All rights reserved.
//

#import "SDModel.h"
#import "Dream.h"

@interface DreamContent : SDModel

@property (strong, nonatomic, readonly) Dream *dream;
@property (strong, nonatomic, readonly) NSArray *messages;

@end
