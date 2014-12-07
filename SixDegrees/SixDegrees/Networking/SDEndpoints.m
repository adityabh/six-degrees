//
//  SDEndpoints.m
//  SixDegrees
//
//  Created by Steven Wu on 2014-10-18.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

#import "SDEndpoints.h"

@implementation SDEndpoints

+ (NSString *)authWithFacebook {
    return @"sign_in_via_facebook";
}

+ (NSString *)fetchDreams {
    return @"dreams";
}

@end
