//
//  SDEndpoints.m
//  SixDegrees
//
//  Created by Steven Wu on 2014-10-18.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

#import "SDEndpoints.h"

@implementation SDEndpoints

#pragma mark - Authentication

+ (NSString *)authWithFacebook {
    return @"sign_in_via_facebook";
}

+ (NSString *)loginUser {
    return @"api/login_user";
}

+ (NSString *)createUser {
    return @"api/create_user";
}

+ (NSString *)getUser {
    return @"api/user";
}

+ (NSString *)logoutUser {
    return @"api/logout_user";
}

#pragma mark - Dreams

+ (NSString *)fetchDreams {
    return @"dreams";
}

+ (NSString *)createDream {
    return @"dreams";
}

+ (NSString *)fetchDreamWithId:(NSString *)dreamId {
    return [NSString stringWithFormat:@"dreams/:%@", dreamId];
}

+ (NSString *)updateDreamWithId:(NSString *)dreamId {
    return [NSString stringWithFormat:@"dreams/:%@", dreamId];
}

+ (NSString *)deleteDreamWithId:(NSString *)dreamId {
    return [NSString stringWithFormat:@"dreams/:%@", dreamId];
}

@end
