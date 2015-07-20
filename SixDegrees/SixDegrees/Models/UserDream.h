//
//  UserDream.h
//  SixDegrees
//
//  Created by Steven Wu on 2015-02-21.
//  Copyright (c) 2015 Steven Wu. All rights reserved.
//

#import "SDModel.h"
#import "DreamContent.h"

@class User;

@interface UserDream : SDModel

@property (strong, nonatomic, readonly) DreamContent *content;
@property (strong, nonatomic, readonly) User *user;

@end
