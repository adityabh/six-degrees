//
//  FacebookAccount.h
//  SixDegrees
//
//  Created by Steven Wu on 2014-10-19.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

#import "SDModel.h"

@interface FacebookAccount : SDModel

@property (strong, nonatomic, readonly) NSString *sdFacebookUserId;
@property (strong, nonatomic, readonly) NSString *name;
@property (strong, nonatomic, readonly) NSString *firstName;
@property (strong, nonatomic, readonly) NSString *lastName;
@property (strong, nonatomic, readonly) NSString *link;
@property (strong, nonatomic, readonly) NSString *gender;
@property (strong, nonatomic, readonly) NSString *locale;
@property (strong, nonatomic, readonly) NSString *email;

@end
