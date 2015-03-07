//
//  User.h
//  SixDegrees
//
//  Created by Steven Wu on 2015-02-21.
//  Copyright (c) 2015 Steven Wu. All rights reserved.
//

#import "SDModel.h"

@interface User : SDModel

@property (strong, nonatomic, readonly) NSNumber *userId;
@property (strong, nonatomic, readonly) NSString *email;
@property (strong, nonatomic, readonly) NSString *firstName;
@property (strong, nonatomic, readonly) NSString *lastName;
@property (strong, nonatomic, readonly) NSString *name;
@property (strong, nonatomic, readonly) NSString *gender;
@property (strong, nonatomic, readonly) NSString *image;
@property (strong, nonatomic, readonly) NSString *provider;
@property (strong, nonatomic, readonly) NSString *timezone;
@property (strong, nonatomic, readonly) NSString *uid;
@property (strong, nonatomic, readonly) NSDate *createdAt;
@property (strong, nonatomic, readonly) NSDate *updatedAt;

@end

//"created_at" = "2014-10-18T21:12:54.874Z";
//email = "dwen.fb@gmail.com";
//"first_name" = David;
//gender = male;
//id = 5;
//image = "https://fbcdn-profile-a.akamaihd.net/hprofile-ak-xfa1/v/t1.0-1/1959257_10100730884868471_1834324522_n.jpg?oh=8dbec15995c3472e1d4782fda7ac3a03&oe=54B9AB44&__gda__=1421596429_c63747529379a4e458f819c6be4ee547";
//"last_name" = Wen;
//name = "David Wen";
//provider = facebook;
//timezone = "-7";
//uid = 10100782847554831;
//"updated_at" = "2014-10-18T21:12:54.874Z";