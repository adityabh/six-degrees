//
//  Message.h
//  SixDegrees
//
//  Created by Bhalla, Aditya on 7/19/15.
//  Copyright (c) 2015 Steven Wu. All rights reserved.
//

#import "SDModel.h"

@interface Message : SDModel

@property (strong, nonatomic, readonly) NSNumber *messageId;
@property (strong, nonatomic, readonly) NSString *content;

@property (strong, nonatomic, readonly) NSNumber *dreamId;
@property (strong, nonatomic, readonly) NSNumber *userId;
@property (strong, nonatomic, readonly) NSNumber *recipientId;

@property (strong, nonatomic, readonly) NSDate *createdAt;
@property (strong, nonatomic, readonly) NSDate *updatedAt;

@end
