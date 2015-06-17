//
//  FacebookAccount.h
//  SixDegrees
//
//  Created by Steven Wu on 2014-10-19.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

#import "SDModel.h"

@interface FacebookAccount : SDModel

@property (strong, nonatomic, readonly) NSString *uid;
@property (strong, nonatomic, readonly) NSString *name;
@property (strong, nonatomic, readonly) NSString *firstName;
@property (strong, nonatomic, readonly) NSString *lastName;
@property (strong, nonatomic, readonly) NSString *gender;
@property (strong, nonatomic, readonly) NSString *timezone;
@property (strong, nonatomic, readonly) NSString *email;

@end
