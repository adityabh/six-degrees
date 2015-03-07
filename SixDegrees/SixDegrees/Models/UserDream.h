//
//  UserDream.h
//  SixDegrees
//
//  Created by Steven Wu on 2015-02-21.
//  Copyright (c) 2015 Steven Wu. All rights reserved.
//

#import "SDModel.h"

@class Dream;
@class User;

@interface UserDream : SDModel

@property (strong, nonatomic, readonly) Dream *content;
@property (strong, nonatomic, readonly) User *user;

@end
